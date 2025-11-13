extends Node

func game_over(ending: GameEnding) -> void:
    print("triggered")

enum GameEnding {
    RUN_OVER
}