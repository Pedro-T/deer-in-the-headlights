extends Node

var vehicle_spawner: VehicleSpawnController
var game_timer: Timer
var firing_timer: Timer
var info_label: Label
var state: GameState = GameState.PLAY
var screens: Screens
var player: Player
var hunter: Hunter
var night_canvas: ColorRect
var shader_material: ShaderMaterial
var car_data: PackedVector3Array = []

const MAX_CARS: int = 60 # for headlight calc

func setup() -> void:
    game_timer.timeout.connect(game_over.bind(GameEnding.SHOT))
    firing_timer.timeout.connect(trigger_shot)
    screens.show_title()

func _process(_delta: float) -> void:
    if not shader_material:
        shader_material = night_canvas.material as ShaderMaterial
    
    _update_headlights()

    match state:
        GameState.PLAY:
            _update_timer_display()

func _update_headlights() -> void:
    var cars: Array[Node] = get_tree().get_nodes_in_group("vehicles")
    var car_positions: Array[Vector3] = []
    for car: Vehicle in cars:
        if not is_instance_valid(car):
            continue
        if car is not Vehicle:
            continue
        
        var position: Vector2 = car.global_position
        var direction: int = car.move_direction
        var rotation: float = car.rotation
        if direction == -1:
            rotation += PI
        var car_pos_rot: Vector3 = Vector3(position.x, position.y, rotation)
        car_positions.append(car_pos_rot)
        if car_positions.size() >= MAX_CARS:
            break
        
    shader_material.set_shader_parameter("u_num_cars", car_positions.size())
    shader_material.set_shader_parameter("u_car_data", car_positions)



func _update_timer_display() -> void:
    var time: int = floor(game_timer.time_left)
    info_label.text = "%02d" % time

func start() -> void:
    night_canvas.visible = true
    player.intro()
    hunter.assign_target(player)
    vehicle_spawner.start()
    game_timer.start()
    firing_timer.start()
    state = GameState.PLAY

func game_over(ending: GameEnding) -> void:
    if state == GameState.END:
        return
    state = GameState.END
    info_label.text = "ESCAPED" if ending == GameEnding.ESCAPED else "DEAD"
    _halt_spawns()
    game_timer.stop()
    firing_timer.stop()
    screens.show_game_over(ending)
    night_canvas.visible = false

func trigger_shot() -> void:
    hunter.fire()
    firing_timer.start()

func _halt_spawns() -> void:
    vehicle_spawner.stop()

enum GameEnding {
    RUN_OVER,
    SHOT,
    ESCAPED
}

enum GameState {
    PLAY,
    INTRO,
    END
}
