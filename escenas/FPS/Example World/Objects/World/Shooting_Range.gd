extends Node3D

func Start():
	var Child = get_children()
	for c in Child:
		var i_child = c.get_children()
		for i in i_child:
			if i.is_in_group("Target"):
				if i.has_method("Rise_Up"):
					i.Rise_Up()
	


func _on_button_interacted():
	Start()
