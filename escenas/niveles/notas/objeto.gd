extends Node2D
class_name Documento

#señales para los eventos
signal drag_started(even_position)
signal drag_ended


#defino variables 
var nombre = ""
var selected = false #si esta seleccionado o no
var rest_point 
var rest_nodes= []
var body_ref
var is_inside_dropable = false
var mouse_over= false
var drops = []
var cant_correcta = 0
var offset:Vector2 


func _process(_delta):
	update_drop_count()
	check_victory()
	

#si esta selected cambia la ubicacion del objeto con la del mouse
func drag(delta):
	if selected:
		global_position = get_global_mouse_position() - offset
	else:
		if !is_inside_dropable:
			#global_position = lerp(global_position, rest_point, 10 * delta) #hace que la posicion del objeto sea el ultimo rest point
			rotation = lerp_angle(rotation, 0, 10 * delta)#vuelve al angulo por defecto del objeto al soltarlo

#si hace click
func up_click_izq(event):
	if event is InputEventMouseButton: #captura todos los eventos y comprueba si se levanta el click
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:#si boton izq no esta precionado
			global_var.is_draging = false
			selected= false
			emit_signal("drag_ended", event.position)
			#last_rest()

#si suelta el click
func down_click_izq(event):
	if Input.is_action_just_pressed("click") and mouse_over:
		selected = true
		emit_signal("drag_started",event.position)
		global_var.is_draging = true
		offset =  get_global_mouse_position() - global_position
		


#obtiene los puntos de anclaje al principio del nivel.
func get_rest_point():
	rest_nodes = get_tree().get_nodes_in_group("zona")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()
	
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
	print("colision")
	if body.is_in_group("respuesta") and body.respuesta == nombre:
		# El cuerpo es correcto
		body_ref = body
		is_inside_dropable = true
		print(nombre)
		selected=false
		# Cambiar la posición del objeto para que coincida con la del cuerpo
		global_position = body.global_position
		body_ref.fill = true

func get_drop():
	drops = get_tree().get_nodes_in_group("respuesta")
	for item in drops:
		if item.fill == true:
			cant_correcta = cant_correcta +1
	
func ganaste():
		get_tree().change_scene_to_file("res://escenas/niveles/ganaste.tscn")

func update_drop_count():
	cant_correcta = 0
	get_drop()

func check_victory():
	if cant_correcta >= 6:
		ganaste()

