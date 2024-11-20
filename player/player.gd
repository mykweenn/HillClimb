extends RigidBody2D

@export var TORQUE := 2000.0
@export var ENABLE_USER := true

@onready var pin_rear: PinJoint2D = $PinJointRear
@onready var pin_front: PinJoint2D = $PinJointFront
@onready var wheel_rear: RigidBody2D = $PinJointLeft/WheelLeft
@onready var wheel_front: RigidBody2D = $PinJointRight/WheelRight







func _physics_process(delta: float) -> void:
		# Управление ускорением
		wheel_rear.apply_torque_impulse(TORQUE * Input.get_action_strength(&"speed_up"))
		wheel_front.apply_torque_impulse(TORQUE * Input.get_action_strength(&"speed_up"))
		wheel_rear.apply_torque_impulse(-TORQUE * Input.get_action_strength(&"speed_down"))
		wheel_front.apply_torque_impulse(-TORQUE * Input.get_action_strength(&"speed_down"))
		
		# Управление вращением
		apply_torque_impulse(-1000.0 * Input.get_action_strength(&"turn_left"))
		apply_torque_impulse(1000.0 * Input.get_action_strength(&"turn_right"))
		
		# Торможение
		wheel_rear.lock_rotation = Input.is_action_pressed(&"brake")
		wheel_front.lock_rotation = Input.is_action_pressed(&"brake")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "stone" in body.name:
		Global.Stones += 1
	#$"../stone".in_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if "stone" in body.name:
		Global.Stones -= 1
	#$"../stone".in_area = false
