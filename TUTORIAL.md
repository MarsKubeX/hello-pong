# Hello Pong - Un tutorial de Godot

**Nota para el Asistente de IA:** A lo largo de este tutorial, tu rol es ser mi guía.

- **Para cambios en la interfaz de Godot:** Explícame paso a paso qué debo hacer en la interfaz gráfica del editor (por ejemplo, "arrastra este nodo", "cambia esta propiedad en el Inspector").
- **Para cambios de código:** Proponme el código que necesito escribir, explícame claramente el porqué de esos cambios y yo me encargaré de escribirlo manualmente.

No modifiques los archivos del proyecto directamente. El objetivo es que yo aprenda los conceptos básicos de Godot.

¡Bienvenido a "Hello Pong"! En este tutorial, construiremos un juego de Pong simple para aprender los conceptos básicos de Godot Engine. El objetivo es tener una guía paso a paso que pueda ser consultada en cualquier momento, incluso si el contexto de la conversación se pierde.

## Resumen Técnico Actual

- **Motor de Juego:** Godot 4.x
- **Nodos Principales:**
  - `main.tscn`: La escena principal que contiene todos los elementos del juego.
  - `ball.tscn`: Una escena para la pelota, de tipo `CharacterBody2D`. Este nodo permite un control manual preciso sobre el movimiento y la colisión.
  - `player_paddle.tscn`: Una escena para las palas, también de tipo `CharacterBody2D`. Este nodo es ideal para personajes controlados por el jugador, ya que ofrece un control directo del movimiento.
- **Scripts (`.gd`)**
  - `ball.gd`: Controla el comportamiento de la pelota. Usa `move_and_collide` para mover la pelota y calcula manualmente el rebote cuando se detecta una colisión.
  - `player_paddle.gd`: Gestiona el movimiento de las palas del jugador. Usa `move_and_slide` para un movimiento suave que respeta las colisiones.
  - `main.gd`: Gestiona la lógica principal del juego (aunque actualmente está mayormente vacío).

## Hoja de Ruta del Tutorial

Esta es nuestra etapa actual.
A continuación se detallan las etapas completadas y las futuras para desarrollar el juego.

### Etapa 1: La Pelota que Rebota (Completada)

En esta primera fase, creamos el elemento más dinámico del juego: la pelota. Se optó por un `CharacterBody2D` para tener control total sobre su comportamiento físico.

#### Detalles Técnicos:

1.  **Creación de la Escena de la Pelota:**
    - Se creó una nueva escena con un nodo raíz `RigidBody2D`.
    - Se añadieron un `Sprite2D` para la imagen y un `CollisionShape2D` para definir su área de colisión.

2.  **Script de la Pelota (`ball.gd`):**
    - Se adjuntó un script al `CharacterBody2D`.
    - En `_physics_process(delta)`, se utiliza la función `move_and_collide()`. Esta función intenta mover el cuerpo y se detiene si choca, devolviendo información sobre la colisión.
    - Si `move_and_collide()` detecta una colisión, usamos la información del choque (específicamente, la "normal" de la superficie) para calcular el nuevo vector de dirección con el método `bounce()`. Esto simula el rebote de la pelota.
    - Se creó una función `reset()` para inicializar la pelota en el centro con una dirección aleatoria.

### Etapa 2: Las Palas del Jugador (Completada)

Con la pelota en su sitio, el siguiente paso fue dar al jugador el control sobre las palas.

#### Detalles Técnicos:

1.  **Creación de la Escena de la Pala:**
    - Se creó una escena `player_paddle.tscn` con un nodo raíz `CharacterBody2D`. Este nodo es perfecto para el control del jugador, ya que no se ve afectado por la física externa (como la gravedad) a menos que lo programemos.
    - Al igual que con la pelota, se le añadieron un `Sprite2D` y un `CollisionShape2D`.

2.  **Script de Movimiento (`player_paddle.gd`):**
    - El script lee las entradas del teclado (W/S y Flechas Arriba/Abajo) usando `Input.get_axis()`.
    - Se asigna una velocidad vertical (`velocity.y`) basada en la entrada del jugador.
    - Se llama a `move_and_slide()`. Esta es la función clave para los `CharacterBody2D` controlados por el jugador. Mueve el cuerpo a lo largo de su vector de velocidad y se desliza suavemente a lo largo de cualquier obstáculo que encuentre (como los límites superior e inferior de la pantalla), sin detenerse bruscamente.
    - Se utilizó una variable `@export var player_number` para poder usar la misma escena y script para ambas palas, simplemente cambiando el número de jugador en el Inspector de Godot desde la escena `main`.

### Etapa 3: La Pala del Oponente (Completada)

#### Pasos:

1.  **Crear la pala del oponente:** Podemos duplicar la escena de la pala del jugador.
2.  **Implementar IA simple:** Crear un script que haga que la pala del oponente siga la posición `y` de la pelota, con un ligero retardo o imprecisión para que no sea imbatible.

### Etapa 4: Puntuación y Lógica del Juego (Completado)

#### Pasos:

1.  **Crear zonas de gol:** Añadir nodos `Area2D` en los lados izquierdo y derecho de la pantalla.
2.  **Detectar goles:** Cuando la pelota entre en una de estas `Area2D`, se registrará un punto.
3.  **Crear UI de Puntuación:** Usar nodos `Label` para mostrar la puntuación de cada jugador en la pantalla.
4.  **Reiniciar la pelota:** Después de un gol, la pelota debe volver al centro de la pantalla y lanzarse hacia el jugador que no anotó.

### Etapa 5: Toques Finales (Completado)

#### Pasos:

1.  **Añadir efectos de sonido:** Para los rebotes y los goles.
2.  **Crear un menú de inicio:** Una escena simple con un botón de "Jugar".
3.  **Pulir el juego:** Ajustar velocidades, tamaños y colores para una mejor experiencia.
