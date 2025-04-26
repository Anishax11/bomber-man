extends Area2D

class_name PowerUp
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#
#var power_ups=["Bomb","Blank","Speed","Blank","Fire","Blank","Wall","Blank"]
#var index
#func _ready() -> void:
	#index=randi_range(0,7)
	#animated_sprite_2d.play(power_ups[index])
@onready var animations=["fire","speed","wall","bomb"]
var timeout=false
var entered=false
var index
var check=false
var power_up_applied=false
func _ready() -> void:
	#print("path:",self.get_path())
	index=3#randi_range(0,3)
	#print("Timeout power-up:",timeout)
	print("POWER UP CALLED!",index)
	animated_sprite_2d.play(animations[index])
	power_up_applied=true
	


func _on_area_entered(area: Area2D) -> void:
	
	var bomb_placement=get_node("/root/game/Player/BombPlacementManager")
	if area is Player:
		
		print(self.name)
		Utils.get_active(self.name)
		entered=true
		print("timer started")
		var Label=get_node("/root/game/Label")
		$Timer.start()
		if(index==0):
			print("Fire Up!")
		
			Label.position=Vector2(0,-88)
			Label.text="Explosion range doubled!"
			
		elif(index==1):
			print("Speed Up!")
		elif(index==2):
			print("Wall Pass!")
		elif(index==3):
			print("Bomb Up!")
			
			Label.text="Bomb capacity increased! You can now plant 4 bombs!"
			bomb_placement.bomb_limit=4
			check=true
		$CollisionShape2D.queue_free()
		$AnimatedSprite2D.queue_free()
		
	


func _on_timer_timeout() -> void:

	
	print("Timeout")
	var bomb_placement=get_node("/root/game/Player/BombPlacementManager")
	bomb_placement.bomb_limit=2
	if Utils.central_exp!=null:
		var central_explosion=get_node("/root/"+Utils.central_exp)
		print("Central:",central_explosion)
		await central_explosion.deactivate_power_up()
		central_explosion.queue_free()
		print("deactivated2:",Utils.deactivated)
	else:
		var central_explosion=get_node("/root/CentralExplosion"+str(Utils.central_id))
		print("Central: /root/CentralExplosion"+str(Utils.central_id))
		if Utils.deactivated==false:
			await central_explosion.deactivate_power_up()
			central_explosion.queue_free()
	timeout=true

	
