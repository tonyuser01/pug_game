extends Node2D

@export var damage = 25;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player :
		body._damage_taken(damage);
		$Sprite2D/Area2D/CollisionShape2D.queue_free();
	

func _on_timer_timeout() -> void:
	queue_free()
