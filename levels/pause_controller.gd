extends Node


var pause_menu_scene = preload("res://ui/pause_menu.tscn")
var pause_menu_instance = null

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		show_pause_menu()
	else:
		hide_pause_menu()

func show_pause_menu():
	if pause_menu_instance == null:
		pause_menu_instance = pause_menu_scene.instantiate()
		add_child(pause_menu_instance)
	
func hide_pause_menu():
	if pause_menu_instance != null:
		pause_menu_instance.queue_free()
		pause_menu_instance = null

func _unhandled_input(event):
	if event.is_action_pressed("PAUSE"):
		toggle_pause()
