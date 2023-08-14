extends Control

@export var default_focus : Control
@export var play_level : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	default_focus.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_packed(play_level)
	pass # Replace with function body.


func _on_settings_button_pressed():
	get_tree().call_group("Menu Managers", "switch_to_settings")
	pass # Replace with function body.


func _on_credits_button_pressed():
	get_tree().call_group("Menu Managers", "switch_to_credits")
	pass # Replace with function body.
