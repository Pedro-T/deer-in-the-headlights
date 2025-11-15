extends Node

var vehicle_spawner: VehicleSpawnController
var game_timer: Timer
var info_label: Label

func start() -> void:
    vehicle_spawner.start()

func game_over(_ending: GameEnding) -> void:
    print("triggered")

enum GameEnding {
    RUN_OVER
}