class_name Tractor extends Area2D

const MOVE_SPEED: float = 50.0
const MOVE_LIMIT: float = 1000.0
const MOVE_DIRECTION: int = -1
@onready var RESET_POS: Vector2 = position

var movement: float = 0
var moving: bool = false

func _process(delta: float) -> void:
    if not moving:
        return
    var xmov: float = MOVE_SPEED * MOVE_DIRECTION * delta
    movement += xmov
    position += Vector2(xmov, 0)
    if movement >= MOVE_LIMIT:
        moving = false
        visible = false    

func _reset() -> void:
    position = RESET_POS

func start() -> void:
    _reset()
    visible = true
    moving = true
    $Sprite.play()

