extends Control

@export_range(0,5) var freeze_color_index : int = 0:
	set(n_index):
		freeze_color_index = n_index
		if not is_inside_tree(): await ready #18
		update_freeze_color_index()

@export var display_health_factor : float = 1:
	set(n_health_factor):
		display_health_factor = n_health_factor
		if not is_inside_tree(): await ready #19
		update_display_health_factor() # yeah multicursor except the : on the actual func define line (this one depending on which line you're reading right now)

@export var texture_rect : TextureRect
@export var goal : float = 30
var start_time = 0
var end_time = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = Time.get_ticks_usec()/1.0e+6
	end_time = start_time+goal
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current = Time.get_ticks_usec()/1.0e+6
	Globals.timey = end_time-current
	$Label.text = "TIME LEFT:\n%3.4f SECONDS"%(end_time-current)
	if current > end_time:
		get_parent().health -= 1.0e+9
	pass

func update_freeze_color_index():
	texture_rect.material.set_shader_parameter("Freeze_Color_Index", freeze_color_index)
	pass

func update_display_health_factor(): # yeah multicursor except the : on the actual func define line (this one depending on which line you're reading right now)
	texture_rect.material.set_shader_parameter("Health_Factor", display_health_factor)
	pass
