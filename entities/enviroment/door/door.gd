extends StaticBody2D

# This variable allows you to set the group ID in the Inspector
# so the door knows which button it should respond to.
@export var groupId: int

# Get references to the child nodes
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

var _state_history = []
var is_reverting = false
var current_status: String

class Status:
	var color: Color
	var collision: bool

	func _init(color: Color = Color.WHITE, collision: bool = false) -> void:
		self.color = color
		self.collision = collision

# Declare a constant instance
var ACTIVE_STATUS := "ACTIVE"
var INACTIVE_STATUS := "INACTIVE"

var STATUSES : Dictionary[String, Status] =  {
	ACTIVE_STATUS: Status.new(Color.BLACK, true),
	INACTIVE_STATUS: Status.new(Color.GRAY, false),
}

func _ready():
	setStatus(ACTIVE_STATUS)
	
	Global.buttonChanged.connect(on_button_changed)
	Global.revert_started.connect(start_reverting)
	Global.revert_stopped.connect(stop_reverting)
	add_to_group(Global.TIME_TRAVEL_GROUP)

func _physics_process(delta):
	if is_reverting:
		revert_state() 

func on_button_changed(button_id: int, is_active: bool) -> void:
	# Check if the signal's ID matches this door's ID.
	if button_id == groupId:
		if is_active:  ## inversal
			setStatus(INACTIVE_STATUS)
		else:
			setStatus(ACTIVE_STATUS)

func setStatus(statusKey: String):
	if !STATUSES.has(statusKey):
		return
	current_status = statusKey
	var s: Status = STATUSES[statusKey]
	collision_shape.set_deferred("disabled", !s.collision)
	sprite.modulate = s.color
	
func record_state():
	var state = {
		"status": current_status,
	}
	_state_history.push_front(state)
	
	# Keep the history from getting too long.
	if _state_history.size() > Global._max_history_length:
		_state_history.pop_back()

func start_reverting(player):
	is_reverting = true

func stop_reverting():
	is_reverting = false

func revert_state():
	if _state_history.size() > 0:
		var state = _state_history.pop_front()

		setStatus(state.status)
		
		return true
	return false
