extends Node
@onready  var new_sprite = $CharacterBody2D/Sprite2D
func _ready():
	new_sprite.x =0;
func _process(delta: float) -> void: #e pt fiecare frame
	if new_sprite.x<1060:
		new_sprite.x += 1000 * delta 
		new_sprite += 360*0.25* delta
	if new_sprite > Vector2.ZERO:
		new_sprite += Vector2(-1,-1)*delta

	
		
	
