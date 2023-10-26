extends Timer

var label
var seconds = 0
var minutes = 0

@export var Dseconds = 30
@export var Dminutes = 0

func _ready():
	resetTimer()
	label = get_node("Label")

func _process(delta):
	# Actualiza la etiqueta con el tiempo que falta
	label.text = str(minutes) + ":" + str(seconds)

func _on_timeout():
	# Reduce los segundos
	seconds -= 1

	# Si los segundos llegan a -1, reduce los minutos y establece los segundos en 59
	if seconds < 0:
		if minutes > 0:
			minutes -= 1
			seconds = 59

	# Si los minutos son 0 y los segundos son 0, cambia a la escena de perder
	if minutes == 0 and seconds == 0:
		get_tree().change_scene("res://escenas/niveles/perder.tscn")

func resetTimer():
	# Establece el tiempo en el valor predeterminado
	seconds = Dseconds
	minutes = Dminutes
