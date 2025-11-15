class_name Main extends Node

func _ready() -> void:
    GameManager.vehicle_spawner = $Stage/VehicleContainer/VehicleSpawnController
    GameManager.info_label = $InfoLabel
    GameManager.game_timer = $GameTimer
    GameManager.start()

