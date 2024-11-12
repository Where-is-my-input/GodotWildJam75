extends Node

const DEBUGGER = preload("res://scenes/node/debugger/debugger.tscn")

var movesAvailable:int = 5
var currentStage:int = 0

var stagesCleared:Array[int]

signal moved

func _ready() -> void:
	add_child(DEBUGGER.instantiate())
	for i in 25:
		stagesCleared.push_back(0)

func consumeMove():
	movesAvailable -= 1
	moved.emit(movesAvailable)

func setMoves(v):
	movesAvailable = v
	moved.emit(movesAvailable)
