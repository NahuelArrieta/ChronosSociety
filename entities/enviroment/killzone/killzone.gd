extends Area2D

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
		
