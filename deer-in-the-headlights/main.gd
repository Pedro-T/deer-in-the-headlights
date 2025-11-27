class_name Main extends Node

func _ready() -> void:
    GameManager.vehicle_spawner = $Stage/VehicleContainer/VehicleSpawnController
    GameManager.info_label = $InfoLabel
    GameManager.game_timer = $GameTimer
    GameManager.firing_timer = $FiringTimer
    GameManager.screens = $Screens
    GameManager.player = $Stage/PlayerContainer/Player
    GameManager.hunter = $"Stage/Hunter-Bush"
    GameManager.night_canvas = $Stage/Nighttime
    GameManager.blocker_vehicle = $Stage/BlockingVehicle
    GameManager.weather = $Stage/Weather
    GameManager.setup()
