class_name Main extends Node

func _ready() -> void:
    GameManager.vehicle_spawner = $Stage/VehicleContainer/VehicleSpawnController
    GameManager.info_label = $CanvasLayer/InfoLabel
    GameManager.game_timer = $GameTimer
    GameManager.firing_timer = $FiringTimer
    GameManager.screens = $CanvasLayer/Screens
    GameManager.player = $Stage/PlayerContainer/Player
    GameManager.hunter = $"Stage/Hunter-Bush"
    GameManager.blocker_vehicle = $Stage/BlockingVehicle
    GameManager.hunter_truck = $Stage/BackgroundDetails/HunterTruck
    GameManager.stage = $Stage
    GameManager.setup()
