extends Node2D
@export var _scena_pasare: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	_spawn_enemy()
	
func _spawn_enemy() -> void :
	var _enemy_position : float= randf()
	var _first_enemy : pasare = _scena_pasare.instantiate()
	$Path2D/PathFollow2D.progress_ratio =_enemy_position
	_first_enemy.global_position=$Path2D/PathFollow2D.global_position
	get_tree().root.add_child(_first_enemy)
	$Timer.wait_time = randf_range(2,5)
	
	
	
