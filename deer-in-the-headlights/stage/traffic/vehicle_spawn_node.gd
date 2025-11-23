class_name VehicleSpawnNode extends Node

@export var direction: SpawnDirection = SpawnDirection.LEFT
@onready var timer: Timer = $CooldownTimer

var is_active: bool = true

func spawn(sprite: SpriteFrames, variant: String, speed: float) -> void:
    if not is_active:
        return
    var vehicle: Vehicle = preload("res://vehicle/Vehicle.tscn").instantiate()
    vehicle.global_position = self.global_position
    vehicle.setup(sprite, variant, 1 if direction == SpawnDirection.RIGHT else -1, speed)
    add_sibling(vehicle)
    vehicle.add_to_group("vehicles")
    _enter_cooldown(sprite.get_frame_texture(variant, 0).get_size().x / speed * 1.7)

func _enter_cooldown(time: float) -> void:
    timer.wait_time = time
    timer.start()
    is_active = false

func _on_cooldown_timer_timeout() -> void:
    is_active = true

enum SpawnDirection {
    LEFT,
    RIGHT
}