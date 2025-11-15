class_name Vehicle extends Area2D

@export var sprite_frames: SpriteFrames

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var speed: float = 200.00 # pixels per second
@export var move_direction: int = 1 # 1 for right, 0 for left
var animation_name: String = ""

func setup(_sprite_frames: SpriteFrames, _animation_name: String, _move_direction: int, _speed: float) -> void:
	sprite_frames = _sprite_frames
	animation_name = _animation_name
	move_direction = _move_direction
	speed = _speed

func _ready() -> void:
	sprite.sprite_frames = sprite_frames
	collision_shape.shape.size = sprite.sprite_frames.get_frame_texture(animation_name, 0).get_size()
	sprite.play(animation_name)
	sprite.flip_h = move_direction == 1

func _process(delta: float) -> void:
	position.x += speed * delta * move_direction


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.game_over(GameManager.GameEnding.RUN_OVER)
