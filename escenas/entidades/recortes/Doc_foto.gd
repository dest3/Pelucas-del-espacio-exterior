extends Documento
class_name doc_foto
var mouse_over = true

func _ready():
	nombre = "foto"
	get_rest_point()


# Sobrescribe el método "_input" para manejar eventos de entrada del mouse
func _input(event):
	if event is InputEventMouseButton and mouse_over:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			# Cuando se presiona el botón izquierdo del mouse
			selected = true
			emit_signal("drag_started", event.position)
			print(nombre)
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.is_pressed():
			# Cuando se libera el botón izquierdo del mouse
			selected = false
			emit_signal("drag_ended", event.position)
			last_rest()


func _on_area_2d_mouse_entered():
	mouse_over = true


func _on_area_2d_mouse_exited():
	mouse_over = false
	
