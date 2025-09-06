extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -450.0

var gravity = 980.0 ## TODO
var is_reverting = false

# This is the list of states that will be recorded for time travel.
# We'll store a dictionary for each state with the player's position and velocity.
var _state_history = []
var _max_history_length = 600 # Store up to 10 seconds of history (assuming 60 FPS)


func _ready():
	add_to_group("time_travelable")

func _physics_process(delta):
	
	if is_reverting:
		revert_state()

	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"): # TODO
		velocity.y = jump_velocity 

	var direction = Input.get_axis("ui_left", "ui_right") # TODO
	velocity.x = direction * speed

	move_and_slide()

# This function will be called by the master controller to record the player's state.
func record_state():
	var state = {
		"position": position,
		"velocity": velocity,
	}
	_state_history.push_front(state)
	
	# Keep the history from getting too long.
	if _state_history.size() > _max_history_length:
		_state_history.pop_back()
		
func start_reverting():
	is_reverting = true

func stop_reverting():
	is_reverting = false


# This function will be called by the master controller to revert the state.
func revert_state():
	if _state_history.size() > 0:
		var state = _state_history.pop_front()
		position = state.position
		
		if _state_history.size() == 0:
			velocity = state.velocity

		return true
	return false
