extends Node

var Settings : SettingsResource = SettingsResource.new()
var SettingsPath : String = "user://data/settings.tres"

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	var settings = SettingsResource.load_from()
	if settings:
		Settings = settings
	Settings.load_settings() # this floor here is made out of floor
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
