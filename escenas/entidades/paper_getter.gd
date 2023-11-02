extends Area2D


func _ready():
	pass
	
func _process(delta):
	position = get_global_mouse_position()



func get_top_paper():
	var count = len(get_overlapping_areas())
	if (count == 0):
		pass
	elif (count == 1):
		get_overlapping_areas()
		if (Input.is_action_just_pressed("click")):
			get_parent().push_paper_to_top(get_overlapping_areas()[0])

	else:
		var max_index = -1
		var top_paper = null
		for b in get_overlapping_areas():
			if (b.z_index > max_index):
				max_index = b.z_index
				top_paper = b


		for b in get_overlapping_areas():
			if b != top_paper:
				b.chosen = false
		if (Input.is_action_just_pressed("click")):
			get_parent().push_paper_to_top(top_paper)
