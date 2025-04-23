extends Area2D
class_name BrickWall

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation =="destroyed":
		queue_free()
		
		

	
		
		
