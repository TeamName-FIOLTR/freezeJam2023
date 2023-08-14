extends CharacterBody3D
class_name CryoPants

@export var anim_tree : AnimationTree 
@export var heavy_attack_timer : Timer
@export var pants : Node3D
@export var SPEED = 12
const JUMP_VELOCITY = 4.5
@export_range(0,5) var freeze_color_index : int = 0:
	set(n_index):
		freeze_color_index = n_index
		if not is_inside_tree(): await ready # 😔
		update_freeze_color()

#if false we ignore the input from the joystic for moving
@export var do_motion_input : bool = true

@export var joystick_input : Vector2
@export var keyboard_input : Vector2

@export var pause_menu : PackedScene = preload("res://scenes/UI/pause_menu_manager.tscn")

@export var hit_target : Node3D

@export var health : float = 100:
	set(n_health):
		health = n_health
		if not is_inside_tree(): await ready #20 🥳🥳🥳 WE GOT TO 20 SUPID USELESS SINGLE USE BOOLEAN CHECKS EVERY FRAME!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳💀💀💀💀💀💀💀I AM SO HAPPY ABOUT THIS FEATURE💀💀💀💀💀💀💀💀💀💀I LOVE THE GODOT FREE LIBRE OPEN SOURCE GAME ENGINE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		update_health() #loool another completely cross page multicursor whatever idk man cognition declining fr fr 4 hours left!!!!!!!
@export var alive : bool = true

@export var pants_ui : Control

@export var max_health : float = 100

@export var avaliable_colors_indecies : Array[int] = [0]

@export var current_color_array_index : int = 0:
	set(n_index):
		current_color_array_index = n_index
		if not is_inside_tree(): await ready # WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 WHATS 9 + 10 
		freeze_color_index = avaliable_colors_indecies[current_color_array_index]

@export var kick_area : Area3D

#@export var death_screen : PackedScene = preload("res://scenes/UI/death_menu.tscn")

var lil_pants_flash : float = 1.0:
	set(n_flash):
		lil_pants_flash = n_flash
		# hey i don't think i need the thing here because this isn't an exported variable maybe there is a loving god
		$"pantshopefully/Pants Rig/Skeleton3D/basically done pants".get_surface_override_material(2).set_shader_parameter("Pulse", lil_pants_flash)
var pants_pulse_tween : Tween

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func heavy_attack()->void:
	self.clear_input()
	do_motion_input = false
	anim_tree.set("parameters/conditions/kick",true)
	did_heavy_attack = true
func _ready()->void:
	anim_tree.animation_finished.connect(self.on_anim_finished)
	heavy_attack_timer.timeout.connect(heavy_attack)
	current_color_array_index = current_color_array_index
	update_pants_ui()

func on_anim_finished(anim):
	print(anim)
	match anim:
		"pantsanimtweatsmaybe/GetUpCrossed":
			do_motion_input = true
			anim_tree.set("parameters/conditions/get_up",false)
		"pantsanimtweatsmaybe/GetUpCrossed2":
			anim_tree.set("parameters/conditions/kick",false)
		"pantsanimtweatsmaybe/double kick":
			print("finished the double kick")
			anim_tree.set("parameters/conditions/s kick",false)
	pass

func _physics_process(delta):
	$Label.text = str(Engine.get_frames_per_second())
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = joystick_input if keyboard_input.length() < 0.5 else keyboard_input
 
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	direction = direction.rotated(Vector3(0,1,0),deg_to_rad($"Player Camera".gimbal_camera.gimbal_rotation_degrees.x))

	if (not do_motion_input):
			#re-enable do_motion_input if they move while on the ground
			if not anim_tree.get("parameters/conditions/kick") and input_dir.length() > 0:
				anim_tree.set("parameters/conditions/get_up",true)
				update_rotation(direction,20*delta) #this could prolly b a lerp
			direction = Vector2.ZERO
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	update_movement_animation()
func update_rotation(vel : Vector3,lerp_amount: float = 1.0)->void:
	var vec = Vector2(vel.x,vel.z).normalized()
	pants.rotation.y = lerp(pants.rotation.y,atan2(-vec.y,vec.x)+PI/2,lerp_amount)
	pass
func update_movement_animation():
	var speed = sqrt(velocity.x**2+velocity.z**2)
	anim_tree.set("parameters/conditions/moving",speed > 0)
	if speed > 0:
		update_rotation(velocity)
	anim_tree.set("parameters/run_animation/Rest/blend_amount", clamp(speed/4.0,0,1))
	anim_tree.set("parameters/run_animation/RunSpeedScale/scale", max(speed/4.0,1))
	anim_tree.set("parameters/spin up speed/stand_up_speed/scale", clamp(speed/4.0,1,1.5))
	
	pass 

func update_freeze_color():
	$"pantshopefully/Pants Rig/Skeleton3D/basically done pants".get_surface_override_material(2).set_shader_parameter("Freeze_Color_Index", freeze_color_index)
	flash_pants()
	update_pants_ui()
	pass

func flash_pants():
	if pants_pulse_tween:
		pants_pulse_tween.kill()
	pants_pulse_tween = create_tween()
	lil_pants_flash = 1.0
	pants_pulse_tween.tween_property(self,"lil_pants_flash",0.0,3.0/60.0)

func update_pants_ui():
	pants_ui.freeze_color_index = freeze_color_index
	pants_ui.display_health_factor = health/max_health

func update_health(): #loool another completely cross page multicursor whatever idk man cognition declining fr fr 4 hours left!!!!!!!
	if health <= 0:
#		get_tree().change_scene_to_packed(death_screen)
		get_tree().change_scene_to_file("res://scenes/UI/death_menu.tscn")
	update_pants_ui()
	pass

func add_freeze_color_index(index):
	if index in avaliable_colors_indecies: return
	var n_index = avaliable_colors_indecies.bsearch(index)
	print("\n\n\n\n")
	print(avaliable_colors_indecies)
	avaliable_colors_indecies.insert(n_index,index) # Not at all confusing
	current_color_array_index = n_index
	print(avaliable_colors_indecies)
	pass

func kick()->void:
	anim_tree.set("parameters/conditions/s kick",true)
	var things = kick_area.get_overlapping_bodies()
	print(things)
	for thing in things:
		print(thing.get_parent())
		if thing.get_parent() is Turret:
			add_freeze_color_index(thing.get_parent().freeze_color_index)

func clear_input()->void:
	joystick_input = Vector2.ZERO
	keyboard_input = Vector2.ZERO

func move(event)->void:
	#when performing the big kick, we ignore player input
	if anim_tree.get("paramaters/conditions/kick"):
		self.clear_input()
		return
	if event is InputEventJoypadMotion:
		joystick_input = Input.get_vector("leftwards", "rightwards", "forwards", "backwards")
	elif event is InputEventKey:
		keyboard_input = Input.get_vector("leftwards", "rightwards", "forwards", "backwards")

var did_heavy_attack : bool = false

func _input(event):
	if Input.is_action_just_pressed("kick"):
		did_heavy_attack = false
		heavy_attack_timer.start()
	elif Input.is_action_just_released("kick") and not did_heavy_attack:
		heavy_attack_timer.stop()
		self.kick() # bruh i can't shift click this why
		kick()
		
	move(event)		
	if event.is_action_pressed("next_color"):
#		freeze_color_index = posmod(freeze_color_index+1,6)
		current_color_array_index = posmod(current_color_array_index+1, avaliable_colors_indecies.size())
	elif event.is_action_pressed("previous_color"):
#		freeze_color_index = posmod(freeze_color_index-1,6)
		current_color_array_index = posmod(current_color_array_index-1, avaliable_colors_indecies.size())
	
	if event.is_action_pressed("FREEZE"):
		get_tree().call_group("Freeze Recievers", "recieve_freeze", freeze_color_index)
		flash_pants()
	if event.is_action_pressed("pause"):
#		await RenderingServer.frame_post_draw
#		await RenderingServer.frame_post_draw
		add_child(pause_menu.instantiate())
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true

