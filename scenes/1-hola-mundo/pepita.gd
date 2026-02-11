extends Node2D
#        ^ Tiene que ser el tipo del nodo que tiene el script.

# SINTAXIS: las reglas según las cuales un código es válido o no.
# El lenguaje de programación de godot se llama GDScript.

# Si una linea empieza con numeral, esa línea no es código, es un
# comentario, lo que significa que no se ejecuta.

# Las variables tienen valores que pueden ir cambiando
# a lo largo de la vida del nodo.
var energia = 100
var posicion_x = 0
var posicion_y = 0

# _ready se va a ejecutar para cada nodo cuando el nodo entra a la escena
func _ready() -> void:
	# ^ tiene que haber un TAB en la linea siguiente a :
	#
	# VALOR: los datos que tenemos en nuestro programa.
	#      Es un VALOR.
	#        v 
	print("Hola mundo")
	# ^ print es una FUNCIÓN
	# FUNCIÓN: los cómandos que le damos a la computadora.
	#
	print("Tengo de energia ", energia)
	# Los valores que se pasan, van separados por coma
	#
	# Hay valores de diferentes TIPOS.
	# - String: todo lo que es texto. Se escribe entre comillas.
	# - Numeros.
	# - Booleanos. Es un tipo que tiene solo 2 valores: true y false.
	
	print("Mi posición es")
	print("X: ", posicion_x)
	print("Y: ", posicion_y)
	
	#print("Volé una vez hacia arriba")
	## Luego de volar una vez hacia arriba
	#energia = energia - 10
	#posicion_y = posicion_y - 100
	# Esto calcula un nuevo valor, que es (energia - 10) y pone
	# ese valor en la variable energia.
	
	#print("Me moví en este orden: arriba, abajo, derecha, derecha")
	## arriba
	#mover_arriba()
	## abajo
	#mover_abajo()
	## derecha
	#mover_derecha()
	## derecha
	#mover_derecha()
	
	print("Me intento mover: 6 veces para arriba, 5 para la derecha, 2 para abajo")
	mover_arriba()
	mover_arriba()
	mover_arriba()
	mover_arriba()
	mover_arriba()
	mover_arriba()
	mover_derecha()
	mover_derecha()
	mover_derecha()
	mover_derecha()
	mover_derecha()
	mover_abajo()
	mover_abajo()
	
	print("Ahora mi energia es: ", energia)
	print("Mi posición es")
	print("X: ", posicion_x)
	print("Y: ", posicion_y)
	
# Para definir una función, se escribe:
# func NOMBRE_DE_LA_FUNCION():
func mover_arriba():
	if energia > 0:
		energia = energia - 10
		posicion_y = posicion_y - 100

func mover_abajo():
	if energia > 0:
		energia = energia - 10
		posicion_y = posicion_y + 100

func mover_derecha():
	if energia > 0:
		energia = energia - 10
		posicion_x = posicion_x + 100

func mover_izquierda():
	if energia > 0:
		energia = energia - 10
		posicion_x = posicion_x - 100
