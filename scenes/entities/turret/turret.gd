@tool
extends Node3D
class_name Turret

@export_range(0,5) var freeze_color_index : int = 0:
	set(n_index):
		freeze_color_index = n_index
		if not is_inside_tree(): await ready
		update_freeze_color_index()
@export_range(1,179) var search_angle : float = 45.0:
	set(n_degrees):
		search_angle = n_degrees
		if not is_inside_tree(): await ready # ugh i hate how much i have to do this
		update_search_area()

@export_range(1, 100,0.01, "or_greater") var search_distance : float = 10:
	set(n_distance):
		search_distance = n_distance
		if not is_inside_tree(): await ready # if only there was some way to notate that a variable shouldn't be set until the node is ready or something
		update_search_area()

@export_range(1,179) var tracking_angle : float = 10.0:
	set(n_degrees):
		tracking_angle = n_degrees
		if not is_inside_tree(): await ready # just on ready the set getters, godot
		update_search_area()

@export var ugh : Node3D

@export var frozen : bool = false

@export_range(0,1) var freeze_factor : float = 0.0:
	set(n_factor):
		freeze_factor = n_factor
		if not is_inside_tree(): await ready # 😔
		update_freeze_factor()

var freeze_tween : Tween

var target_detected : bool = false
var current_target : Node3D = null
var target_quaternion : Quaternion = Quaternion.IDENTITY
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var track_thing : float = 10.0
	
	if current_target and target_detected:
		track_thing = 30.0
		update_tracking(delta*10.0)
	else:
		track_thing = search_angle
		update_tracking(delta*2.0)
	tracking_angle = lerp(float(tracking_angle), track_thing,delta*10.0) # i have absolutely no clue why this error spams. Classic godot moment (i love this engine)
	pass#					What? why???
	#						tracking_angle is already statically typed as a float
	#						god this is like the third or 5th godot jankiness tonight

func update_freeze_color_index():
	var mesh : MeshInstance3D = $"lilturret/Turret Rig/Skeleton3D/Turret Model"
	for i in range(mesh.get_surface_override_material_count()):
		mesh.get_surface_override_material(i).set_shader_parameter("Freeze_Color_Index", freeze_color_index)
		pass
	$"lilturret/Turret Rig/Skeleton3D/BoneAttachment3D/ugh/MeshInstance3D".get_surface_override_material(0).set_shader_parameter("Freeze_Color_Index",freeze_color_index)
#		pass
#	mesh.get_surface_override_material(0).set_shader_parameter("Freeze_Color_Index", freeze_color_index)
#	print("asfd;'ljk")
	pass

func update_freeze_factor():
	var mesh = $"lilturret/Turret Rig/Skeleton3D/Turret Model"
	mesh.material_overlay.set_shader_parameter("Freeze_Factor", freeze_factor)
	pass

func update_tracking(weight : float):
	var rig : Skeleton3D = $"lilturret/Turret Rig/Skeleton3D"
	var bone_idx = rig.find_bone("Head")
	rig = rig as Skeleton3D
	var trans_thingy = global_transform
	var trans_look = trans_thingy.looking_at(current_target.global_position, Vector3.UP, true) if current_target else trans_thingy
	var new_trans = global_transform.affine_inverse()*trans_look
	var quady = new_trans.basis.get_rotation_quaternion()
	var old_quady = rig.get_bone_pose_rotation(bone_idx)
#	print("\n\n")
#	print(rig.get_bone_pose_rotation(bone_idx))
	rig.set_bone_pose_rotation(bone_idx, old_quady.slerp(quady,weight))
#	print(rig.get_bone_pose_rotation(bone_idx))
#	rig.set_bone_pose_rotation(bone_idx,)
#	rig.set_bone_pose_rotation()
	pass


func update_search_area():
	var slope = tan(deg_to_rad(tracking_angle/2))
#	return
	ugh.scale.x = 2*slope*search_distance
	ugh.scale.z = search_distance
	pass

#func _physics_process(delta):
#	pass

func _on_area_3d_body_entered(body):
	if body is CryoPants:
		print("\n\n")
		print("CRYO PANTS DETECTED MUST SHOT TO KILL")
		current_target = body
		target_detected = true
#		start_tracking()
	pass # Replace with function body.




func _on_area_3d_body_exited(body):
	if body is CryoPants:
		print("\n\n")
		print("Rats, we lost em")
		current_target = null
		target_detected = false
	pass # Replace with function body.

func recieve_freeze(freeze_index):
	if freeze_index == freeze_color_index:
		if frozen:
			frozen = false
			self.set_process(true)
			if freeze_tween:
				freeze_tween.kill()
			freeze_tween = create_tween()
			freeze_tween.tween_property(self,"freeze_factor",0.0, 20.0/60.0)
		else:
			frozen = true
			self.set_process(false)
			if freeze_tween:
				freeze_tween.kill()
			freeze_tween = create_tween()
			freeze_tween.tween_property(self,"freeze_factor",1.0, 10.0/60.0)
		pass
