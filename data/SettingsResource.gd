extends Resource
class_name SettingsResource

@export var Audio : AudioSettings = AudioSettings.new()
@export var Colors : ColorSettings = ColorSettings.new()

func _init():
	pass

func save(path : String = Globals.SettingsPath):
	prints("Saving Settings to path:", path)
	if not ResourceLoader.exists(path):
		print("nope no path what")
		var stupid = path.rsplit("/",true,1)[0]+"/"
		print(stupid)
		DirAccess.make_dir_recursive_absolute(stupid)
	var thing = ResourceSaver.save(self,path)
	if thing:
		print(thing)
		print(thing == OK)

static func load_from(path : String = Globals.SettingsPath):
	if ResourceLoader.exists(path):
		return ResourceLoader.load(path)
	return null

func load_settings():
	Audio.load_settings()
	Colors.load_settings()
