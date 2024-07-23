extends Node3D

signal Interacted

func _input(event):
	if event.is_action_pressed("Interact"):
		var bodies = $Area3D.get_overlapping_bodies()
		
		if bodies.size() == 1:
			print(bodies.size())
			Interacted.emit()
			$AnimationPlayer.play("lever")


func _on_area_3d_body_entered(_body):
	$CanvasLayer/Label.show()

func _on_area_3d_body_exited(_body):
	$CanvasLayer/Label.hide()
