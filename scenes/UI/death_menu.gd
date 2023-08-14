extends Control

@export var retry_level : PackedScene = preload("res://scenes/levels/main_level_for_real/main_level_for_real.tscn")
@export var main_menu_screen : PackedScene = preload("res://scenes/UI/menu_manager.tscn")

@export var default_focus : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	default_focus.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_button_pressed():
	get_tree().change_scene_to_packed(retry_level)
	pass # Replace with function body.


func _on_menu_button_pressed():
	get_tree().change_scene_to_packed(main_menu_screen)
	pass # Replace with function body.
