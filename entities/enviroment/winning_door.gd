
extends Area2D



var players_in_area: int = 0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D):
	if body.is_in_group(Global.PLAYER_GROUP):
		players_in_area += 1
	
	_check_win_condition()

func _on_body_exited(body: Node2D):
	if body.is_in_group(Global.PLAYER_GROUP):
		players_in_area -= 1
	
	_check_win_condition()

func _check_win_condition():
	if players_in_area == 0:
		$Sprite.play("closed")
	elif players_in_area == 1:
		$Sprite.play("open")
	elif  players_in_area == 2:
		Global.game_won.emit()
