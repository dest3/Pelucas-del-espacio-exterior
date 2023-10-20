extends Node2D


func _on_play_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/videos/video_intro.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/creditos.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://UI/hud.tscn")

func _on_archivos_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/videos/documento_video_intro.tscn")

func _on_documentos_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/Doc_game.tscn")

func _on_maquna_de_escribir_pressed():
	pass # Replace with function body.

func _on_carpeta_azul_pressed():
	pass # Replace with function body.

func _on_maquina_de_cine_pressed():
	pass # Replace with function body.

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/menu.tscn")

func _on_tallerdoc_pressed():
	get_tree().change_scene_to_file("res://UI/hud.tscn")
