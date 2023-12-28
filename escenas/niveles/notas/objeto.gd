#@tool
extends Node2D
class_name Documento

signal fui_apretado(document)

#@export var collision_area: Area2D
#defino variables 
var selected = false #si esta seleccionado o no
var rest_point 
var rest_nodes= []
var body_ref
var is_inside_dropable = false
var mouse_over= false
var drops = []

var offset:Vector2 

#agrega advertencias de construccion de objetos dragables
#func _get_configuration_warnings():
#	if(not collision_area):
#		return ["Deberia tener un area2D"]
#	else:
#		pass
#
#func _physics_process(delta):
#	if Engine.is_editor_hint():
#		return
#	drag(delta)

#si esta selected cambia la ubicacion del objeto con la del mouse

func drag(delta):
	if selected:
		global_position = get_global_mouse_position() - offset
	else:
		if !is_inside_dropable:
			rotation = lerp_angle(rotation, 0, 10 * delta)#vuelve al angulo por defecto del objeto al soltarlo

#si suelta el click
func up_click_izq(event):
	if event is InputEventMouseButton: #captura todos los eventos y comprueba si se levanta el click
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:#si boton izq no esta precionado
			global_var.is_draging = false
			selected= false
			scale = Vector2(1.0, 1.0)



# handlea 
func apretado():
	selected = true
#	emit_signal("drag_started",get_global_mouse_position())
	global_var.is_draging = true
	offset =  get_global_mouse_position() - global_position
	scale = Vector2(2.0, 2.0)
	fui_apretado.emit(self)


#si hace clickl
func down_click_izq(_event):
	pass


#mouse over
func _on_area_2d_mouse_entered():
	scale = Vector2(1.05, 1.05)
	mouse_over = true


#mouse over'nt (?
func _on_area_2d_mouse_exited():
		scale = Vector2(1.0, 1.0)
		mouse_over = false


