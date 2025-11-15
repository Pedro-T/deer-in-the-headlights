extends Node

var vehicle_spawner: VehicleSpawnController

func start() -> void:
    vehicle_spawner.start()

func game_over(ending: GameEnding) -> void:
    print("triggered")

enum GameEnding {
    RUN_OVER
}