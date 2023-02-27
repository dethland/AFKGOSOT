extends Node
class_name NaviServer

@onready var navi_map
@onready var navi_region = NavigationRegion2D.new() ## empty need construct

var path : PackedVector2Array

func _ready():
	call_deferred("custom_setup")
	
func custom_setup():
	var map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)
	
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, map)
	NavigationServer2D.region_set_navigation_polygon(region, navi_region.navigation_polygon)
	
	await get_tree().physics_frame
	
	navi_map = map
	
	set_process(true)

### return a point list for navigation
func get_navi_path_to(start_position, end_position):
	return NavigationServer2D.map_get_path(navi_map, start_position, end_position, true)
	