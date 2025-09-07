extends Node

var is_reverting = false

const revert_time_inputs = [
	"REVERT_P1",
	"REVERT_P2",
] 

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
	for i in revert_time_inputs.size():
		var input = revert_time_inputs[i]
		var player = i +1
		
		if Input.is_action_just_pressed(input) and !is_reverting:
			is_reverting = true
			$Start.play()
			if !$Loop.playing:
				$Loop.play()
			Global.revert_started.emit(player)
		
		if Input.is_action_just_released(input):
			is_reverting = false
			$Loop.stop()
			$Stop.play()
			Global.revert_stopped.emit()

func _on_record_timer_timeout():
	if is_reverting:
		return

	var time_travel_nodes = get_tree().get_nodes_in_group(Global.TIME_TRAVEL_GROUP)
	
	for node in time_travel_nodes:
		if node.has_method("record_state"):
			node.record_state()
