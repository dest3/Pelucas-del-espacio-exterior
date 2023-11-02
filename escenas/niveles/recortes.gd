extends Node2D
class_name recortes

var paper_stack = []

#obtiene todos los nodos hijos del nodo "recortes"
func _ready():
	paper_stack = get_children()
	
func _process(delta):
	if Input.is_action_just_pressed("test"):
		print(paper_stack)

func add_paper(paper):
	
	
	paper_stack.append(paper)
	
	var count = 0
	for p in paper_stack:
		p.z_index = count
		
		count += 1

func push_paper_to_top(paper):
	paper_stack.erase(paper)
	add_paper(paper)
