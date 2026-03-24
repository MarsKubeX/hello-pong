extends Node2D

@onready var score_sound = $ScoreSound
@onready var theme_song = $ThemeSong

# Variables para la puntuación.
var player_score = 0
var opponent_score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	theme_song.play() # Reproducimos la música de fondo al iniciar el juego.
	$PuntuacionJugadorLabel.text = str(player_score)
	$PuntuacionOponenteLabel.text = str(opponent_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Funciones para manejar los goles. Estas se conectarán a las señales de las zonas de gol.
func _on_zona_gol_derecha_body_entered(body: Node2D) -> void:
	if body.name != "Ball":
		return # Solo queremos contar goles si la pelota entra en la zona de gol.
	score_sound.play() # Reproducimos el sonido de puntuación
	print("!!! GOL DERECHA DETECTADO !!!") 
	player_score += 1
	$PuntuacionJugadorLabel.text = str(player_score)
	$Ball.reset()

	


func _on_zona_gol_izquierda_body_entered(body: Node2D) -> void:
	if body.name != "Ball":
		return # Solo queremos contar goles si la pelota entra en la zona de gol.
	score_sound.play() # Reproducimos el sonido de puntuación
	print("!!! GOL IZQUIERDA DETECTADO !!!") 
	opponent_score += 1
	$PuntuacionOponenteLabel.text = str(opponent_score)
	$Ball.reset()


func _on_theme_song_finished() -> void:
	theme_song.play() # Reproducimos la música de fondo en bucle cuando termine.
