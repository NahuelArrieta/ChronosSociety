extends Control

# This signal can be used by the parent scene (e.g., a main scene)
# to know when to start the game.
signal start_game

# Called when the "Start Game" button is pressed.
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://levels/level.tscn")
	start_game.emit()
