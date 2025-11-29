class_name VehicleSpawnController extends Node

@onready var timer: Timer = $SpawnIntervalTimer

@export var spawn_interval: float = 0.2

const ANIMATIONS_PATH: String = "res://vehicle/animations"
const VARIANT: String = "L_rain"

static var animations: Array[SpriteFrames] = []

var nodes: Array[VehicleSpawnNode] = []

func _ready() -> void:
    for node: VehicleSpawnNode in get_children().filter(func(child: Node) -> bool: return child is VehicleSpawnNode):
        nodes.append(node)
    if animations.is_empty():
        _load_animations()

func _load_animations() -> void:
    for file: String in ResourceLoader.list_directory(ANIMATIONS_PATH):
        if not file.ends_with(".tres"):
            continue
        var anim: SpriteFrames = load(ANIMATIONS_PATH.path_join(file))
        if anim:
            animations.append(anim)

func _on_spawn_interval_timer_timeout() -> void:
    nodes.pick_random().spawn(animations.pick_random(), VARIANT, 300.0)

func start() -> void:
    timer.wait_time = spawn_interval
    timer.start()

func stop() -> void:
    timer.stop()


