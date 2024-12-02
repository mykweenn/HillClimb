extends RigidBody2D

# Укажите ссылку на игрока
@export var player: RigidBody2D

# Флаг для проверки, находится ли камень в кузове
var in_truck = false



func _on_body_entered(body):
	print(body)
	if body.name == "Player":  # Предполагается, что игрок в группе "player"
		print(player)
		player = body
		in_truck = true

func _on_body_exited(body):
	if body.name == "Player":
		in_truck = false
		player = null

func _physics_process(delta):
	if in_truck:
		# Синхронизируем скорость камня с игроком
		linear_velocity = player.linear_velocity
		rotation = player.rotation


func _on_area_2d_body_entered(body):
	if body.name == "Player":  # Предполагается, что игрок в группе "player"
		print(player)
		player = body
		in_truck = true


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		in_truck = false
		player = null
