extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_next"):
		$TabContainer.current_tab = posmod($TabContainer.current_tab+1,$TabContainer.get_tab_count())
	if event.is_action_pressed("ui_prev"):
		$TabContainer.current_tab = posmod($TabContainer.current_tab-1,$TabContainer.get_tab_count())
