extends CanvasLayer

func _ready():
	hide_effect()
	Global.revert_started.connect(show_effect)
	Global.revert_stopped.connect(hide_effect)	

func show_effect(player):
	$ColorRect.visible = true
	
func hide_effect():
	$ColorRect.visible = false
