extends Area2D

@export var id: int

func _on_body_entered(body: Node2D) -> void:
	Global.tutorial.emit(id, true)


func _on_body_exited(body: Node2D) -> void:
	Global.tutorial.emit(id, false)
