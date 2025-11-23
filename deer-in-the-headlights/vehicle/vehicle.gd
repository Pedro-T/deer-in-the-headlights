class_name Vehicle extends Area2D

@export var sprite_frames: SpriteFrames

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var speed: float = 200.00 # pixels per second
@export var move_direction: int = 1 # 1 for right, 0 for left
var animation_name: String = ""
var headlight_offset: float = 0

func setup(_sprite_frames: SpriteFrames, _animation_name: String, _move_direction: int, _speed: float) -> void:
	sprite_frames = _sprite_frames
	animation_name = _animation_name
	move_direction = _move_direction
	speed = _speed

func _ready() -> void:
	sprite.sprite_frames = sprite_frames

	if move_direction == 1: #right-side movement. Look for an R_ variant, or just flip the animation
		var right_animation: String = "R_" + animation_name.substr(2)
		if sprite.sprite_frames.has_animation(right_animation):
			animation_name = right_animation
		else:
			sprite.flip_h = true

	# use the height size from the resource metadata if available or just sprite y height
	var sprite_size: Vector2 = sprite.sprite_frames.get_frame_texture(animation_name, 0).get_size()
	headlight_offset = sprite_size.x / 2 + 1
	var meta_height: Variant = sprite_frames.get_meta("hitbox_height", sprite_size.y)
	var height: float = meta_height if meta_height is float else sprite_size.y
	collision_shape.shape.size = Vector2(sprite_size.x, height)
	collision_shape.position = Vector2(0, (sprite_size.y - height) / 2)
	sprite.play(animation_name)

	position = position + Vector2(0, randi_range(-20, 0)) # shift the cars around a little so they're not perfectly in line every time

func _process(delta: float) -> void:
	position.x += speed * delta * move_direction


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.game_over(GameManager.GameEnding.RUN_OVER)
