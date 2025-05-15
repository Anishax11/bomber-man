extends Node
var brick_position
const POWER_UP = preload("res://scenes/power_up.tscn")
var id=0
var active=[]
var deactivated=false
const EXIT = preload("res://scenes/exit.tscn")
var exit_appeared=false
var brickwall_count=83
var invincible=false
var label
var position_x
var position_y
var initial_position_x: Array[int]=[]
var initial_position_y: Array[int]=[]
const ENEMY = preload("res://scenes/enemy.tscn")
var restarted=false
var skip_invincible=false
var skip_fire=false	
var skip_bomb=false	
	
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
	var string=""
	active.append(current)
	var label1=get_node("/root/game/Label1")
	for i in range(0,active.size()):
		if skip_invincible!=true and skip_fire!=true and skip_bomb!=true:	
			label1.text+="Active PowerUps:\n"
		if skip_fire!=true and active[i].index==0:
			if skip_bomb==true or skip_invincible==true:
				string=",Fire"
			else:
				string="Fire"
			skip_fire=true
			
		elif skip_invincible!=true and active[i].index==1:
			if skip_bomb==true or skip_fire==true:
				string=",invincible"
			else:
				string="invincible"
			skip_invincible=true
			
		elif skip_bomb!=true and active[i].index==2:
			if skip_invincible==true or skip_fire==true:
				string=",Bomb"
			else:
				string="Bomb"
			skip_bomb=true
		
		label1.text+=string
	

func remove_power_up(current):
	var label1=get_node("/root/game/Label1")
	if current.index==0:
		skip_fire=true
		#label1.text="Active PowerUps:\n"
		#if skip_bomb!=true and skip_invincible!=true:
			#label1.text+="Bomb,Invincible"
	if current.index==1:
		skip_invincible=true
	if current.index==2:
		skip_bomb=true	
	active.erase(current)
	current.queue_free()
	print("active after erase:",active)

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

func invincible_power_up():
	invincible=true
	
func create_labels(label_position:Vector2,label_text:String):
	var game = get_node("/root/game")
	const LABEL = preload("res://scenes/label.tscn")
	if label!=null:
		label.queue_free()
	label=LABEL.instantiate()
	
	label.position=label_position
	label.text=label_text	
	game.add_child(label)



func set_location(enemy_number:int):
	if restarted==true:
		initial_position_x.clear()
		initial_position_y.clear()
		restarted=false
	var enemy=ENEMY.instantiate()
	enemy.name="Enemy"+str(enemy_number)
	print(enemy.name)
	if position_x!=null:
		
		initial_position_x.append(position_x)
		initial_position_y.append(position_y)
		
		
	position_x=randi_range(-264,184)
	if(position_x>=-32):
		position_y=randi_range(-136,120)
	else:
		position_y=randi_range(8,120)
		
	position_x=(round(position_x/8)*8)
	position_y=(round(position_y/8)*8)
	if(position_x==(round(position_x/16)*16)):
		position_x-=8
	if(position_y==(round(position_y/16)*16)):
		position_y-=8
		
	for i in range(0,initial_position_x.size()):
		print("Utils enemy For is Running")
		while (initial_position_x[i]==position_x or initial_position_y[i]==position_y):
			print("Utils enemy while is Running")
			position_x=randi_range(-264,184)
			if(position_x>=-32):
				position_y=randi_range(-136,120)
			else:
				position_y=randi_range(8,120)
			position_x=(round(position_x/8)*8)
			position_y=(round(position_y/8)*8)
			if(position_x==(round(position_x/16)*16)):
				position_x-=8
			if(position_y==(round(position_y/16)*16)):
				position_y-=8
	
	#if enemy_number==4:
		#
		#initial_position_x.append(position_x)
		#initial_position_y.append(position_y)
	
	enemy.position=Vector2(position_x,position_y)
	print("enemy at:",enemy.position)
	print(initial_position_x)	
	print(initial_position_y)
	var game = get_node("/root/game")
	game.add_child(enemy)
	
