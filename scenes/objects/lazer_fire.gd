extends Marker3D
class_name LazerFire
@export var max_distance : float = 1000:
	set(n_distance):
		max_distance = n_distance
		if not is_inside_tree(): await ready #10
		update_raycast()

@export_flags_2d_physics var collision_mask : int = 1:
	set(n_mask):
		collision_mask = n_mask
		if not is_inside_tree(): await ready #11
		update_raycast()

@export_range(0,5) var freeze_color_index : int = 0

@export_range(0,1,0.01,"or_greater") var lazer_thiccness : float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	update_raycast()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire():
	
	var rc_pos = $RayCast3D.get_collision_point() if $RayCast3D.is_colliding() else $RayCast3D.global_transform*$RayCast3D.target_position
	var distance = (rc_pos-global_position).length()
	
	$GPUParticles3D.emit_particle(Transform3D($RayCast3D.global_transform.basis,(global_position+rc_pos)/2.0).rotated_local(Vector3.LEFT,PI/2).scaled_local(Vector3(lazer_thiccness,distance/2,lazer_thiccness)),Vector3.ZERO,Color.WHITE,Color(freeze_color_index,0,0,0),GPUParticles3D.EMIT_FLAG_POSITION | GPUParticles3D.EMIT_FLAG_ROTATION_SCALE | GPUParticles3D.EMIT_FLAG_CUSTOM)
	$"Text Mesh".mesh.text = "%3.4f\n"%rc_pos.x+"%3.4f\n"%rc_pos.y+"%3.4f\n"%rc_pos.z
	$AudioStreamPlayer3D.play()
	pass

func update_raycast():
	var rc = $RayCast3D
	rc.collision_mask = collision_mask # again the tab complete forgets type.  Easy solution ig is to just keep setting stuff on the line above previous sets.  Still weird tho.  Also this is like the first time in a while i've actually used a period to notate the end of a line without needing a new line.  Double spaced and everything
	rc.target_position.z = max_distance # oh hey man whenever you read this, can you test in your weird vim setup if the engine just *forgets* type after you set or access it once?  yeah ik ik it's the same language server but i need the sanity check
	
	pass
