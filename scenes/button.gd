extends Area2D
@onready var asp: AnimatedSprite2D = $asp
@onready var audio: AudioStreamPlayer2D = $audio
@export var state:bool = false

signal stateChanged

func _ready() -> void:
	setAnimation()

func interact(dir = null):
	state = !state
	stateChanged.emit(state)
	audio.play()
	setAnimation()

func setAnimation():
	asp.play("down" if state else "up")
