extends Node2D
class_name Documento

#señales para los eventos
signal drag_started(even_position)
signal drag_ended


#defino variables 
var nombre = "hola"
var selected = false #si esta seleccionado o no
var rest_point 
var rest_nodes= []
var body_ref
var is_inside_dropable = false
var mouse_over= false

func _ready():
	get_rest_point()

#cuando se le hace click al objeto, selected se pone verdadero
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	down_click_izq(event)

#si esta seleccionado todo el tiempo se pociciona en donde este el mouse
func _physics_process(delta):
	drag(delta)

#si se le deja de hacer click al bojeto se desactvia selected y queda en el ultimo lugar que tuvo 
func _input(event):
	up_click_izq(event)
	down_click_izq(event)


#si esta selected cambia la ubicacion del objeto con la del mouse
func drag(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)#calcula el offset y mueve el objeto a la pos del mouse
		#look_at(get_global_mouse_position()) #obtiene la hubicacion del mouse
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
			global_var.is_draging = false
			selected= false
			emit_signal("drag_ended", event.position)
			last_rest()
			

#si suelta el click
func down_click_izq(event):
	if Input.is_action_just_pressed("click") and mouse_over:
		selected = true
		emit_signal("drag_started",event.position)
		global_var.is_draging = true

#obtiene los puntos de anclaje al principio del nivel.
func get_rest_point():
	var random:int = randi() % 7
	rest_nodes = get_tree().get_nodes_in_group("zona")
	rest_point = rest_nodes[0].global_position
	rest_nodes[random].select()
	
#mouse over
func _on_area_2d_mouse_entered():
	scale = Vector2(1.05, 1.05)
	mouse_over = true
#mouse over'nt (?
func _on_area_2d_mouse_exited():
		scale = Vector2(1.0, 1.0)
		mouse_over = false

#aca compruebo si es correcta la ubicacion y acomodo en patalla
func _on_area_2d_body_entered(body: StaticBody2D):
	print("aguante godot ")
	if body.is_in_group("respuesta") and body.respuesta == nombre:
		
		body_ref = body
		print(nombre)
#genera un numero aleatorio
func random(min: int, max: int, cantidad: int, )-> Array:
	var random_numbers = []
	while random_numbers.size() < cantidad:
		var new_number =  randi_range(min,max)
		if not random_numbers.has(new_number):
			random_numbers.append(new_number)
	return random_numbers
