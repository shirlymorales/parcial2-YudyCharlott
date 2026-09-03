extends Area3D

## Debería mantenerse "activa" mientras el jugador esté cerca Y mantenga
## presionada la acción — no solo el instante en que la presiona.

var jugador_cerca: bool = false


func _ready() -> void:
	body_entered.connect(_al_entrar)
	body_exited.connect(_al_salir)


func _al_entrar(_cuerpo: Node3D) -> void:
	jugador_cerca = true


func _al_salir(_cuerpo: Node3D) -> void:
	jugador_cerca = false


func _physics_process(_delta: float) -> void:
	if jugador_cerca and Input.is_action_pressed("accion"):
		print("Puerta activada")
