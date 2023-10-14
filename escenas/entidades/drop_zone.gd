extends Marker2D
#dibuja en pantalla 
func _draw():
	draw_circle(Vector2.ZERO, 75, Color.BLANCHED_ALMOND)#dibuja un circulo tomando 3 valores (origen, tamaño, color)
	
#cambia de color cuando la zona es seleccionada
func  select():
	for child in get_tree().get_nodes_in_group("zona"):#todas las los lugares donde se puede dejar el objeto estan en un grupo llamado zonas
		child.deselect()
	modulate = Color.WEB_MAROON

#cambia de color cuando la zona es deselccionada
func deselect():
	modulate = Color.WHITE
