class_name VehicleGutter extends Area2D

func _on_area_entered(area: Area2D) -> void:
    if area is Vehicle:
        area.queue_free()
