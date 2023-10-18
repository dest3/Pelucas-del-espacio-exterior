extends Area2D

@export var respuesta = ""

var objeto
var mouse_over= false
#dibuja en pantalla 
func _draw():
	draw_circle(Vector2.ZERO, 60, Color.BLANCHED_ALMOND)#dibuja un circulo tomando 3 valores (origen, tamaño, color)	

#cambia de color cuando la zona es seleccionada
func  select():
	for child in get_tree().get_nodes_in_group("respuesta"):#todas las los lugares donde se puede dejar el objeto estan en un grupo llamado zonas
		child.deselect()
	modulate = Color.WEB_MAROON

#cambia de color cuando la zona es deselccionada
func deselect():
	modulate = Color.WHITE

#detecta el area que ingresa y verifica si es correcto
func _on_area_entered(area):
	if mouse_over:
		objeto = area.get_script()
		print(objeto)



func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
