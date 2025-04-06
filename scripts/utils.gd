extends Node
var brick_position
var game = get_node_or_null("/root/game")
const POWER_UP = preload("res://scenes/power_up.tscn")


	
func set_power_up(brick_position:Vector2):
		 
		#var central_exp=get_node_or_null("/root/CentralExplosion")
		#while central_exp == null:
			#await get_tree().process_frame
			#central_exp=get_node_or_null("/root/CentralExplosion")	
		var blank_chance=randi_range(0,1)
		if blank_chance==0:	
		#brick_position=central_exp.brick_position
			var powerup=POWER_UP.instantiate()
			powerup.position=brick_position	
			
			#var direction_exp=get_node("/root/DirectionExplosion")
			#while direction_exp == null:
				#await get_tree().process_frame
				#direction_exp=get_node_or_null("/root/CentralExplosion")	
			#var sprite=direction_exp.get_node("AnimatedSprite2D")
			
			get_parent().add_child(powerup)
		

	
