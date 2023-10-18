extends Documento

class_name docu_foto

func _ready():
	var foto= Documento.new()
	foto.nombre = "foto"
	rest_nodes = get_tree().get_nodes_in_group("zona")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()
	
func _input_event(viewport, event, shape_idx):
	down_click_izq(event)
