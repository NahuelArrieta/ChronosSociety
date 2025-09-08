extends Area2D

@export var groupId: int
@export var default: bool = true

func _ready() -> void:
	setStatus(default)
	Global.buttonChanged.connect(on_button_changed)

# This function is automatically called when a body enters the Area2D.
func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.PLAYER_GROUP):
		get_tree().paused = true
		$Audio.play()
		
		var timer = get_tree().create_timer(0.5, true) # `true` for `unpaused` timer (Godot 4)
		await timer.timeout
		
		get_tree().paused = false
		$Audio.stop()
		get_tree().reload_current_scene()
		pass
		
func on_button_changed(button_id: int, is_active: bool) -> void:
	# Check if the signal's ID matches this door's ID.
	if button_id == groupId:
		if is_active:  ## inversal
			setStatus(!default)
		else:
			setStatus(default)

func setStatus(value: bool):
	$CollisionShape2D.set_deferred("disabled", !value)
	$CollisionShape2D.visible = value
