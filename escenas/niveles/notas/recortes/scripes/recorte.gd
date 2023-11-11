extends Documento

@export var nombre = ""


func _ready():
	get_rest_point()
	

func _process(_delta):
	get_drop()

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



func get_drop():
	cant_correcta = 0
	drops = get_tree().get_nodes_in_group("respuesta")
	for item in drops:
		if item.fill == true:
			cant_correcta = cant_correcta +1
	
	if cant_correcta >= 6:
		ganaste()
	
func ganaste():
		#aca se tiene que controlar que nota esta haciendo cuando complete una se tiene que llevar a la carpeta de inventario
		get_tree().change_scene_to_file("res://escenas/niveles/ganaste.tscn")#esto ya no serviria
		global_var.mi_cucha_win = true#cada vez que complete una nota se tiene que actualizar la variable global para habilitar las notas completas en el inventario



	
