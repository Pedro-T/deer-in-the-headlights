class_name Screens extends Node

var title_scene: PackedScene = preload("res://overlay_screens/TitleScreen.tscn")
var game_over_success_scene: PackedScene = preload("res://overlay_screens/GameOverScreenSuccess.tscn")
var game_over_runover_scene: PackedScene = preload("res://overlay_screens/GameOverRoadkillScreen.tscn")
var game_over_hunted_scene: PackedScene = preload("res://overlay_screens/GameOverHuntedScreen.tscn")

func show_game_over(ending: GameManager.GameEnding) -> void:
    $AnimationPlayer.play("mask_up")
    await $AnimationPlayer.animation_finished
    var screen: Node2D
    match ending:
        GameManager.GameEnding.ESCAPED:
            screen = game_over_success_scene.instantiate()
        GameManager.GameEnding.RUN_OVER:
            screen = game_over_runover_scene.instantiate()
        GameManager.GameEnding.SHOT:
            screen = game_over_hunted_scene.instantiate()
    $Container.add_child(screen)
    screen.title_button.connect("pressed", reset_title)
    $AnimationPlayer.play("mask_down")

func show_title() -> void:
    var title: Node2D = title_scene.instantiate()
    $Container.add_child(title)
    title.start_button.connect("pressed", start_game)
    title.play_animation()

func hide() -> void:
    for child in $Container.get_children():
        child.queue_free()

func start_game() -> void:
    hide()
    GameManager.start()

func reset_title() -> void:
    hide()
    show_title()
    $AnimationPlayer.play("mask_down")
