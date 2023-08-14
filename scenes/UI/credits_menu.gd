extends Control

@export var default_focus : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	default_focus.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func exit_menu():
	get_tree().call_group("Menu Managers", "switch_to_main")

func _on_button_pressed():
	exit_menu()
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		exit_menu()
