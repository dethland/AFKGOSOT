extends Node2D

@onready var navi_map
@onready var navi_region = $NavigationRegion2D

var start_position = Vector2.ZERO

var path : PackedVector2Array



func _ready():
	call_deferred("custom_setup")
	
func custom_setup():
	var map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)
	
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, transform)
	NavigationServer2D.region_set_map(region, map)
	NavigationServer2D.region_set_navigation_polygon(region, navi_region.navigation_polygon)
	
	await get_tree().physics_frame
	
	var start_position = Vector2.ZERO
	var end_position = Vector2(292, 292)
	
	path = NavigationServer2D.map_get_path(map, start_position, end_position, true)
	print(path)
	
	navi_map = map
	
	set_process(true)
	
	queue_redraw()

	
func _draw():
	if path.is_empty():
		return 
		
	for posi in path:
		draw_circle(posi, 5, Color.DARK_RED)
		
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var end_position = get_global_mouse_position()
		path = NavigationServer2D.map_get_path(navi_map, start_position, end_position, true)
		queue_redraw()
