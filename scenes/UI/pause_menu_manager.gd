extends Control

@export var main_menu : PackedScene = preload("res://scenes/UI/pause_menu.tscn")
@export var settings_menu : PackedScene = preload("res://scenes/UI/settings_menu.tscn")
@export var credits_menu : PackedScene = preload("res://scenes/UI/credits_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clear():
	for child in $Current.get_children():
		child.queue_free()
		child.visible = false

func switch_to(scene : PackedScene):
	clear()
	$Current.add_child(scene.instantiate())


func switch_to_main():
	switch_to(main_menu)

func switch_to_settings():
	switch_to(settings_menu)

func switch_to_credits():
	switch_to(credits_menu)

func unpause():
	get_tree().paused = false
	queue_free()
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass
