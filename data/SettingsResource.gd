extends Resource
class_name SettingsResource

func _init():
	pass

func save(path : String = Globals.SettingsPath):
	prints("Saving Settings to path:", path)
	ResourceSaver.save(self,path)

static func load_from(path : String = Globals.SettingsPath):
	if ResourceLoader.exists(path):
		return ResourceLoader.load(path)
	return null
