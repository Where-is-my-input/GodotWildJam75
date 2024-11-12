extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $audio

@export var state:bool = false
var defaultState:bool
var interacted:bool = false
signal stateChanged

func _ready() -> void:
	defaultState = state
	Global.connect("restart", restart)
	Global.connect("undo", undo)
	setAnimation()

func interact(dir = null):
	interacted = true
	state = !state
	stateChanged.emit(state)
	setAnimation()
	audio.play()

func setAnimation():
	animation_player.play("turn_on" if state else "turn_off")

func restart():
	interacted = false
	state = defaultState
	setAnimation()

func undo():
	if !interacted: return
	interacted = false
	interact()
