extends CharacterBody3D

@export var anim_tree : AnimationTree
@export var pants : Node3D
@export var SPEED = 12
const JUMP_VELOCITY = 4.5

@export var joystick_input : Vector2
@export var keyboard_input : Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


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
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	update_movement_animation()

func update_movement_animation():
	
	var speed = sqrt(velocity.x**2+velocity.z**2)
	if speed > 0:
		var vec = Vector2(velocity.x,velocity.z).normalized()
		pants.rotation.y = atan2(-vec.y,vec.x)+PI/2
	anim_tree.set("parameters/Rest/blend_amount", clamp(speed/4.0,0,1))
	anim_tree.set("parameters/RunSpeedScale/scale", max(speed/4.0,1))
	pass

func _input(event):
	if event is InputEventJoypadMotion:
		joystick_input = Input.get_vector("leftwards", "rightwards", "forwards", "backwards")
	elif event is InputEventKey:
		keyboard_input = Input.get_vector("leftwards", "rightwards", "forwards", "backwards")
