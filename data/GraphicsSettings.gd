extends Resource
class_name GraphicsSettings

@export var WindowMode : int = 0
@export var FullscreenResolution : Vector2i = Vector2i(1920,1080)
@export var VSync : bool = true
@export var LimitFramerate : bool = false
@export var MaximumFramerate : int = 60

func _init():
	pass

func update_display_settings():
	var window_mode = [DisplayServer.WINDOW_MODE_WINDOWED,
						DisplayServer.WINDOW_MODE_FULLSCREEN,
						DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN][WindowMode]
	DisplayServer.window_set_mode(window_mode)
	if window_mode != DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_size(FullscreenResolution)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if VSync else DisplayServer.VSYNC_DISABLED)
	
	if LimitFramerate:
		Engine.max_fps = MaximumFramerate
	else: Engine.max_fps = 0

func load_settings():
	update_display_settings()
