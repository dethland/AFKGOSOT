extends Node
class_name ResourceDataServer

func _get_world_data():
	pass
	
func easy_resource_create(str_value : String, int_value : int):
	var result = ResourceData.new()
	result.set__name(str_value)
	result.set_amount(int_value)
	return result
