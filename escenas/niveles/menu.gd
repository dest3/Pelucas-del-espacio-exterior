extends Node2D




func _on_play_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/video_intro.tscn")



func _on_quit_pressed():
	get_tree().quit()


func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://escenas/niveles/creditos.tscn")



func _on_button_pressed():
	get_tree().change_scene_to_file("res://UI/hud.tscn")
