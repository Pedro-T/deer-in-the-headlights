extends Node

@onready var night_mask: CanvasModulate = $Nighttime
@onready var weather: Node = $Weather

func day() -> void:
    night_mask.visible = false

func night() -> void:
    weather.start()
    night_mask.visible = true

func start_all(is_night: bool) -> void:
    @warning_ignore("standalone_ternary")
    night() if is_night else day()
    $Tractor.start()
    $Tractor2.start()

func reset() -> void:
    $Tractor.clear()
    $Tractor2.clear()
    for n in $VehicleContainer/VehicleSpawnController.get_children():
        if n is Vehicle:
            n.queue_free()
