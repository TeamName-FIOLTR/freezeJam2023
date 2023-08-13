extends Control

@export var default_focus : Control

@export var freeze_color_slider_0 : HSlider
@export var freeze_color_slider_1 : HSlider
@export var freeze_color_slider_2 : HSlider
@export var freeze_color_slider_3 : HSlider
@export var freeze_color_slider_4 : HSlider
@export var freeze_color_slider_5 : HSlider
# Called when the node enters the scene tree for the first time.
func _ready():
	sync_ui()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sync_ui():
	
	freeze_color_slider_0.set_value_no_signal(Globals.Settings.Colors.FreezeColor0.h*360.0) # satifying multicursor
	freeze_color_slider_1.set_value_no_signal(Globals.Settings.Colors.FreezeColor1.h*360.0) # satifying multicursor
	freeze_color_slider_2.set_value_no_signal(Globals.Settings.Colors.FreezeColor2.h*360.0) # satifying multicursor
	freeze_color_slider_3.set_value_no_signal(Globals.Settings.Colors.FreezeColor3.h*360.0) # satifying multicursor
	freeze_color_slider_4.set_value_no_signal(Globals.Settings.Colors.FreezeColor4.h*360.0) # satifying multicursor
	freeze_color_slider_5.set_value_no_signal(Globals.Settings.Colors.FreezeColor5.h*360.0) # satifying multicursor
	
	
	
	
	
	pass

func _on_freeze_color_0_slider_value_changed(value):
	Globals.Settings.Colors.FreezeColor0 = Color.from_hsv(value/360.0,1,1)
	Globals.Settings.Colors.load_settings()
	pass # Replace with function body.


func _on_freeze_color_1_slider_value_changed(value):
	Globals.Settings.Colors.FreezeColor1 = Color.from_hsv(value/360.0,1,1)
	Globals.Settings.Colors.load_settings()
	pass # Replace with function body.

func _on_freeze_color_2_slider_value_changed(value):
	Globals.Settings.Colors.FreezeColor2 = Color.from_hsv(value/360.0,1,1)
	Globals.Settings.Colors.load_settings()
	pass # Replace with function body.

func _on_freeze_color_3_slider_value_changed(value):
	Globals.Settings.Colors.FreezeColor3 = Color.from_hsv(value/360.0,1,1)
	Globals.Settings.Colors.load_settings()
	pass # Replace with function body.

func _on_freeze_color_4_slider_value_changed(value):
	Globals.Settings.Colors.FreezeColor4 = Color.from_hsv(value/360.0,1,1)
	Globals.Settings.Colors.load_settings()
	pass # Replace with function body.

func _on_freeze_color_5_slider_value_changed(value):
	Globals.Settings.Colors.FreezeColor5 = Color.from_hsv(value/360.0,1,1)
	Globals.Settings.Colors.load_settings()
	pass # Replace with function body.



func _on_visibility_changed():
	if visible:
		sync_ui()
		default_focus.grab_focus()
		pass
	else:
		pass
		#Globals.Settings.save()
	pass # Replace with function body.
