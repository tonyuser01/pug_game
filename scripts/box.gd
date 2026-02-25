extends Node2D
@onready var cutia: Sprite2D = $cutia
const min_scale : float =2.5 ;
const max_scale : float =5.0 ;
@export var damage = 25;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cutia.scale.y=randf_range(min_scale,max_scale) # Replace with function body.
	cutia.scale.x=randf_range(min_scale,max_scale) # Replace with function body.
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player :
		body._damage_taken(damage);
		$cutia/Area2D/CollisionShape2D.queue_free();
	

func _on_timer_timeout() -> void:
	queue_free()
