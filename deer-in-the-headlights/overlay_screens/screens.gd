class_name Screens extends Node

func show_game_over(_ending: GameManager.GameEnding) -> void:
    $GameOverScreen.visible = true

func hide_game_over() -> void:
    $GameOverScreen.visible = false

func _on_title_return_button_pressed() -> void:
    hide_game_over()
    GameManager.start()
