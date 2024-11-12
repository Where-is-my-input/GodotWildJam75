extends Area2D
@onready var ray: RayCast2D = $RayCast2D
var moving = false
var tile_size = 64

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func interact(dir: Vector2):
	if moving: return
	ray.target_position = dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += dir * tile_size
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + dir *    tile_size, 1.0/3).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("Interactable"):
			collider.move(dir)
