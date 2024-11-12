extends Node2D

@export var players:Array[Area2D]
@export var movements:int = 5
@export var nextStage:String = "res://scenes/stage_select.tscn"

var spawnP1:Vector2
var spawnP2:Vector2

var playersLeft = 2

func _ready() -> void:
	spawnP1 = players[0].global_position
	spawnP2 = players[1].global_position
	Global.setMoves(movements)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") && !players[0].moving && !players[1].moving:
		respawn()

func respawn():
	playersLeft = 2
	Global.setMoves(movements)
	players[0].respawn(spawnP1)
	players[1].respawn(spawnP2)

func playerLeft():
	playersLeft -= 1
	if playersLeft <= 0:
		Global.stagesCleared[Global.currentStage] = 1
		LoadManager.loadScene(nextStage)
