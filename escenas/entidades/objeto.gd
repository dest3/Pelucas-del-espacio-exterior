extends Node2D
#defino variables 
var selected = false #si esta seleccionado o no
var rest_point
var rest_nodes= []

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zona")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()

#cuando se le hace click al objeto seleccionado se pone verdadero
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

#si esta seleccionado todo el tiempo se pociciona en donde este el mouse
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)#hace que la posicion del objeto sea la del mouse
		#look_at(get_global_mouse_position()) #mueve el objeto en la direccion del mouse
	else:
		global_position = lerp(global_position, rest_point, 10 * delta) #hace que la posicion del objeto sea el ultimo rest point
		#rotation = lerp_angle(rotation, 0, 10 * delta)#vuelve al angulo por defecto del objeto al soltarlo

#si se le deja de hacer click al bojeto se desactvia selected y queda en el ultimo lugar que tuvo 
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			var shortest_dist = 75 #la distancia mas corta posible para dejar el objeto cerca de la znoa de drop (tamaño de la zona de drop)
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist:
					child.select()
					rest_point = child.global_position
					shortest_dist = distance
					
