extends Node2D
class_name NaviServer

@onready var navi_map
@export_node_path("NavigationRegion2D") var navi_region

var path : PackedVector2Array

func _ready():
	# setup should called by NaviSetup
#	call_deferred("custom_setup")

	pass
	
func custom_setup(navi_region : NavigationRegion2D):
	var map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)
	
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, map)
	NavigationServer2D.region_set_navigation_polygon(region, navi_region.get_navigation_polygon())
	
	navi_map = map
	

### return a point list for navigation
func get_navi_path_to(start_position, end_position):
	return NavigationServer2D.map_get_path(navi_map, start_position, end_position, true)
	
