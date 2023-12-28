extends Sprite2D

var drops = null
var cant_correcta = 0

func _ready():
	drops = get_children()


func _process(_delta):
	get_drop()

func get_drop():
	for item in drops:
		if item.fill == true:
			cant_correcta = cant_correcta +1
			print(cant_correcta)
	
	if cant_correcta >= 6:
		ganaste()
	
func ganaste():
		#aca se tiene que controlar que nota esta haciendo cuando complete una se tiene que llevar a la carpeta de inventario
		get_tree().change_scene_to_file("res://escenas/niveles/ganaste.tscn")#esto ya no serviria
		global_var.mi_cucha_win = true#cada vez que complete una nota se tiene que actualizar la variable global para habilitar las notas completas en el inventario
