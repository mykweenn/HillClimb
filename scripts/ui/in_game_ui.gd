extends CanvasLayer

var time = 0
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	print(time)


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
