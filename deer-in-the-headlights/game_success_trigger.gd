extends Area2D


func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        GameManager.game_over(GameManager.GameEnding.ESCAPED)