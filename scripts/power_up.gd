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

func _ready() -> void:
	#print("path:",self.get_path())
	index=3#randi_range(0,3)
	#print("Timeout power-up:",timeout)
	print("POWER UP CALLED!",index)
	animated_sprite_2d.play(animations[index])
	
	


func _on_area_entered(area: Area2D) -> void:
	
	var bomb_placement=get_node("/root/game/Player/BombPlacementManager")
	if area is Player:
		print(self.name)
		Utils.get_active(self.name)
		entered=true
		print("timer started")
	
		$Timer.start()
		if(index==0):
			print("Fire Up!")
			
			
		elif(index==1):
			print("Speed Up!")
		elif(index==2):
			print("Wall Pass!")
		elif(index==3):
			print("Bomb Up!")
			bomb_placement.bomb_limit=4
			check=true
		$CollisionShape2D.queue_free()
		$AnimatedSprite2D.queue_free()
		
	


func _on_timer_timeout() -> void:
	
	print("Timeout")
	var bomb_placement=get_node("/root/game/Player/BombPlacementManager")
	bomb_placement.bomb_limit=2
	var central_exp=get_node("/root/"+Utils.central_exp)
	print("Central:",central_exp)
	await central_exp.deactivate_power_up()
	central_exp.queue_free()
	timeout=true

	
