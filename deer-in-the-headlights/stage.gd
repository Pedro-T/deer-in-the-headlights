extends Node

func start_all() -> void:
    $Tractor.start()
    $Tractor2.start()

func reset() -> void:
    $Tractor.clear()
    $Tractor2.clear()
    for n in $VehicleContainer/VehicleSpawnController.get_children():
        if n is Vehicle:
            n.queue_free()
