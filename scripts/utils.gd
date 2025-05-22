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
	
var string_fire=""
var string_invincible=""
var string_bomb=""	


	
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
	var label1=get_node("/root/game/Label1")
	
	for i in range(0,active.size()):
		if active[i].index==0:
			string_fire="Explosion Range Up"
			if string_bomb!="" or string_invincible!="":
				string_fire+=","
		elif active[i].index==1:
			string_invincible="Invincibility"
			if string_fire=="Explosion Range Up":
				string_invincible=",Invincibility"
			if string_bomb!="":
				string_invincible+=","
		elif active[i].index==2:
			string_bomb="Bomb Limit Up"
			if string_invincible=="Invincibility" or string_fire=="Explosion Range Up":
				string_bomb=",Bomb Limit Up"
		
	if string_fire!="" or string_invincible!="" or string_bomb!="":
		
		label1.text="Active Powerups:\n"
		label1.text+=string_fire+string_invincible+string_bomb
		
		
	

func remove_power_up(current):
	
	var label1=get_node("/root/game/Label1")
	active.erase(current)
	string_fire=""
	string_invincible=""
	string_bomb=""
	
	for i in range(0,active.size()):
		if active[i].index==0:
			string_fire="Explosion Range Up"
			if active[i].index==2:
				string_bomb="Range Up"
		elif active[i].index==1:
			string_invincible="Invincibility"
			if string_fire=="Explosion Range Up":
				string_invincible=",Invincibility"
		elif active[i].index==2:
			string_bomb="Bomb Limit Up"
			if string_invincible=="Invincibility" or string_fire=="Explosion Range Up":
				string_bomb=",Bomb Limit Up"
		
	if string_fire!="" or string_invincible!="" or string_bomb!="":
		
		label1.text="Active Powerups:\n"
		label1.text+=string_fire+string_invincible+string_bomb	
	else:
		label1.text=""	
	current.queue_free()
	print("active after erase:",active)

func exit(brick_position:Vector2,):
	if exit_appeared==false:#checks if exit has appeared in game before
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
		print("Game restarted")
		position_x=null
		position_y=null
		initial_position_x.clear()
		initial_position_y.clear()
		active.clear()
		exit_appeared=false
		id=0
		brickwall_count=83
		string_fire=""
		string_invincible=""
		string_bomb=""
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
	
	if enemy_number==4:
		
		position_x=168
		position_y=-72
	
	enemy.position=Vector2(position_x,position_y)
	print("enemy at:",enemy.position)
	print(initial_position_x)	
	print(initial_position_y)
	var game = get_node("/root/game")
	game.add_child(enemy)
	
