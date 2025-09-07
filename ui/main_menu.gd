extends Control

# This signal can be used by the parent scene (e.g., a main scene)
# to know when to start the game.
signal start_game

# Called when the "Start Game" button is pressed.
func _on_play_button_pressed():
	# Emit the signal to tell the main scene to change to the game scene.
	print("Play button pressed!")
	start_game.emit()
