extends Area2D
@onready var asp: AnimatedSprite2D = $asp
@onready var csp: CollisionShape2D = $csp
@export var state:bool = true

@export var switches:Array[Area2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connectStateSchanged(get_children())
	connectStateSchanged(switches)

func connectStateSchanged(array):
	for c in array:
		if !c.is_in_group("Interactable"): continue
		c.stateChanged.connect(change)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		area.damage()

func change(x = null):
	state = !state
	asp.play("up" if state else "down")
	csp.set_deferred("disabled", !state)
