extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str("Ты привез ", Global.Stones ," камней")



func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_button_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_button_next_lvl_pressed() -> void:
	var currentScene = get_tree().current_scene.name
	var nextLevelNumber = currentScene.to_int() + 1
	
	var nextLevelPath = "res://scenes/lvls/Level" + str(nextLevelNumber) + ".tscn"
	if ResourceLoader.exists(nextLevelPath):
		get_tree().change_scene_to_file(nextLevelPath)
	else:
		print("Скоро обновление")
	if nextLevelNumber > Global.passedLvl:
		Global.passedLvl += 1
		Global._save_data()

func _on_button_go_to_menu_pressed() -> void:
	var currentScene = get_tree().current_scene.name
	var nextLevelNumber = currentScene.to_int() + 1
	if nextLevelNumber > Global.passedLvl:
		Global.passedLvl += 1
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
