extends Node
var brick_position
const POWER_UP = preload("res://scenes/power_up.tscn")
var id=0
var active
var incremented=false	
var  central_exp
var central_id=0
var deactivated=false

func set_power_up(brick_position:Vector2) ->bool:
		var blank_chance=randi_range(0,1)
		var game = get_node_or_null("/root/game")
		while game==null:
			await get_tree().process_frame
			game = get_node_or_null("/root/game")

		#while central_exp == null:
			#await get_tree().process_frame
			#central_exp=get_node_or_null("/root/CentralExplosion")	
		
		if blank_chance==0:	
			
			Utils.id=Utils.id+1
			incremented=true
		#brick_position=central_exp.brick_position
			var powerup=POWER_UP.instantiate()
			powerup.position=brick_position	
			powerup.name="PowerUp"+str(id)
			print("utils:",powerup.name)
			
			#var direction_exp=get_node("/root/DirectionExplosion")
			#while direction_exp == null:
				#await get_tree().process_frame
				#direction_exp=get_node_or_null("/root/CentralExplosion")	
			#var sprite=direction_exp.get_node("AnimatedSprite2D")
			
			game.add_child(powerup)
			return true
		else:
			return false
		
func get_active(current:String):
	
	active=current
	incremented=false
	print("active:",active)

func central_exp_id_tracker(central:String):
	central_exp=central
	print("CENtralexp:",central_exp)
	central_exp=central
	
func get_last_central():
	
	central_id+=1
	print("HEEEEE")

func get_deactivation_update():
	deactivated=true
	print("deactivated")
