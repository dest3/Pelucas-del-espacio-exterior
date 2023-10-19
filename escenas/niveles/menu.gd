extends Node2D


func _on_play_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/videos/video_intro.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/creditos.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://UI/hud.tscn")

#main
#video intro
func _on_archivos_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/videos/documento_video_intro.tscn")
#mini juego
func _on_documentos_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/Doc_game.tscn")
#vuelve al menu desde docs
func _on_tallerdoc_pressed():
	get_tree().change_scene_to_file("res://UI/hud.tscn")

#video intro
func _on_maquna_de_escribir_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/videos/maquina_de_escribir_intro.tscn")
#video intro
func _on_carpeta_azul_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/videos/carpeta_azul_video.tscn")

func _on_maquina_de_cine_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/videos/maquina_de_video.tscn")
#vuelve a menu
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/menu.tscn")
#vuelve al home desde el juego de documentos

#falta minigame
func _on_play_maquina_de_escribi_pressed():
	pass # Replace with function body.

#falta minigame
func _on_play_carpeta_azul_pressed():
	pass # Replace with function body.

#falta mini game
func _on_play_maquina_escribir_pressed():
	pass # Replace with function body.
