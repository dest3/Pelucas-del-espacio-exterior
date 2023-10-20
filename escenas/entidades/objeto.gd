extends Node2D
class_name Documento

#señales para los eventos
signal drag_started(even_position)
signal drag_ended


#defino variables 
var nombre = "documento"
var selected = false #si esta seleccionado o no
var rest_point 
var rest_nodes= []




#si esta selected cambia la ubicacion del objeto con la del mouse
func drag(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)#hace que la posicion del objeto sea la del mouse
		look_at(get_global_mouse_position()) #mueve el objeto en la direccion del mouse
	else:
		global_position = lerp(global_position, rest_point, 10 * delta) #hace que la posicion del objeto sea el ultimo rest point
		rotation = lerp_angle(rotation, 0, 10 * delta)#vuelve al angulo por defecto del objeto al soltarlo

#obtiene todos los puntos de anclaje iniciales y setea como origen
func last_rest():
	var shortest_dist = 75 #la distancia mas corta posible para dejar el objeto cerca de la znoa de drop (tamaño de la zona de drop)
	for child in rest_nodes:
		var distance = global_position.distance_to(child.global_position)
		if distance < shortest_dist:
			child.select()
			rest_point = child.global_position
			shortest_dist = distance

#si hace click
func up_click_izq(event):
	if event is InputEventMouseButton: #captura todos los eventos y comprueba si se levanta el click
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:#si boton izq no esta precionado
			selected = false
			emit_signal("drag_ended", event.position)
			last_rest()

#si suelta el click
func down_click_izq(event):
	if Input.is_action_just_pressed("click"):
		print(nombre)
		selected = true
		emit_signal("drag_started",event.position)
	

#obtiene los puntos de anclaje al principio del nivel.
func get_rest_point():
	rest_nodes = get_tree().get_nodes_in_group("zona")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()

