extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite_2d.rotate(-1)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		area.leave()
		get_parent().playerLeft()
