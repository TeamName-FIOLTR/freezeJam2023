extends CharacterBody3D

@export var anim_tree : AnimationTree 
@export var heavy_attack_timer : Timer
@export var pants : Node3D
@export var SPEED = 12
const JUMP_VELOCITY = 4.5


#if false we ignore the input from the joystic for moving
@export var do_motion_input : bool = true

@export var joystick_input : Vector2
@export var keyboard_input : Vector2

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
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = joystick_input 
 
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
func kick()->void:
	anim_tree.set("parameters/conditions/s kick",true)
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
		self.kick()
		
	move(event)		


