class_name Hunter extends Node2D

@onready var bush: AnimatedSprite2D = $Bush
@onready var rifle: AnimatedSprite2D = $Rifle

var target_entity: Player

func _onready() -> void:
    pass

func _process(_delta: float) -> void:
    if target_entity:
        var angle: float = global_position.angle_to_point(target_entity.global_position)
        rifle.rotation = angle + PI / 2


func fire() -> void:
    # todo play sound
    rifle.play("shoot")
    await rifle.animation_finished
    rifle.play("static")

func assign_target(_target_entity: Player) -> void:
    target_entity = _target_entity
