extends RigidBody2D

@onready var wheel_rear: RigidBody2D = $PinJointLeft/WheelLeft
@onready var wheel_front: RigidBody2D = $PinJointRight/WheelRight

# звук

@onready var motor_engine: AudioStreamPlayer = $audio/ASP_engine
var engine_speed := 0.0
var engine_update_timer: float = 0.0
var engine_update_interval: float = 1


func _physics_process(delta: float) -> void:
		var accel = Input.get_action_strength(&"speed_up")
		var decel = Input.get_action_strength(&"speed_down")
		var braking = Input.is_action_pressed(&"brake")
		# Управление ускорением

		
		wheel_rear.apply_torque_impulse(GlobalPlayer.TORQUE * accel)
		wheel_front.apply_torque_impulse(GlobalPlayer.TORQUE * accel)
		wheel_rear.apply_torque_impulse(-GlobalPlayer.TORQUE * decel)
		wheel_front.apply_torque_impulse(-GlobalPlayer.TORQUE * decel)

		
		# Управление вращением
		apply_torque_impulse(-GlobalPlayer.turnLeftRight * Input.get_action_strength(&"turn_left"))
		apply_torque_impulse(GlobalPlayer.turnLeftRight * Input.get_action_strength(&"turn_right"))
		
		# Торможение
		wheel_rear.lock_rotation = braking
		wheel_front.lock_rotation = braking
		
		update_motor_sound(accel, decel, delta)
		

func update_motor_sound(accel: float, decel: float, delta: float) -> void:

	var max_engine_speed = 100.0  # Максимальная "скорость" мотора
	var min_engine_speed = 0.0    # Минимальная "скорость" мотора
	
	var current_speed = linear_velocity.length()  # Длина вектора скорости
	var normalized_speed = clamp(current_speed / 200.0, 0.0, 1.0)  # Нормализуем в диапазон [0.0, 1.0]
	
	engine_update_timer += delta
	
	if accel > 0.0:
		if not motor_engine.playing:
			motor_engine.play()
			engine_speed = min_engine_speed  # Сбрасываем на минимальную скорость при новом нажатии
		if engine_update_timer >= engine_update_interval:
			engine_speed = min(engine_speed + 10.0, max_engine_speed)
			engine_update_timer = 0.0 
	else:
		engine_speed = max(engine_speed - 10.0 * delta, min_engine_speed)  # Постепенно замедляем двигатель
	
	var target_pitch = 1.0 + engine_speed / max_engine_speed * 0.5
	motor_engine.pitch_scale = lerp(motor_engine.pitch_scale, target_pitch, 5.0 * delta)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "StoneRigidBody" in body.name:
		Global.Stones += 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	if "StoneRigidBody" in body.name:
		Global.Stones -= 1
