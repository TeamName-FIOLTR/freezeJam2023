extends Control


@export var mouse_sensitivity_slider : HSlider
@export var controller_sensitivity_slider : HSlider
@export var invert_x_button : CheckButton
@export var invert_y_button : CheckButton

@export var default_focus : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	sync_ui()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sync_ui():
	mouse_sensitivity_slider.set_value_no_signal(Globals.Settings.Controls.MouseSensitivity)
	controller_sensitivity_slider.set_value_no_signal(Globals.Settings.Controls.ControllerSensitivity)
	invert_x_button.set_pressed_no_signal(Globals.Settings.Controls.InvertX)
	invert_y_button.set_pressed_no_signal(Globals.Settings.Controls.InvertY)
	pass

func _on_mouse_sensitivity_slider_value_changed(value):
	Globals.Settings.Controls.MouseSensitivity = value
	pass # Replace with function body.


func _on_controller_sensitivity_slider_value_changed(value):
	Globals.Settings.Controls.ControllerSensitivity = value
	pass # Replace with function body.


func _on_invert_x_button_toggled(button_pressed):
	Globals.Settings.Controls.InvertX = button_pressed
	pass # Replace with function body.


func _on_invert_y_button_toggled(button_pressed):
	Globals.Settings.Controls.InvertY = button_pressed
	pass # Replace with function body.


func _on_visibility_changed():
	if visible:
		default_focus.grab_focus()
