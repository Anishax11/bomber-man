extends Area2D

class_name PowerUp
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@onready var animations=["fire","speed","wall","bomb"]
var timeout=false
var entered=false
var index
var check=false
var size_of_label

func _ready() -> void:
	#print("path:",self.get_path())
	index=randi_range(0,3)

	print("POWER UP CALLED!",index)
	animated_sprite_2d.play(animations[index])
	
	


func _on_area_entered(area: Area2D) -> void:
	
	var bomb_placement=get_node("/root/game/Player/BombPlacementManager")
	if area is Player:
		
		print(self.name)
		
		entered=true
		print("timer started")
		var Label=get_node("/root/game/Label")
	
		$Timer.start()
		if(index==0):
			Utils.get_active(self)
			print("Fire Up!")
		
			Label.position=Vector2(-128,-208)
			Label.text="Power Up Activated!\nExplosion range doubled!"
			
		elif(index==1):
			print("Speed Up!")
		elif(index==2):
			print("Wall Pass!")
			Utils.wall_pass()
			Label.position=Vector2(-176,-208)
			Label.text="Power Up Activated!\nYou can now pass through brick walls!"
		elif(index==3):
			print("Bomb Up!")
			Label.position=Vector2(-248,-208)
			Label.text="Power Up Activated!\nBomb capacity increased. You can now plant 4 bombs!"
			bomb_placement.bomb_limit=4
			check=true
		$CollisionShape2D.queue_free()
		$AnimatedSprite2D.queue_free()
		



func _on_timer_timeout() -> void:
	
	if index==2:
		Utils.wall_pass_deactivated()
	var Label=get_node("/root/game/Label")
	Label.text=""
	print("Timeout")
	var bomb_placement=get_node("/root/game/Player/BombPlacementManager")
	if bomb_placement==null:
		print("bomb manager is NULL")
	bomb_placement.bomb_limit=2
	#if Utils.central_exp!=null:
		#var central_explosion=get_node("/root/"+Utils.central_exp)
		#print("Central:",central_explosion)
		#
		#central_explosion.queue_free()
		#print("deactivated:",Utils.deactivated)
	##if Utils.central_id!=null:
		##var central_explosion=get_node("/root/CentralExplosion"+str(Utils.central_id))
		##print("Central: /root/CentralExplosion"+str(Utils.central_id))
		#if Utils.deactivated==false:
			#print(central_explosion)
			##await central_explosion.deactivate_power_up()
			#central_explosion.queue_free()
			#print("Timeout freed:",central_explosion)
			
	Utils.remove_power_up(self.name)
	timeout=true

	
