extends RigidBody2D

var in_area: bool = false

func _physics_process(delta):
	if in_area == true:
		print("1")
		var vehicle_velocity_y = $"../Player".linear_velocity.y
		var vehicle_velocity_x = $"../Player".linear_velocity.x
		var relative_velocity_y = vehicle_velocity_y - linear_velocity.y + 100
		var relative_velocity_x = vehicle_velocity_x - linear_velocity.x 
		apply_central_impulse(Vector2(relative_velocity_x,relative_velocity_y))
	else:
		print("2")
		pass
		#linear_velocity = Vector2.ZERO
		#apply_central_impulse(Vector2(0, 250))

func _on_area_entered_area_entered(area: Area2D) -> void:
	if "Trailer" in area.name:
		in_area = true

func _on_area_entered_area_exited(area: Area2D) -> void:
	if "Trailer" in area.name:
		in_area = false
