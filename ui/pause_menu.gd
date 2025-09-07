extends Control

func _on_ResumeButton_pressed():
	get_tree().paused = false
	queue_free()

func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
