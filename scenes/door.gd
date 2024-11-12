extends Area2D
@onready var asp: AnimatedSprite2D = $asp
@onready var csp: CollisionShape2D = $csp

@export var state:bool = false
var defaultState:bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defaultState = state
	Global.connect("restart", restart)
	for c in get_children():
		if !c.is_in_group("Interactable"): continue
		c.stateChanged.connect(change)

func change(x = null):
	state = x
	setState()

func setState():
	asp.play("open" if state else "closed")
	csp.set_deferred("disabled", state)

func restart():
	state = defaultState
	setState()
