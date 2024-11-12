extends CharacterBody2D

@export var direction:Vector2 = Vector2(1,1)
@export var speed:int = 5
@export var speedMultiplier:float = 1.5

func _physics_process(delta: float) -> void:
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	var collider = move_and_collide(velocity)
	
	if collider != null:
		var angle = collider.get_angle()
		if angle == 0:
			direction.y = -1
		elif angle > 2:
			direction.y = 1
		
		if angle > 1 && angle < 2:
			direction.x *= -1


func _on_area_2d_body_entered(body) -> void:
	speed *= speedMultiplier

func _on_area_2d_body_exited(body: Node2D) -> void:
	speed = speed / speedMultiplier
