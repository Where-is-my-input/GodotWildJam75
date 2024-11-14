extends Control
@onready var button: Button = $Button

func _on_button_pressed() -> void:
	LoadManager.loadScene("res://scenes/main_menu/main_menu.tscn")

func _ready() -> void:
	button.grab_focus()
