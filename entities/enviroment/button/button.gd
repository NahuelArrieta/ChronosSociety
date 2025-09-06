extends Area2D

@export var groupId: int

var active = false

func _ready():
	Global.revert_stopped.connect(func(): set_active(active))

func _on_body_entered(body: Node2D) -> void:
	set_active(true)
	
func _on_body_exited(body: Node2D) -> void:
	set_active(false)
	
func set_active(value: bool):
	if active == value:
		return
	
	active = value
	
	## Play animations
	$Animation.play("middle")
	if active:
		$Animation.play("pressed")
	else:
		$Animation.play("unpresed")
	Global.buttonChanged.emit(groupId, active)
	
