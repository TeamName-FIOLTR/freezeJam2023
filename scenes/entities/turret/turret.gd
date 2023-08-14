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
		if not is_inside_tree(): await ready # just onready the set getters, godot
		update_search_area()

@export var ugh : Node3D

@export var frozen : bool = false:
	set(n_frozen):
		frozen = n_frozen
		if not is_inside_tree(): await ready #13 ooo spoky haunted useless boolean check
		update_frozen()

@export_range(0,1) var freeze_factor : float = 0.0:
	set(n_factor):
		freeze_factor = n_factor
		if not is_inside_tree(): await ready # 😔
		update_freeze_factor()

@export var barrel_rotation : float = 0.0:
	set(n_degrees):
		barrel_rotation = n_degrees
		if not is_inside_tree(): await ready #9
		update_barrel_rotation()

@export var rig : Skeleton3D

@export var fire_rate : float = 6000

var freeze_tween : Tween

@onready var barrel_l_idx : int = $"lilturret/Turret Rig/Skeleton3D".find_bone("Barrel L") # These null out in the editor what is even the POINT of @onready?? God i love doing useless boolean checks every single frame of the game ugh
@onready var barrel_r_idx : int = $"lilturret/Turret Rig/Skeleton3D".find_bone("Barrel R") # These null out in the editor what is even the POINT of @onready?? God i love doing useless boolean checks every single frame of the game ugh

@export var barrel_rotation_speed : float = 0

@export_range(0,1) var whirl_up : float = 0.0: # this isn't even exported and it's error spamming in lerp? i thought the firs time it's cuz it was @exported, but ig not godot just *does* that sometimes
	set(n_whirl):
		whirl_up = n_whirl
		if not is_inside_tree(): await ready #12
		update_whirl_up()

@export_range(0,10,0.01,"or_greater") var whirl_up_speed : float = 5

@export_range(0,10, 0.01, "or_greater") var whirl_down_speed : float = 1.0

@export var lazer_fire_l : LazerFire
@export var lazer_fire_r : LazerFire

var lazer_fire_index_l : int = 0
var lazer_fire_index_r : int = 0

var target_detected : bool = false
var current_target : Node3D = null
var target_quaternion : Quaternion = Quaternion.IDENTITY
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var freeze_delta : float = delta*(1.0-freeze_factor)
	var track_thing : float = 10.0
	
	if current_target and target_detected:
		if current_target is CryoPants:
			lazer_fire_l.look_at(current_target.hit_target.global_position,Vector3.UP,true)
			lazer_fire_r.look_at(current_target.hit_target.global_position,Vector3.UP,true)
		else:
			lazer_fire_l.look_at(current_target.global_position,Vector3.UP,true)
			lazer_fire_r.look_at(current_target.global_position,Vector3.UP,true)
		if lazer_fire_l.targetting_player and lazer_fire_r.targetting_player:
			whirl_up = lerp(whirl_up, 1.0, freeze_delta*whirl_up_speed) # but up here i don't have to convert a float back to a float??? like mmm yes this float here is a float????
		else:
			whirl_up = lerp(float(whirl_up), 0.0, freeze_delta*whirl_down_speed)
		update_tracking(freeze_delta*10.0)
		track_thing = 30.0
	else: # it's like how godot just sometimes *forgets* what type something is after it's used once somehwere else earlier in the stack.   what the heck??
		track_thing = search_angle
		update_tracking(freeze_delta*2.0)#		Okay, weird that i have to convert freeze_dealta, too # Wait static float define worked this time
#		print(whirl_down_speed)
		whirl_up = lerp(float(whirl_up), 0.0, freeze_delta*whirl_down_speed)  # once again, whirl_up is statically defined as float, why do i have to convert it???
	tracking_angle = lerp(float(tracking_angle), track_thing,freeze_delta*10.0) # i have absolutely no clue why this error spams. Classic godot moment (i love this engine)
	pass#					What? why???
	#						tracking_angle is already statically typed as a float
	#						god this is like the third or 5th godot jankiness tonight
	
	#						Hi, it's me the next day, we are easily at 10 godot janks so far 
	barrel_rotation += barrel_rotation_speed*freeze_delta

func FIRE():
	lazer_fire_l.fire()
	pass

func update_freeze_color_index():
	var mesh : MeshInstance3D = $"lilturret/Turret Rig/Skeleton3D/Turret Model"
	for i in range(mesh.get_surface_override_material_count()):
		mesh.get_surface_override_material(i).set_shader_parameter("Freeze_Color_Index", freeze_color_index)
		pass
	$"lilturret/Turret Rig/Skeleton3D/BoneAttachment3D/ugh/MeshInstance3D".get_surface_override_material(0).set_shader_parameter("Freeze_Color_Index",freeze_color_index)
	lazer_fire_l.freeze_color_index = freeze_color_index
	lazer_fire_r.freeze_color_index = freeze_color_index
#		pass
#	mesh.get_surface_override_material(0).set_shader_parameter("Freeze_Color_Index", freeze_color_index)
#	print("asfd;'ljk")
	pass

func update_freeze_factor():
	var mesh = $"lilturret/Turret Rig/Skeleton3D/Turret Model"
	mesh.material_overlay.set_shader_parameter("Freeze_Factor", freeze_factor)
	$"lilturret/Turret Rig/Skeleton3D/BoneAttachment3D/ugh/MeshInstance3D".get_surface_override_material(0).set_shader_parameter("Freeze_Factor",freeze_factor)
	if freeze_factor >= 1.0:
		self.set_process(false)
	else:
		self.set_process(true)
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

func update_barrel_rotation():
#	print(barrel_l_idx)
	barrel_l_idx = $"lilturret/Turret Rig/Skeleton3D".find_bone("Barrel L") # i'm not even gonna null check these first because if godot can't be bothered then i can't be bothered
	barrel_r_idx = $"lilturret/Turret Rig/Skeleton3D".find_bone("Barrel R") # i'm not even gonna null check these first because if godot can't be bothered then i can't be bothered
	var quatl = Quaternion.from_euler(Vector3(deg_to_rad(barrel_rotation),PI/2,PI/2))
	var quatr = Quaternion.from_euler(Vector3(deg_to_rad(-barrel_rotation+22.5),PI/2,PI/2))
	rig.set_bone_pose_rotation(barrel_l_idx,quatl)
	rig.set_bone_pose_rotation(barrel_r_idx,quatr)
	if whirl_up > 0.95:
		var fire_index_l = floori(8*barrel_rotation/360.0)
		var fire_index_r = floori(8*(-barrel_rotation+22.5)/360.0)
		
		if fire_index_l != lazer_fire_index_l:
			lazer_fire_l.fire()
		if fire_index_r != lazer_fire_index_r:
			lazer_fire_r.fire()
		lazer_fire_index_l = fire_index_l
		lazer_fire_index_r = fire_index_r
		pass
	pass

func update_whirl_up():
	var current_rpm = lerp(0.0,fire_rate/2.0,whirl_up)/8.0
	barrel_rotation_speed = current_rpm*6.0
	$"lilturret/Turret Rig/Skeleton3D/Turret Model".get_surface_override_material(3).set_shader_parameter("Barrel_Brightness", (whirl_up**6)*30)
	$"lilturret/Turret Rig/Skeleton3D/BoneAttachment3D/Whirl Sound".volume_db = linear_to_db(whirl_up*(1.0-freeze_factor))
	$"lilturret/Turret Rig/Skeleton3D/BoneAttachment3D/Whirl Sound".pitch_scale = max((current_rpm*(1.0-freeze_factor)/4.0*60)/48.25,0.01)
	pass

func update_frozen():
	if not frozen:
		#self.set_process(true)
		if freeze_tween:
			freeze_tween.kill()
		freeze_tween = create_tween()
		freeze_tween.tween_property(self,"freeze_factor",0.0, 20.0/60.0)
		$"UnFreeze Sound".play()
		$"lilturret/Turret Rig/Skeleton3D/BoneAttachment3D/Whirl Sound".volume_db = linear_to_db(whirl_up)
	else:
		self.set_process(false)
		if freeze_tween:
			freeze_tween.kill()
		freeze_tween = create_tween()
		freeze_tween.tween_property(self,"freeze_factor",1.0, 10.0/60.0)
		$"Freeze Sound".play()
		$"lilturret/Turret Rig/Skeleton3D/BoneAttachment3D/Whirl Sound".volume_db = linear_to_db(0)
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
		frozen = not frozen

func _input(event):
#	FIRE()
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_SPACE or true:
			pass
#			FIRE()
