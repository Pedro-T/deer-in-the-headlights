class_name Screens extends Node

func show_game_over(_ending: GameManager.GameEnding) -> void:
    $GameOverScreen.visible = true

func show_title() -> void:
    $TitleScreen.visible = true

func hide() -> void:
    $GameOverScreen.visible = false
    $TitleScreen.visible = false




func show_instructions() -> void:
    pass

func show_credits() -> void:
    pass


# button handlers
func _on_credits_button_pressed() -> void:
    show_credits()

func _on_instructions_button_pressed() -> void:
    show_instructions()

func _on_start_button_pressed() -> void:
    hide()
    GameManager.start()

func _on_title_return_button_pressed() -> void:
    hide()
    GameManager.start()

