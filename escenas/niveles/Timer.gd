extends Timer


var label

func _ready():
	label = get_node("Label")
	
func _process(delta):
	label.set_text(str(time_left))

func _on_timeout():
	get_tree().change_scene_to_file("res://escenas/niveles/perder.tscn")
