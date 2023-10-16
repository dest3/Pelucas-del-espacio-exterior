extends Node2D




func _on_play_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/Doc_game.tscn")

func _on_play2_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/juego_de_selección_de_palabras.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/creditos.tscn")
