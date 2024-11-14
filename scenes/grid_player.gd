extends Area2D
@onready var vc: Node = $virtual_controller
@onready var ray: RayCast2D = $RayCast2D
@export var reflection:int = 1
@onready var asp: AnimatedSprite2D = $asp
const DEAD_BODY = preload("res://scenes/dead_body.tscn")
var tile_size = 64
var moving = false
var left = false
var facing = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _physics_process(delta: float) -> void:
	if vc.direction && !moving && !left:
		move(vc.direction)
		#animate(vc.direction)

func move(dir: Vector2):
	dir.x *= reflection
	var moveTo = Vector2(dir.x, 0) if dir.x else Vector2(0, dir.y)
	animate(moveTo)
	ray.target_position = moveTo * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		if Global.movesAvailable <= 0: return
		#position += dir * tile_size
		var tween = create_tween()
		tween.tween_property(self, "position", position + moveTo * tile_size, 1.0/3).set_trans(Tween.TRANS_SINE)
		moving = true
		Global.consumeMove()
		await tween.finished
		moving = false
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("Interactable"):
			collider.interact(moveTo)
		moving = true
		await get_tree().create_timer(1.0/3).timeout
		moving = false
	asp.pause()
	asp.set_frame(0 if randi_range(0,1) == 0 else 2)

func animate(dir: Vector2):
	if facing != dir.x && dir.x != 0:
		print("refl: ", reflection, "facing: ", facing)
		facing = dir.x
		asp.scale.x *= -1
	match dir:
		Vector2.UP:
			asp.play("up")
		Vector2.DOWN:
			asp.play("down")
		Vector2.LEFT:
			asp.play("left")
		Vector2.RIGHT:
			asp.play("right")
		_:
			asp.play("right")

func damage():
	left = true
	asp.visible = false
	var body = DEAD_BODY.instantiate()
	body.global_position = global_position
	add_sibling(body)

func leave():
	left = true
	asp.visible = false

func respawn(pos):
	global_position = pos
	left = false
	asp.visible = true
