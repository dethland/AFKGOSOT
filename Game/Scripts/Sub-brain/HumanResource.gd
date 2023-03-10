extends Node
class_name HumanResource

var unfinished_requests = [] # [[target_id, colonists_needed], ...]
var out_requests = [] # [[house_id, target_id, colonists_needed], ...]
var test_out_requests = [[1, 2, 2]]
	
func add_request(caller_id, colonists_needed):
	unfinished_requests.append([caller_id, colonists_needed])

func check_requests():
	for request in unfinished_requests:
		var colonists_needed = request[1]
		for house in FS.get_houses_list():
			if house is Facility:
				var house_population = house.get_population()
				
				# enough colonists in house
				if house_population >= colonists_needed:
					out_requests.append([house.get_id(), request[0], colonists_needed])
					house.set_population(house_population - colonists_needed)
					break
				# need more colonists than in house
				else:
					colonists_needed -= house_population
					out_requests.append([house.get_id(), request[0], colonists_needed])
					house.set_population(0)
	unfinished_requests.clear()
	send_out_requests(null)


# send fufilled requests to houses
func send_out_requests(overide):
	if overide != null:
		out_requests = overide
	for request in out_requests:
		var house : Facility = FS.get_facility_by_id(request[0])
		print("the house " + house.name)
		house.send_people_to(request[1], request[2])
	out_requests.clear()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("requst sent")
		send_out_requests(test_out_requests)
