shader_type canvas_item;

uniform vec4 u_ambient_color : source_color = vec4(0.05, 0.05, 0.1, 1.0);
uniform float u_headlight_range = 300.0;
uniform float u_headlight_width_factor = 0.5;
uniform float u_headlight_intensity = 0.8;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

#define MAX_CARS 60
uniform int u_num_cars = 0;
uniform vec3 u_car_data[MAX_CARS];

void fragment() {
    vec4 base_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    vec4 final_color = mix(base_color, u_ambient_color, 0.9);
    vec2 current_pixel_pos = FRAGCOORD.xy;
    float total_light_contribution = 0.0;

    for (int i = 0; i < u_num_cars; i++) {
        vec3 car_data = u_car_data[i];
        vec2 car_pos = car_data.xy;
        float car_rot = car_data.z;

        vec2 relative_pos = current_pixel_pos - car_pos;

        mat2 rot_matrix = mat2(
            vec2(cos(car_rot), -sin(car_rot)),
            vec2(sin(car_rot), cos(car_rot))
        );
        vec2 rotated_pos = rot_matrix * relative_pos;

        float compressed_y = rotated_pos.y / u_headlight_width_factor;

        float directional_dist = length(vec2(rotated_pos.x, compressed_y));

        if (rotated_pos.x > 0.0 && directional_dist < u_headlight_range) {

            float falloff = 1.0 - (directional_dist / u_headlight_range);

            float light_falloff = pow(falloff, 4.0);

            total_light_contribution += light_falloff * u_headlight_intensity;
        }
    }

    total_light_contribution = clamp(total_light_contribution, 0.0, 1.0);
    COLOR = mix(final_color, base_color, total_light_contribution);
}