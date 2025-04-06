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



func _ready() -> void:
	
	var index=randi_range(0,3)
	
	print("POWER UP CALLED!",index)
	animated_sprite_2d.play(animations[index])
	

	


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		print("Power Up acquired!!")
		queue_free()
