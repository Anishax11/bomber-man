extends Area2D

class_name DirectionExplosion
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func play_animation(animation:String):
	animated_sprite_2d.play(animation)

func _on_area_entered(area: Area2D) -> void:
	
	if area is Player:
		print("invincible",Utils.invincible)
		if Utils.invincible!=true:
			(area as Player).die()
			
	var enemy=get_node("/root/game/Enemy")	
	var enemy2=get_node("/root/game/Enemy2")
	
	if area == enemy:
		print("enemy")
		enemy.enemy_death()
	if area == enemy2:
		print("enemy")
		enemy2.enemy_death()

	



		
