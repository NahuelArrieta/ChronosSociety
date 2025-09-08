extends Node


var game_won_menu_scene = preload("res://ui/winning_screen.tscn")
var game_won_menu_instance = null

func _ready() -> void:
	Global.game_won.connect(show_game_won)

func show_game_won():
	if game_won_menu_instance == null:
		game_won_menu_instance = game_won_menu_scene.instantiate()
		add_child(game_won_menu_instance)
		var tween = get_tree().create_tween()
		tween.tween_property(game_won_menu_instance, "modulate", Color(1, 1, 1, 1), 1.0)
	
	
