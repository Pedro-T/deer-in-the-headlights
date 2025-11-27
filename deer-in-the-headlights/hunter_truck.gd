extends Sprite2D

func toggle_lights() -> void:
    $Headlights.enabled = not $Headlights.enabled
