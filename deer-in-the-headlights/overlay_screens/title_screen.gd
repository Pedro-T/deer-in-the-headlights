class_name TitleScreen extends Node2D

const SCROLL_SPEED: Vector2 = Vector2(-100.0, 0.0)

func play_animation() -> void:
	$Parallax2D.autoscroll = SCROLL_SPEED
	$TitleDeer.play()
	$TitleCar.play()

func stop_animation() -> void:
	$Parallax2D.autoscroll = Vector2.ZERO
	$TitleDeer.stop()
	$TitleCar.stop()
