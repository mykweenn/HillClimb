extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str("Ты привез ", Global.Stones ," камней")


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
