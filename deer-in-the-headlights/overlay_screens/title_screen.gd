class_name TitleScreen extends Node2D

const SCROLL_SPEED: Vector2 = Vector2(-100.0, 0.0)

@onready var start_button: Button = $StartButton

func play_animation() -> void:
    $Parallax2D.autoscroll = SCROLL_SPEED
    $TitleDeer.play()
    $TitleCar.play()

func stop_animation() -> void:
    $Parallax2D.autoscroll = Vector2.ZERO
    $TitleDeer.stop()
    $TitleCar.stop()

func _on_instructions_button_pressed() -> void:
    $InstructionsPopup.popup()# Replace with function body.

func _on_credits_button_pressed() -> void:
    $CreditsPopup.popup()
