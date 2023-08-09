@tool
extends Node3D
class_name GimbalCamera

@export var gimbal_rotation_degrees : Vector3:
	set(n_degrees):
		gimbal_rotation_degrees = n_degrees
		if not is_inside_tree(): await ready
		gimbal_rotation_degrees.x = clamp(wrap(gimbal_rotation_degrees.x,-180,180),rotation_min.x,rotation_max.x) if limit_x else gimbal_rotation_degrees.x # this one up here is good, tho
		gimbal_rotation_degrees.y = clamp(wrap(gimbal_rotation_degrees.y,-180,180),rotation_min.y,rotation_max.y) if limit_y else gimbal_rotation_degrees.y # this one up here is good, tho
		gimbal_rotation_degrees.z = clamp(wrap(gimbal_rotation_degrees.z,-180,180),rotation_min.z,rotation_max.z) if limit_z else gimbal_rotation_degrees.z # this one up here is good, tho
		update_gimbal()
@export var camera_distance : float = 0.0:
	set(n_distance):
		camera_distance = n_distance
		if not is_inside_tree(): await ready
		$Pitch/Yaw/Roll/Camera3D.position.z = camera_distance
@export_subgroup("Limits")
@export var limit_x : bool = false
@export var limit_y : bool = false
@export var limit_z : bool = false
@export var rotation_min : Vector3
@export var rotation_max : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_camera():
	return $Pitch/Yaw/Roll/Camera3D

func update_gimbal():
	
	$Pitch.rotation_degrees.y = gimbal_rotation_degrees.x
	$Pitch/Yaw.rotation_degrees.x = gimbal_rotation_degrees.y
	$Pitch/Yaw/Roll.rotation_degrees.z = gimbal_rotation_degrees.z
	
	#$Pitch.rotation_degrees.y = clamp($Pitch.rotation_degrees.y,rotation_min.x, rotation_max.x) if limit_x else $Pitch.rotation_degrees.y # once again, multicursor operation 😎 # that i ended up commenting out because it's bugged
	#$Pitch/Yaw.rotation_degrees.x = clamp($Pitch/Yaw.rotation_degrees.x,rotation_min.y, rotation_max.y) if limit_y else $Pitch/Yaw.rotation_degrees.x # once again, multicursor operation 😎 # that i ended up commenting out because it's bugged
	#$Pitch/Yaw/Roll.rotation_degrees.z = clamp($Pitch/Yaw/Roll.rotation_degrees.z,rotation_min.z, rotation_max.z) if limit_z else $Pitch/Yaw/Roll.rotation_degrees.z # once again, multicursor operation 😎 # that i ended up commenting out because it's bugged
	
	pass
