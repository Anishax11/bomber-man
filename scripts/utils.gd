extends Node
var brick_position
const POWER_UP = preload("res://scenes/power_up.tscn")
var id=0
var active=[]
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
		
func get_active(current):
	
	active.append(current)

	print("active:",active)

func remove_power_up(current:String):
	
	active.erase(current)

func wall_pass():
	for i in range(1,19):
		
		
		var brickwall=get_node("/root/game/BrickWalls/BrickWall"+str(i))
		if brickwall!=null and brickwall.get_node("CollisionShape2D")!=null:
			
			brickwall.get_node("CollisionShape2D").queue_free()
	
func wall_pass_deactivated():
	
	
	for i in range(1,19):
		
		print("/root/game/BrickWalls/BrickWall"+str(i))
		var brickwall=get_node("/root/game/BrickWalls/BrickWall"+str(i))
		
		if brickwall!=null:
			var collision=CollisionShape2D.new()
			collision.shape=RectangleShape2D.new()
			collision.shape.size=Vector2(16,16)
			brickwall.add_child(collision)	
