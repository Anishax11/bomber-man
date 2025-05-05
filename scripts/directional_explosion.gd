extends Area2D

class_name DirectionExplosion
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func play_animation(animation:String):
	animated_sprite_2d.play(animation)

func _on_area_entered(area: Area2D) -> void:
	
	if area is Player:
		print("player entered")
		(area as Player).die()
	var enemy=get_node("/root/game/Enemy")	
	var sprite1=get_node("/root/game/Enemy/AnimatedSprite2D")
	var enemy2=get_node("/root/game/Enemy2")
	var sprite2=get_node("/root/game/Enemy2/AnimatedSprite2D")
	if area == enemy:
		#await sprite1.play("death")
		enemy.enemy_death()
	if area == enemy2:
		#await sprite2.play("death")
		enemy2.enemy_death()

	



		
