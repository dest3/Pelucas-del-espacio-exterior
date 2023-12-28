extends Documento

@export var nombre = ""



#cuando se le hace click al objeto, selected se pone verdadero
func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	pass


#si esta seleccionado todo el tiempo se pociciona en donde este el mouse
func _physics_process(delta):
	drag(delta)

#si se le deja de hacer click al bojeto se desactvia selected y queda en el ultimo lugar que tuvo 
func _input(event):
	up_click_izq(event)


#aca compruebo si es correcta la ubicacion y acomodo en patalla
func _on_area_2d_body_entered(body: StaticBody2D):
#	print("colision")
	if body.is_in_group("respuesta") and body.respuesta == nombre:
		# El cuerpo es correcto
		body_ref = body
		body_ref.fill =true
		is_inside_dropable = true
		print(nombre) 
		selected=false
		# Cambiar la posición del objeto para que coincida con la del cuerpo
		global_position = body.global_position





	
