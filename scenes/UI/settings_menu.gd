extends Control

@export var settings_tab_container : TabContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_next"):
		settings_tab_container.current_tab = posmod(settings_tab_container.current_tab+1,settings_tab_container.get_tab_count())
	if event.is_action_pressed("ui_prev"):
		settings_tab_container.current_tab = posmod(settings_tab_container.current_tab-1,settings_tab_container.get_tab_count())
	if event.is_action_pressed("ui_cancel"):
		exit_menu()

func exit_menu():
	Globals.Settings.save()
	get_tree().call_group("Menu Managers", "switch_to_main")
	pass

func _on_tab_container_tab_changed(tab):
	Globals.Settings.save()
	pass # Replace with function body.


func _on_back_button_pressed():
	exit_menu()
	pass # Replace with function body.
