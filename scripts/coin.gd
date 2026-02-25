extends Area2D
@onready var coin: Node2D = $"../.."
var coin_spawn_chance : int = 50 ;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randi_range(0,100) > coin_spawn_chance : 
		coin.queue_free();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		body.coin_gathered +=1 ;
		coin.queue_free()
