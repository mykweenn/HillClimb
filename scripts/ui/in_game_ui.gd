extends CanvasLayer

@onready var slider: HSlider = $soundButton/sounds/Panel/HSlider
@onready var panel: Panel = $soundButton/sounds/Panel

func _ready() -> void:
	slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))

func _on_button_pressed() -> void:
	GlobalPlayer.player_died = false
	get_tree().reload_current_scene()


func _on_h_slider_value_changed(value: float) -> void:
	var db_value = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db_value)


func _on_sound_button_pressed() -> void:
	panel.visible = not panel.visible
