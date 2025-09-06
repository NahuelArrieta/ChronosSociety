extends Node

# Define the name of the group that all time-travelable objects will belong to.
# This makes it easy to find them.
const TIME_TRAVEL_GROUP = "time_travelable"

# This variable controls how often the reversion happens. A smaller value
# makes the rewind faster, and a larger value makes it slower.
@export var log_delay = 0.05

var is_reverting = false

func _ready():
	# Start a timer to record the state every physics frame.
	# This ensures we have a smooth history.
	var record_timer = Timer.new()
	record_timer.wait_time = log_delay
	record_timer.autostart = true
	record_timer.connect("timeout", _on_record_timer_timeout)
	add_child(record_timer)


func _physics_process(delta):
	# Check if the revert time button is pressed to start the timer.
	if Input.is_action_just_pressed("ui_up"):
		# Start the timer and make it repeat.
		is_reverting = true
		var time_travel_nodes = get_tree().get_nodes_in_group(TIME_TRAVEL_GROUP)
	
		for node in time_travel_nodes:
			if node.has_method("revert_state"):
				node.start_reverting()
		
	# Check if the revert time button is released to stop the timer.
	if Input.is_action_just_released("ui_up"):
		is_reverting = false
		var time_travel_nodes = get_tree().get_nodes_in_group(TIME_TRAVEL_GROUP)
	
		for node in time_travel_nodes:
			if node.has_method("revert_state"):
				node.stop_reverting()

func _on_record_timer_timeout():
	if is_reverting:
		return
		
	# Get all the nodes in the "time_travelable" group.
	var time_travel_nodes = get_tree().get_nodes_in_group(TIME_TRAVEL_GROUP)
	
	# Iterate over each node and call its "record_state" function.
	for node in time_travel_nodes:
		# We check if the node has the method before calling it,
		# which is the Godot way of handling "interfaces".
		if node.has_method("record_state"):
			node.record_state()
