extends CanvasLayer
@onready var label: Label = $Label

func _ready() -> void:
	Global.connect("moved", update)
	update(Global.movesAvailable)

func update(v):
	label.text = str(v)
