extends CharacterBody2D

@onready var virtual_controller: Node = $virtual_controller

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var reflection:int = 1

func _physics_process(delta: float) -> void:

	if virtual_controller.direction:
		velocity = Vector2(reflection, 1) * virtual_controller.direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
