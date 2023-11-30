extends Node2D
class_name stack


var paper_stack = []
var childrens

# cuando el nodo esta listo obtiene todos sus nodos hijos y agrega estos a paper stak 
func _ready():
	childrens = get_children(false)
	for child in childrens:
		add_paper(child)
		child.fui_apretado.connect(self.push_paper_to_top)

# esta funcion recorre todos los nodos en papar_stak y les asigna un z index segun su posicion en el array 
func add_paper(paper):
	paper_stack.push_back(paper)
	
	var count = 0
	for p in paper_stack:
		p.z_index = count
		
		count += 1

#esta funcion borra del stack el nodo seleccionado y lo vuelve a agregar para dejarlo en la pos 0 
func push_paper_to_top(paper):
	paper_stack.erase(paper)
	add_paper(paper)




