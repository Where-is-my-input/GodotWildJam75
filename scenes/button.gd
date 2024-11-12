extends Area2D
@onready var asp: AnimatedSprite2D = $asp

@export var state:bool = false

signal stateChanged

func _ready() -> void:
	setAnimation()

func interact(dir = null):
	state = !state
	stateChanged.emit(state)
	setAnimation()

func setAnimation():
	asp.play("down" if state else "up")
