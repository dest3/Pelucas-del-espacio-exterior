extends Node2D

# Lista de palabras clave
var palabras_clave = ["gato", "perro", "casa", "árbol", "sol"]

# Lista de objetos que representan las palabras clave
var objetos_clave = []

# Contenedor para la hoja de texto
var hoja_texto = text.tscn

# Contenedor para las zonas de destino
var zonas_destino = text.tscn

# Inicializa el juego
func _ready():
	# Crea las palabras clave
	for palabra in palabras_clave:
		var objeto_clave = text.tscn
		objeto_clave.text = palabra
		objeto_clave.pos = Vector2(randi() * 200, randi() * 200)
		objetos_clave.append(objeto_clave)

	# Crea las zonas de destino
	for i in range(len(palabras_clave)):
		var zona_destino = text.tscn
		zona_destino.texture = preload("pizarron.png")
		zona_destino.pos = Vector2(i * 100, 200)
		zonas_destino.add_child(zona_destino)

	# Agrega la hoja de texto y las zonas de destino al juego
	add_child(hoja_texto)
	add_child(zonas_destino)

# Detecta cuando se arrastra un objeto
func _on_objeto_clave_input_event(event):
	# Si el evento es un evento de arrastre
	if event.type == InputEvent.MOUSE_BUTTON_PRESSED:
		# Obtiene la posición del mouse
		var posicion_mouse = event.pos

		# Encuentra el objeto que se está arrastrando
		var objeto_arrastrado = get_node(".")

		# Si el objeto está dentro de una zona de destino
		for zona_destino in zonas_destino.get_children():
			if zona_destino.get_rect().contains(posicion_mouse):
				# Elimina el objeto de la hoja de texto
				hoja_texto.remove_child(objeto_arrastrado)

				# Agrega el objeto a la zona de destino
				zona_destino.add_child(objeto_arrastrado)

				# Marca la zona de destino como completada
				zona_destino.modulate = Color.GREEN

# Verifica si el juego ha terminado
func _on_game_over():
	# Si todas las zonas de destino están completas
	if zonas_destino.get_children().size() == 0:
		# Muestra un mensaje de victoria
		get_node("texto_victoria").show()

# Se ejecuta cada frame
func _physics_process(delta):
	# Verifica si el juego ha terminado
	_on_game_over()
