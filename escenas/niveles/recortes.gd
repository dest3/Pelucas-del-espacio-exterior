extends Node2D
class_name stack


var paper_stack = []
var childrens

#esta funcion imprime por consola todos los nodos de children al apretar espacio
func _process(_delta):
	test()

# cuando el nodo esta listo obtiene todos sus nodos hijos y agrega estos a paper stak 
func _ready():
	childrens = get_children(false)
	for child in childrens:
		add_paper(child)

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



func test():
	if Input.is_action_pressed("test"):
		print(childrens)
		print(paper_stack)
