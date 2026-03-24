extends CharacterBody2D

# La velocidad a la que se moverá la pala, en píxeles por segundo.
@export var SPEED = 400
@export var player_number = 1


func _physics_process(delta: float) -> void:
	# Obtiene la dirección de entrada del jugador.
	var direction = 0.0
	# "player1_move_up" y "player1_move_down" son las acciones de entrada.
	if player_number == 1:
		direction = Input.get_axis("player1_move_up", "player1_move_down")
	else:
		# "player2_move_up" y "player2_move_down" son las acciones de entrada.
		direction = Input.get_axis("player2_move_up", "player2_move_down")

	# Asigna la velocidad vertical de la pala.
	velocity.y = direction * SPEED
	# Aseguramos que no nos movemos en el eje X.
	velocity.x = 0

	# move_and_slide() mueve el cuerpo y gestiona las colisiones,
	# haciendo que se deslice a lo largo de los obstáculos.
	# Es la forma estándar y recomendada de mover CharacterBody2D.
	move_and_slide()
