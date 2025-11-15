extends Node

var vehicle_spawner: VehicleSpawnController
var game_timer: Timer
var info_label: Label
var state: GameState = GameState.PLAY
var screens: Screens
var player: Player

func setup() -> void:
	game_timer.timeout.connect(game_over.bind(GameEnding.SHOT))

func _process(_delta: float) -> void:
	match state:
		GameState.PLAY:
			_update_timer_display()

func _update_timer_display() -> void:
	var time: int = floor(game_timer.time_left)
	info_label.text = "%02d" % time

func start() -> void:
	player.intro()
	vehicle_spawner.start()
	game_timer.start()

func game_over(_ending: GameEnding) -> void:
	state = GameState.END
	info_label.text = "DEAD"
	_halt_spawns()
	screens.show_game_over(_ending)

func _halt_spawns() -> void:
	vehicle_spawner.stop()

enum GameEnding {
	RUN_OVER,
	SHOT
}

enum GameState {
	PLAY,
	INTRO,
	END
}
