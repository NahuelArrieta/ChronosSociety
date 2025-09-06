extends Node

var is_reverting = false

func _ready():
	start_log_timer()
	
func start_log_timer():
	# Start a timer to record the state every physics frame.
	var record_timer = Timer.new()
	record_timer.wait_time = Global.log_delay
	record_timer.autostart = true
	record_timer.connect("timeout", _on_record_timer_timeout)
	add_child(record_timer)

func _physics_process(delta):
	# Check if the revert time button is pressed to start the timer.
	if Input.is_action_just_pressed("ui_accept"):
		# Start the timer and make it repeat.
		is_reverting = true
		Global.revert_started.emit()
		
	# Check if the revert time button is released to stop the timer.
	if Input.is_action_just_released("ui_accept"):
		is_reverting = false
		Global.revert_stopped.emit()

func _on_record_timer_timeout():
	if is_reverting:
		return

	var time_travel_nodes = get_tree().get_nodes_in_group(Global.TIME_TRAVEL_GROUP)
	
	for node in time_travel_nodes:
		if node.has_method("record_state"):
			node.record_state()
