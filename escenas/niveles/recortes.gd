extends Node2D

var paper_stack = []

func _ready():
	paper_stack = get_tree().get_nodes_in_group("recortes")
	

func add_paper(paper):
	
	
	paper_stack.append(paper)
	
	var count = 0
	for p in paper_stack:
		p.z_index = count
		
		count += 1

func push_paper_to_top(paper):
	paper_stack.erase(paper)
	add_paper(paper)
