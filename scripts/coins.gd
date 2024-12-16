extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pickup(body)
		Global.coins += 1

func pickup(body):
	var tween1 = get_tree().create_tween() # создает новую анимацию
	tween1.tween_property(self, "position:y", position.y - 60, 0.2) # задаем саму анимацию
	$ASPup.play() # включаем звук подбора
	await $ASPup.finished # ждем пока доиграет и выключаем
	get_tree().queue_delete(self) # удаляет анимацию из очереди
