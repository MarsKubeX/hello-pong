extends CharacterBody2D
@onready var bounce_sound = $BounceSound

const INITIAL_SPEED = 300
const SPEED_INCREASE_AMOUNT = 15
const SPEED_INCREASE_INTERVAL = 1.0

var time_since_last_speed_increase = 0.0

func _ready():
	reset()

func _physics_process(delta):
	# Aumentar la velocidad con el tiempo
	time_since_last_speed_increase += delta
	if time_since_last_speed_increase >= SPEED_INCREASE_INTERVAL:
		# Aumentamos la velocidad manteniendo la dirección actual
		velocity = velocity.normalized() * (velocity.length() + SPEED_INCREASE_AMOUNT)
		time_since_last_speed_increase = 0.0

	# Mover la pelota y detectar colisiones
	var collision = move_and_collide(velocity * delta)
	
	# Si hay colisión, calculamos el rebote
	if collision:
		bounce_sound.play() # Reproducimos el sonido de rebote
		# La función bounce nos da el nuevo vector de velocidad después de un choque.
		# Necesitamos la "normal" de la colisión para saber cómo rebotar.
		velocity = velocity.bounce(collision.get_normal())

# Esta función se puede llamar para reiniciar la posición y velocidad de la pelota.
func reset():
	# Usamos el tamaño del viewport para centrar la pelota, es más robusto.
	position = get_viewport_rect().size / 2
	
	# Escogemos una dirección aleatoria
	var x_direction = [-1.0, 1.0].pick_random()
	var y_direction = [-1.0, 1.0].pick_random()
	
	velocity = Vector2(x_direction, y_direction).normalized() * INITIAL_SPEED
	time_since_last_speed_increase = 0.0
