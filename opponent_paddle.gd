extends CharacterBody2D


const SPEED = 450.0

# Refencia al nodo de la pelota para poder acceder a su posición.
@export var ball: CharacterBody2D = null

func _physics_process(delta: float) -> void:
	if not ball:
		return # Si no tenemos referencia a la pelota, no hacemos nada.
	
	# Solo movemos la pala si la pelota viene hacia nosotros (de izquierda a derecha).
	if ball.velocity.x > 0:
		# Calculamos la direccion hacia la pelota en el eje Y.
		var direction_y = sign(ball.global_position.y - global_position.y)
		velocity.y = direction_y * SPEED
	else:
		# Si la pelota se aleja, la pala se detiene.
		velocity.y = 0
	
	# Usamos move_and_slide para mover la pala. Es el método estándar para CharacterBody2D.
	move_and_slide()
