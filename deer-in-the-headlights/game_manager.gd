extends Node

var vehicle_spawner: VehicleSpawnController
var game_timer: Timer
var firing_timer: Timer
var info_label: Label
var state: GameState = GameState.PLAY
var screens: Screens
var player: Player
var hunter: Hunter
var night_canvas: CanvasModulate
var blocker_vehicle: Node2D
var weather: Node
var hunter_truck: Node
var night_mode: bool = true
var stage: Node

const MAX_CARS: int = 60 # for headlight calc

func setup() -> void:
    game_timer.timeout.connect(game_over.bind(GameEnding.SHOT))
    firing_timer.timeout.connect(trigger_shot)
    screens.show_title()

func _process(_delta: float) -> void:
    match state:
        GameState.PLAY:
            _update_timer_display()

func _update_timer_display() -> void:
    var time: int = floor(game_timer.time_left)
    info_label.text = "%02d" % time

func start() -> void:
    night_canvas.visible = night_mode
    blocker_vehicle.reset()
    player.intro()
    hunter.assign_target(player)
    vehicle_spawner.start()
    game_timer.start()
    firing_timer.start()
    hunter_truck.toggle_lights()
    stage.start_all()
    info_label.visible = true

    state = GameState.PLAY
    weather.start()

func game_over(ending: GameEnding) -> void:
    if state == GameState.END:
        return
    state = GameState.END
    if ending == GameEnding.RUN_OVER:
        $CrashEffectPlayer.play()
    info_label.text = "ESCAPED" if ending == GameEnding.ESCAPED else "DEAD"
    player.hide()
    #hunter_truck.toggle_lights()
    screens.show_game_over(ending)
    await screens.transition_up
    _clear_stage()
    blocker_vehicle.kill_timer()
    weather.stop()
    game_timer.stop()
    firing_timer.stop()
    
    night_canvas.visible = false
    info_label.visible = false

func trigger_shot() -> void:
    hunter.fire()
    firing_timer.start()

func _clear_stage() -> void:
    vehicle_spawner.stop()
    stage.reset()

enum GameEnding {
    RUN_OVER,
    SHOT,
    ESCAPED
}

enum GameState {
    PLAY,
    INTRO,
    END
}
