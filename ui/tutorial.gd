extends Node2D

@export var id: int
@export var sprite: String

func _ready() -> void:
	$Animation.play(sprite)
	$Animation.visible = false
	Global.tutorial.connect(setSprite)
	
func setSprite(triggerId: int, active: bool):
	if triggerId != id:
		return
	if active:
		$Animation.visible = true
	else:
		$Animation.visible = false
