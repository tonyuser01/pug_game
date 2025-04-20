extends Area2D
@export var player_node : player
@export var max_distance : int =1000;
@export var _damage =999;
@export var movent_speed=200;
@onready var player_position = player_node.global_position.x ;
@onready var wall_position= global_position.x ;
@onready var distance = player_position - wall_position ;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x+=movent_speed *delta;
	wall_position=global_position.x;
	if player_node != null:
		player_position=player_node.global_position.x;
	distance = player_position - wall_position ;
	if _is_wall_too_far ()==true :
		wall_position= player_position-max_distance;
		position.x=wall_position;
func _on_body_entered(body: Node2D) -> void:
	if body is player :
		body._damage_taken(_damage);

func _is_wall_too_far () -> bool:
	if (distance >max_distance):
		return true;
	else : return false;
	
