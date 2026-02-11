extends CharacterBody2D
# Los CharacterBody2D tienen:
# velocity, que es la velocidad por segundo.
# la función move_and_slide(), que hace que se muevan según su velocity.

@export var rapidez = 500

func _ready() -> void:
	pass
	#position.y = position.y - 100
	#position.x = position.x - 100
	#velocity.x = 200
	#velocity.y = 100

# El código dentro de physics process se va a ejecutar CADA frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("mover_abajo"): # Si esto es verdad
		velocity.y = rapidez # HACE ESTO
	elif Input.is_action_pressed("mover_arriba"): # Si no, pero... si esto es verdad
		velocity.y = -rapidez # HACE ESTO
	else: # Si no, 
		velocity.y = 0 # HACE ESTO

	if Input.is_action_pressed("mover_derecha"):
		velocity.x = rapidez
	elif Input.is_action_pressed("mover_izquierda"):
		velocity.x = -rapidez
	else:
		velocity.x = 0
	
	move_and_slide()
