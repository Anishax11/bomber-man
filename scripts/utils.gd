extends Node
var brick_position
const POWER_UP = preload("res://scenes/power_up.tscn")


	
func set_power_up(brick_position:Vector2):
		 
		var game = get_node_or_null("/root/game")
		while game==null:
			await get_tree().process_frame
			game = get_node_or_null("/root/game")

		#while central_exp == null:
			#await get_tree().process_frame
			#central_exp=get_node_or_null("/root/CentralExplosion")	
		var blank_chance=randi_range(0,1)
		if blank_chance==0:	
		#brick_position=central_exp.brick_position
			var powerup=POWER_UP.instantiate()
			powerup.position=brick_position	
			powerup.name="PowerUp"
			
			
			#var direction_exp=get_node("/root/DirectionExplosion")
			#while direction_exp == null:
				#await get_tree().process_frame
				#direction_exp=get_node_or_null("/root/CentralExplosion")	
			#var sprite=direction_exp.get_node("AnimatedSprite2D")
			
			game.add_child(powerup)
		
