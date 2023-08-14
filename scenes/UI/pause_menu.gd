extends Control

@export var default_focus : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	default_focus.grab_focus()
	print("YO I'M PAUSE MENU AND I'M OPEN")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func unpause():
	get_tree().call_group("Menu Managers", "unpause")
	pass

func _on_resume_button_pressed():
	unpause()
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("pause") or event.is_action_pressed("ui_cancel"):
		print("UN PAUSE PLZZZ")
		await RenderingServer.frame_post_draw
		unpause()


func _on_settings_button_pressed():
	get_tree().call_group("Menu Managers", "switch_to_settings")
	pass # Replace with function body.


func _on_credits_button_pressed():
	get_tree().call_group("Menu Managers", "switch_to_credits")
	pass # Replace with function body.
