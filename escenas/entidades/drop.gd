extends StaticBody2D

@export var respuesta = ""


func _ready():
	modulate = Color(Color.MEDIUM_PURPLE,0.7)


func _process(_delta):
	if global_var.is_draging:
		visible = true
	else:
		visible = false
