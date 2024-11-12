extends Button

func _ready() -> void:
	grab_focus()

func _on_pressed() -> void:
	LoadManager.loadScene("res://scenes/main_menu/main_menu.tscn")
