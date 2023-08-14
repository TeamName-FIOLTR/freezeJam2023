@tool
extends Node3D

@export_range(0,1) var CRYO_animation_factor : float = 0.0:
	set(n_factor):
		CRYO_animation_factor = n_factor
		if not is_inside_tree(): await ready #14
		update_CRYO_animation_factor()
@export_range(0,1) var PANTS_animation_factor : float = 0.0:
	set(n_factor):
		PANTS_animation_factor = n_factor
		if not is_inside_tree(): await ready #15
		update_PANTS_animation_factor()
@export_range(0,1) var OFF_animation_factor : float = 0.0:
	set(n_factor):
		OFF_animation_factor = n_factor
		if not is_inside_tree(): await ready #16
		update_OFF_animation_factor()

@export_range(0,1) var CRYO_text_freeze_ratio : float = 0.5:
	set(n_ratio):
		CRYO_text_freeze_ratio = n_ratio
		if not is_inside_tree(): await ready #17 will we get to hit 20???? find out next time on dragon ball z
		update_CRYO_animation_factor()
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Title Animation!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_CRYO_animation_factor():
	var text_string = "C.R.Y.O."
	var text_popin_factor = clamp(remap(CRYO_animation_factor,0,CRYO_text_freeze_ratio,0,1),0,1)
	var text_freeze_factor = clamp(remap(CRYO_animation_factor,CRYO_text_freeze_ratio,1,0,1),0,1)
	var characters_visible = roundi(text_popin_factor*8.0)
	if characters_visible >= 0:
		var new_string = text_string.substr(0,characters_visible)
		$"CRYO text".mesh.text = new_string#+" ".repeat(8-characters_visible)
	$"CRYO text".get_surface_override_material(0).set_shader_parameter("Animation_Factor",text_popin_factor-0.5/8.0)
	$"CRYO text".material_overlay.set_shader_parameter("Freeze_Factor", text_freeze_factor)
	pass # Multicursor baybe
func update_PANTS_animation_factor():
	$"pants/Pants with UV".get_surface_override_material(0).set_shader_parameter("Animation_Factor", PANTS_animation_factor)
	pass # Multicursor baybe
func update_OFF_animation_factor():
	$"OFF text".get_surface_override_material(0).set_shader_parameter("Animation_Factor",OFF_animation_factor)
	pass # Multicursor baybe
