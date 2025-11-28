extends Area2D

const MOVE_SPEED: float = 60.0
const X_LIMIT: float = 80.00

var moving: bool = false
var move_total: float = 0.0

func _process(delta: float) -> void:
    if moving:
        var movement: float = MOVE_SPEED * delta
        position.x -= movement
        move_total += movement

        if move_total >= X_LIMIT:
            moving = false

func reset() -> void:
    moving = false
    move_total = false
    position = Vector2(410, 95)
    $Timer.start()

func kill_timer() -> void:
    $Timer.stop()

func _on_timer_timeout() -> void:
    moving = true
