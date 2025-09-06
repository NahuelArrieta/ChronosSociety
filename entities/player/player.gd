extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -450.0

var gravity = 980.0 ## TODO

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"): # TODO
		velocity.y = jump_velocity 

	var direction = Input.get_axis("ui_left", "ui_right") # TODO
	velocity.x = direction * speed

	move_and_slide()
