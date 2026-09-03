extends CharacterBody3D
 
## Velocidad máxima de desplazamiento, en metros por segundo.
@export var speed: float = 4.0
## Cámara que define qué es "adelante". Si se deja vacía se usa la activa.
@export var camara: Camera3D
 
## Aceleración y fricción horizontal, en metros por segundo al cuadrado.
@export var aceleracion: float = 20.0
@export var friccion: float = 25.0
 
## Gravedad y fuerza de salto, en metros por segundo al cuadrado / por segundo.
@export var gravedad: float = 9.8
@export var fuerza_salto: float = 6.0
 
func _ready() -> void:
	if camara == null:
		camara = get_viewport().get_camera_3d()
 
func _physics_process(delta: float) -> void:
	# --- Horizontal: hacia dónde quiere ir ------------------------------
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var entrada := Vector3(input_dir.x, 0.0, input_dir.y)
 
	# Movimiento relativo a la cámara (mismo patrón de la Sesión 8/9).
	var direction := camara.global_basis * entrada
	direction.y = 0.0
	direction = direction.normalized()
 
	# Tarea 3: aceleración y fricción con move_toward en vez de asignación directa.
	if direction != Vector3.ZERO:
		velocity.x = move_toward(velocity.x, direction.x * speed, aceleracion * delta)
		velocity.z = move_toward(velocity.z, direction.z * speed, aceleracion * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friccion * delta)
		velocity.z = move_toward(velocity.z, 0.0, friccion * delta)
 
	# Tarea 2: gravedad y salto.
	if not is_on_floor():
		velocity.y -= gravedad * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = fuerza_salto
 
	move_and_slide()
 
