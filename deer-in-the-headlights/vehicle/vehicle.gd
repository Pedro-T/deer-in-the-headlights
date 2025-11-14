class_name Vehicle extends Area2D

@export var sprite_frames: SpriteFrames

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var speed: float = 200.00 # pixels per second
@export var move_direction: int = 1 # 1 for right, 0 for left

func _ready() -> void:
	var used_animation: String = "drive_wipers"
	if sprite:
		sprite.sprite_frames = sprite_frames
		collision_shape.shape.size = sprite.sprite_frames.get_frame_texture(used_animation, 0).get_size()
	sprite.play(used_animation)
	sprite.flip_h = move_direction == 1

func _process(delta: float) -> void:
	position.x += speed * delta * move_direction


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.game_over(GameManager.GameEnding.RUN_OVER)
