extends Node3D
class_name PlayerCamera

@export var gimbal_camera : GimbalCamera

var joystick_input_vec : Vector2
@export var joystick_sensitivity : float # another multicusor, btw

var mouse_input_vec : Vector2
@export var mouse_sensitivity : float # another multicusor, btw

@export var target_distance : float = 10.0
@export var target_offset : float = 0.01
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var degrees = joystick_input_vec*joystick_sensitivity+mouse_input_vec*mouse_sensitivity
	mouse_input_vec = Vector2.ZERO
	gimbal_camera.gimbal_rotation_degrees.x += -degrees.x*delta
	gimbal_camera.gimbal_rotation_degrees.y += degrees.y*delta
	pass

func _physics_process(delta):
	$RayCast3D.target_position = target_distance*(global_transform.affine_inverse()*gimbal_camera.get_camera().global_position).normalized()
	var collision_distance = (global_position-$RayCast3D.get_collision_point()).length()-target_offset if $RayCast3D.is_colliding() else target_distance
	gimbal_camera.camera_distance = collision_distance if collision_distance < gimbal_camera.camera_distance else lerp(gimbal_camera.camera_distance,collision_distance,10*delta)

func _input(event):
	if event is InputEventJoypadMotion:
		joystick_input_vec = Input.get_vector("look_left","look_right","look_down","look_up")
	elif event is InputEventMouseMotion:
		mouse_input_vec = event.relative
