extends Area2D


@export var max_distance: int = 1000
@export var movement_speed: int = 200
@export var damage: int = 999

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Move chaser forward
	position.x += movement_speed * delta
	
	var player =get_tree().get_first_node_in_group("player")
	var player_position 
	# Get positions
	if player != null:
		player_position = player.global_position.x
	else: player_position = global_position.x
	
	
	var wall = global_position.x
	var distance = player_position - wall
	
	
	# teleport if too far for wall
	if distance > max_distance:
		position.x = player_position - max_distance

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body._damage_taken(damage)
	
