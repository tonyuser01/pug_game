class_name pasare
extends Area2D

@export var damage: int = 5
@export var movement_speed: float = 200.0
@export var lifetime: float = 6


# Bird visuals
@onready var animated_sprite = $AnimatedSprite2D

const golden_bird_rate =30;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if randi_range(0,100) <=golden_bird_rate :
		modulate = Color(0.446,0.934,0.361) 
		damage= -50
	# Self-destruct timer
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Move based on direction
		position.x -= movement_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body._damage_taken(damage)
		# Optional: destroy colission shape so bro doesnt get 1 tap
		$CollisionShape2D.queue_free()
