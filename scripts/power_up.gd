extends Area2D

class_name PowerUp
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#
#var power_ups=["Bomb","Blank","Speed","Blank","Fire","Blank","Wall","Blank"]
#var index
#func _ready() -> void:
	#index=randi_range(0,7)
	#animated_sprite_2d.play(power_ups[index])
@onready var animations=["bomb","speed","wall","fire"]

var index

func _ready() -> void:
	print("path:",self.get_path())
	index=0#randi_range(0,3)
	
	print("POWER UP CALLED!",index)
	animated_sprite_2d.play(animations[index])

	


func _on_area_entered(area: Area2D) -> void:
	print("ENteredddd")
	var central_exp=get_node("/root/CentralExplosion")
	if area is Player:
		print("Power Up acquired!!")
		
		if(index==0):
			print("Bomb Up!")
			central_exp.apply_bomb_up()
			
		elif(index==1):
			print("Speed Up!")
		elif(index==2):
			print("Wall Pass!")
		elif(index==3):
			print("Fire Up!")
		$CollisionShape2D.queue_free()
		$AnimatedSprite2D.queue_free()
	
