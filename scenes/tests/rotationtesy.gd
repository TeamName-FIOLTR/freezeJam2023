extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var t = 0.0
func _process(delta):
	$CSGBox3D.rotation_degrees.y = t
	t += delta*10
	print($CSGBox3D.rotation_degrees.y)
	pass
