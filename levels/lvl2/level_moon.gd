extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$UI/Label.text = str("Количество камней: ", Global.Stones)


func _on_area_finish_body_entered(body: Node2D) -> void:
	$UI/WIN.visible = true
