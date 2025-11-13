class_name Player extends CharacterBody2D

const MOVE_SPEED: float = 64.0 # pixels per second
const STATE_DOWNGRADE_MAP: Dictionary[PlayerState, PlayerState] = {
    PlayerState.RUN_NORTH: PlayerState.IDLE_NORTH,
    PlayerState.RUN_EAST: PlayerState.IDLE_EAST,
    PlayerState.RUN_WEST: PlayerState.IDLE_WEST,
    PlayerState.RUN_SOUTH: PlayerState.IDLE_SOUTH
}


var state: PlayerState = PlayerState.IDLE_SOUTH

func _ready() -> void:
    pass

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
    var prev_state: PlayerState = state
    _update_movement_state()
    if state != prev_state:
        _update_animation()
    velocity = velocity.normalized() * MOVE_SPEED * delta
    var collision: KinematicCollision2D = move_and_collide(velocity)
    if collision:
        print("poof")

func _update_movement_state() -> void:
    velocity = Vector2.ZERO
    if Input.is_action_pressed("move_up"):
        velocity.y -= 1
        state = PlayerState.RUN_NORTH
    if Input.is_action_pressed("move_down"):
        velocity.y += 1
    if Input.is_action_pressed("move_right"):
        velocity.x += 1
    if Input.is_action_pressed("move_left"):
        velocity.x -= 1
    
    if velocity.y != 0:
        state = PlayerState.RUN_NORTH if velocity.y == -1 else PlayerState.RUN_SOUTH
    elif velocity.x != 0:
        state = PlayerState.RUN_EAST if velocity.x == 1 else PlayerState.RUN_WEST
    else:
        state = STATE_DOWNGRADE_MAP.get(state, PlayerState.IDLE_SOUTH)

func _update_animation() -> void:
    $AnimatedSprite2D.play(_state_name(state))

enum PlayerState {
    RUN_NORTH,
    RUN_EAST,
    RUN_WEST,
    RUN_SOUTH,
    IDLE_NORTH,
    IDLE_EAST,
    IDLE_WEST,
    IDLE_SOUTH
}

func _state_name(val: int) -> String:
    return PlayerState.keys()[val]