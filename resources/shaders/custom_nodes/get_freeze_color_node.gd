@tool
class_name VisualShaderNodeGetFreezeColorNode
extends VisualShaderNodeCustom


func _get_name():
	return "GetFreezeColor"


func _get_category():
	return ""


func _get_description():
	return "Gets the Freeze Color from an Index"


func _get_return_icon_type():
	return PORT_TYPE_VECTOR_4D


func _get_input_port_count():
	return 1


func _get_input_port_name(port):
	return "Freeze Color Index"


func _get_input_port_type(port):
	return PORT_TYPE_SCALAR_UINT


func _get_output_port_count():
	return 1


func _get_output_port_name(port):
	return "Freeze Color"


func _get_output_port_type(port):
	return PORT_TYPE_VECTOR_4D

func _get_global_code(mode):
	return """
	global uniform vec4 Freeze_Color_0;
	global uniform vec4 Freeze_Color_1;
	global uniform vec4 Freeze_Color_2;
	global uniform vec4 Freeze_Color_3;
	global uniform vec4 Freeze_Color_4;
	global uniform vec4 Freeze_Color_5;
	"""

func _get_code(input_vars, output_vars,
		mode, type):
	return """
	switch({Index}){
		case 0u: {Out_Color} = Freeze_Color_0; break;
		case 1u: {Out_Color} = Freeze_Color_1; break;
		case 2u: {Out_Color} = Freeze_Color_2; break;
		case 3u: {Out_Color} = Freeze_Color_3; break;
		case 4u: {Out_Color} = Freeze_Color_4; break;
		case 5u: {Out_Color} = Freeze_Color_5; break;
	}
	""".format({
		"Index": input_vars[0],
		"Out_Color": output_vars[0]
	})
