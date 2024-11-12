extends Control
@onready var btnPlay: Button = $vBox/play

@export var play:PackedScene
@export var options:PackedScene
@export var credits:PackedScene

func _ready() -> void:
	btnPlay.grab_focus()

func _on_play_pressed() -> void:
	LoadManager.loadScene(play.resource_path)

func _on_options_pressed() -> void:
	LoadManager.loadScene(options.resource_path)
	
func _on_credits_pressed() -> void:
	LoadManager.loadScene(credits.resource_path)
