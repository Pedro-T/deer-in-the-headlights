class_name GameOverScreenSuccess extends Node2D

const GOAL_X_POS: float = 384.0
const DEER_CUTSCENE_SPEED: float = 80.0

const RUN_ANIMATION: String = "RUN_EAST"
const END_ANIMATION: String = "IDLE_EAST"

@onready var deer: AnimatedSprite2D = $CutsceneDeer
@onready var title_button: Button = $TitleScreenButton

var pos_reached: bool = false

func _ready() -> void:
    deer.play(RUN_ANIMATION)

func _process(delta: float) -> void:
    if pos_reached:
        return
    var new_pos: Vector2 = deer.position + Vector2(DEER_CUTSCENE_SPEED * delta, 0)
    if (new_pos.x >= GOAL_X_POS):
        new_pos = Vector2(GOAL_X_POS, new_pos.y)
        pos_reached = true
        deer.play(END_ANIMATION)
    deer.position = new_pos
