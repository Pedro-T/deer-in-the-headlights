class_name Screens extends Node

func show_game_over(_ending: GameManager.GameEnding) -> void:
    $GameOverScreen.visible = true

func show_title() -> void:
    $TitleScreen.play_animation()
    $TitleScreen.visible = true

func hide() -> void:
    $GameOverScreen.visible = false
    $TitleScreen.visible = false
    $TitleScreen.stop_animation()

func show_instructions() -> void:
    $TitleScreen/InstructionsPopup.popup()

func show_credits() -> void:
    $TitleScreen/CreditsPopup.popup()


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

