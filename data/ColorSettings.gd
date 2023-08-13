extends Resource
class_name ColorSettings

@export var FreezeColor0 : Color = Color.RED
@export var FreezeColor1 : Color = Color.YELLOW
@export var FreezeColor2 : Color = Color.GREEN
@export var FreezeColor3 : Color = Color.CYAN
@export var FreezeColor4 : Color = Color.BLUE
@export var FreezeColor5 : Color = Color.MAGENTA


func load_settings():
	RenderingServer.global_shader_parameter_set("Freeze_Color_0",FreezeColor0)
	RenderingServer.global_shader_parameter_set("Freeze_Color_1",FreezeColor1)
	RenderingServer.global_shader_parameter_set("Freeze_Color_2",FreezeColor2)
	RenderingServer.global_shader_parameter_set("Freeze_Color_3",FreezeColor3)
	RenderingServer.global_shader_parameter_set("Freeze_Color_4",FreezeColor4)
	RenderingServer.global_shader_parameter_set("Freeze_Color_5",FreezeColor5)
