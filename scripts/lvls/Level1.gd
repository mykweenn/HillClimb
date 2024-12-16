extends Node2D

@onready var line = $Line2D
@onready var polygon = $Line2D/Polygon2D
@onready var collision_polygon = $Line2D/StaticBody2D2/CollisionPolygon2D
var Game_start = false
var timer = 0.0
var timer_start_game = 0.0
var timer_playing_lvl = 0.0

func _ready() -> void:
	generate_polygon_and_collision()


func generate_polygon_and_collision():
	var line_points = line.points
	
	if line_points.size() < 2:
		return
	
	var polygon_points = line_points.duplicate()
	
	var bottom_y = 20000  # Нижняя граница земли
	polygon_points.append(Vector2(line_points[-1].x, bottom_y))  # Правая нижняя точка
	polygon_points.append(Vector2(line_points[0].x, bottom_y))   # Левая нижняя точка
	
	# Устанавливаем точки для Polygon2D
	polygon.polygon = polygon_points
	
	# Устанавливаем точки для CollisionPolygon2D
	collision_polygon.polygon = polygon_points


func _process(delta: float) -> void:
	if $UI_win.visible == false:
		timer_playing_lvl += delta
	$"InGameUI/StoneLabel".text = str("Количество камней: ", int(Global.Stones))
	$"InGameUI/CoinLabel".text = str("Монет: ", int(Global.coins))
	if Game_start == false:
		timer_start_game += delta
	if timer_start_game >= 10:
		$"UI_lose/LOSE/Label".text = str("Ты не собрал камни")
		$UI_lose.visible = true
		print("you lose")
	$ParallaxBackground.position.y = $Player.position.y * 0.001
	if Global.Stones > 2:
		if not Game_start:
			Game_start = true
			print("game start")
		timer = 0
	else:
		if Game_start:
			timer += delta
			if timer >= 1:
				$"UI_lose/LOSE/Label".text = str("Ты слишком много \n потерял камней")
				GlobalPlayer.TORQUE = 0.0
				GlobalPlayer.turnLeftRight = 0.0
				$UI_lose.visible = true

func _on_area_finish_body_entered(body: Node2D) -> void:
	if "layer" in body.name:
		$UI_win.visible = true
		$UI_win.stars_anim()
		$InGameUI.visible = false
