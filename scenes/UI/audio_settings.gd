extends Control

@export var default_focus : Control

@export var MasterSlider : HSlider
@export var TurretFireSlider : HSlider
@export var TurretWhirlSlider : HSlider
@export var FreezeEffectSlider : HSlider
# Called when the node enters the scene tree for the first time.
func _ready():
	sync_ui()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sync_ui():
	
	MasterSlider.set_value_no_signal(Globals.Settings.Audio.MasterVolume*100.0)
	TurretFireSlider.set_value_no_signal(Globals.Settings.Audio.TurretFireVolume*100.0)
	TurretWhirlSlider.set_value_no_signal(Globals.Settings.Audio.TurretWhirlVolume*100.0)
	FreezeEffectSlider.set_value_no_signal(Globals.Settings.Audio.FreezeEffectVolume*100.0)
	
	
	
	pass

func _on_visibility_changed():
	if visible:
#		print("yeah i'm seen!")
		default_focus.grab_focus()
	else:
		pass
#		Globals.Settings.save()
#		print("dang, hidden :(")
	pass # Replace with function body.


func _on_master_slider_value_changed(value):
	Globals.Settings.Audio.MasterVolume = value/100.0
	Globals.Settings.Audio.load_settings()
	pass # Replace with function body.


func _on_fire_slider_value_changed(value):
	Globals.Settings.Audio.TurretFireVolume = value/100.0
	Globals.Settings.Audio.load_settings()
	pass # Replace with function body.


func _on_whirl_slider_value_changed(value):
	Globals.Settings.Audio.TurretWhirlVolume = value/100.0
	Globals.Settings.Audio.load_settings()
	pass # Replace with function body.


func _on_fx_slider_value_changed(value):
	Globals.Settings.Audio.FreezeEffectVolume = value/100.0
	Globals.Settings.Audio.load_settings()
	pass # Replace with function body.
