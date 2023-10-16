extends Documento

var nombre = "imagen"
var mouse_over = true

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zona")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()

# Sobrescribe el método "_input" para manejar eventos de entrada del mouse
func _input(event):
	if event is InputEventMouseButton and mouse_over:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			# Cuando se presiona el botón izquierdo del mouse
			selected = true
			emit_signal("drag_started", event.position)
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.is_pressed():
			# Cuando se libera el botón izquierdo del mouse
			selected = false
			emit_signal("drag_ended", event.position)
			last_rest()


func _on_area_2d_mouse_entered():
	mouse_over = true


func _on_area_2d_mouse_exited():
	mouse_over = false
	
