extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = get_global_mouse_position()




#aca abajo detecto la colision y guardo como referencia el area con la que colisiona 
func _on_area_entered(area):
	pass
