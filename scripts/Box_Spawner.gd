extends Marker2D
@export var cutie : PackedScene 

func _ready() -> void:
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	_spawn_enemy()
	
func _spawn_enemy() -> void :
	var _enemy_position : float= randf()
	var _first_enemy : Node2D =cutie.instantiate()
	_first_enemy.global_position=global_position
	get_tree().root.add_child(_first_enemy)
	$Timer.wait_time = randf_range(2,5)
