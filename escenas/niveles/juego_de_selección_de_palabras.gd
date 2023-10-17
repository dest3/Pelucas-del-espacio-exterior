extends CharacterBody2D

var palabras = []
var puntaje = 0

func _ready():
	# Crear un arreglo de palabras
	for i in range(5):
		palabras.append(Sprite2D.new())
		palabras[i].name = "Palabra " + str(i)
		palabras[i].color = Color.AQUA
		palabras[i].position = Vector2(randf(), randf())

	# Agregar las palabras al canvas
	CanvasLayer.get_node("Canvas").add_child(palabras[0])
	CanvasLayer.get_node("Canvas").add_child(palabras[1])
	CanvasLayer.get_node("Canvas").add_child(palabras[2])
	CanvasLayer.get_node("Canvas").add_child(palabras[3])
	CanvasLayer.get_node("Canvas").add_child(palabras[4])

	# Agregar el cursor al canvas
	CanvasLayer.get_node("Canvas").add_child(self)

func _physics_process(delta):
	# Mover el cursor
	position += velocity * delta

	# Verificar si el cursor está sobre una palabra
	for palabra in palabras:
		if palabra.get_global_rect().contains(position):
			# Seleccionar la palabra
			palabra.color = Color.green
			puntaje += 1

	# Mostrar el puntaje
	Label.get_node("Texto").text = "Puntaje: " + str(puntaje)
