extends Node
var brick_position
const POWER_UP = preload("res://scenes/power_up.tscn")
var id=0
var active=[]
var deactivated=false
const EXIT = preload("res://scenes/exit.tscn")
var exit_appeared=false
var brickwall_count=83

func set_power_up(brick_position:Vector2) ->bool:
		brickwall_count-=1
		var blank_chance=randi_range(0,1)
		var game = get_node_or_null("/root/game")
		while game==null:
			await get_tree().process_frame
			game = get_node_or_null("/root/game")

	
		
		if blank_chance==0:	
			
			Utils.id=Utils.id+1
		#brick_position=central_exp.brick_position
			var powerup=POWER_UP.instantiate()
			powerup.position=brick_position	
			powerup.name="PowerUp"+str(id)
			print("utils:",powerup.name)
			
			
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

func exit(brick_position:Vector2,):
	if exit_appeared==false:
		print("Brickwalls:",brickwall_count)
		var game = get_node_or_null("/root/game")
		while game==null:
			await get_tree().process_frame
			game = get_node_or_null("/root/game")
		var exit_chance=randi_range(0,brickwall_count)
		if exit_chance==1:
			exit_appeared=true
			print("exit")
			var exit=EXIT.instantiate()
			exit.position=brick_position
			game.add_child(exit)
		if brickwall_count==1:
			exit_appeared=true
			print("exit")
			var exit=EXIT.instantiate()
			exit.position=brick_position
			game.add_child(exit)
	else:
		return
