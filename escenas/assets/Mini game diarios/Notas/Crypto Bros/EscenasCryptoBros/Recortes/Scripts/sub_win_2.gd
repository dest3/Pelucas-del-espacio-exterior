extends  Documento


func _ready():
	nombre = "sub_win_2"
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
