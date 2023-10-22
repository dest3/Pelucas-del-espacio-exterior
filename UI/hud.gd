extends CanvasLayer




func _on_carpeta_azul_pressed():
	pass


func _on_maquina_de_escribir_pressed():
	pass # Replace with function body.


func _on_documentos_pressed():
	pass # Replace with function body.


func _on_maquina_de_video_pressed():
	pass # Replace with function body.


func _on_volver_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/taller.tscn")

func _process(_delta):
	if Input.is_action_pressed("salir"):
		get_tree().change_scene_to_file("res://escenas/niveles/menu.tscn")
		
