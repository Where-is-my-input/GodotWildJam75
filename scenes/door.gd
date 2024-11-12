extends Area2D
@onready var asp: AnimatedSprite2D = $asp
@onready var csp: CollisionShape2D = $csp

@export var state:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_children():
		if !c.is_in_group("Interactable"): continue
		c.stateChanged.connect(change)

func change(x = null):
	state = !state
	if state:
		asp.play("open")
	else:
		asp.play("closed")
	csp.set_deferred("disabled", state)
