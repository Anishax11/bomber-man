extends Node

class_name BombPlacementManager
var BOMB_SCENE = preload("res://scenes/bomb.tscn")
var bombs_placed=0
var player
var TILE_SIZE=16
var bomb_limit=2



func _ready():
	
	player=get_parent()
	 

func place_bomb():
	
	var bomb_node=get_node("/root/bomb")
	var central_explosion=get_node("/root/"+Utils.active_central)

	
	if central_explosion!=null:
		print("HEEEEE")
		if central_explosion.limit_increased==true:
			print("Heloo")
			bomb_limit=4
	else:
		bomb_limit=2
		
	if bombs_placed<bomb_limit:
		var bomb=BOMB_SCENE.instantiate()
		var player_position=player.position
		#FIXED:
		#make multiple of 8
		var bomb_position=Vector2(round(player_position.x/8)*8,round(player_position.y/8)*8)
		#make sure it is a multiple of 8 but not of 16
		bomb.position=bomb_position
		if (bomb.position.x==round(bomb.position.x/16)*16):
			bomb.position.x+=8
		if (bomb.position.y==round(bomb.position.y/16)*16):
			bomb.position.y+=8
		
		get_tree().root.add_child(bomb)
		bomb.tree_exiting.connect(on_bomb_exploded)
		bombs_placed+=1
		print("BOMB")	
	else:
		return
		
func on_bomb_exploded():
	
	
	print("func on_bomb_exploded() called")
	bombs_placed-=1
	print("bombs_placed:",bombs_placed)
