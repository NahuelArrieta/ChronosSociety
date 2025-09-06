extends StaticBody2D

# This variable allows you to set the group ID in the Inspector
# so the door knows which button it should respond to.
@export var groupId: int

# A variable to store the original position of the door.
var original_position

# Get references to the child nodes
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

class Status:
	var color: Color
	var collision: bool

	func _init(color: Color = Color.WHITE, collision: bool = false) -> void:
		self.color = color
		self.collision = collision

# Declare a constant instance
var ACTIVE_STATUS := Status.new(Color.BLACK, true)
var INACTIVE_STATUS := Status.new(Color.GRAY, false)

func _ready():
	setStatus(ACTIVE_STATUS)
	
	Global.buttonChanged.connect(on_button_changed)

func on_button_changed(button_id: int, is_active: bool) -> void:
	# Check if the signal's ID matches this door's ID.
	if button_id == groupId:
		if is_active:  ## inversal
			setStatus(INACTIVE_STATUS)
		else:
			setStatus(ACTIVE_STATUS)

func setStatus(status: Status):
	collision_shape.set_deferred("disabled", !status.collision)
	sprite.modulate = status.color
