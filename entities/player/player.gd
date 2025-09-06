extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -450.0

## Input map
@export var left_action: String = "LEFT_P1"
@export var right_action: String = "RIGHT_P1"
@export var jump_action: String = "JUMP_P1"

var is_reverting = false
var _state_history = []

func _ready():
	Global.revert_started.connect(start_reverting)
	Global.revert_stopped.connect(stop_reverting)
	add_to_group(Global.TIME_TRAVEL_GROUP)

func _physics_process(delta):
	if is_reverting:
		revert_state() 

	if not is_on_floor():
		velocity.y += Global.gravity * delta
	
	if is_on_floor() and Input.is_action_just_pressed(jump_action):
		velocity.y = jump_velocity 

	var direction = Input.get_axis(left_action, right_action) 
	velocity.x = direction * speed

	move_and_slide()

func record_state():
	var state = {
		"position": position,
		"velocity": velocity,
	}
	_state_history.push_front(state)
	
	# Keep the history from getting too long.
	if _state_history.size() > Global._max_history_length:
		_state_history.pop_back()
		
func start_reverting():
	is_reverting = true

func stop_reverting():
	is_reverting = false

func revert_state():
	if _state_history.size() > 0:
		var state = _state_history.pop_front()
		position = state.position
		
		if _state_history.size() == 0:
			velocity = state.velocity

		return true
	return false
