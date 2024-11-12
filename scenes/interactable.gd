extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var state:bool = false

signal stateChanged

func _ready() -> void:
	setAnimation()

func interact(dir):
	state = !state
	stateChanged.emit(state)
	animation_player.play("turn_on" if state else "turn_off")

func setAnimation():
	animation_player.play("turn_on" if state else "turn_off")
