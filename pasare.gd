class_name pasare
extends Area2D
@export var damage : int
@export var movement_speed :float 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.5).timeout
	queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x-=movement_speed*delta;



func _on_body_entered(body: Node2D) -> void:
	if body is player :
		body._damage_taken(damage)

	
			
