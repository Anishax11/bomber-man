extends Area2D

class_name DirectionExplosion
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func play_animation(animation:String):
	animated_sprite_2d.play(animation)

func _on_area_entered(area: Area2D) -> void:
	
	if area is Player:
		print("player entered")
		(area as Player).die()
		
	


	



		
