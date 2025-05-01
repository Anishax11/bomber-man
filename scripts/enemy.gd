extends Area2D

var direction:Vector2
var speed=60
@onready var ray_cast_2d_right: RayCast2D = $RayCast2D2
@onready var ray_cast_2d_left: RayCast2D = $RayCast2D4
var position_x
var position_y
var entered=true
func _ready() -> void:
	direction=Vector2.RIGHT
	#position=Vector2(-200,-136)
	#if (entered==true):
		#position_x=randi_range(-64,288)
		#position_y=randi_range(-64,128)
		#print(position_x,position_y)
		#position=Vector2(position_x,position_y)
	set_location()
func _process(delta: float) -> void:
	
	
	position+=direction*speed*delta
	if ray_cast_2d_right.is_colliding():
		direction=Vector2.LEFT
		$AnimatedSprite2D.flip_h
	elif ray_cast_2d_left.is_colliding():
		$AnimatedSprite2D.flip_h
		direction=Vector2.RIGHT	



func _on_area_entered(area: Area2D) -> void:
	print("entered")
	entered=true
	


func _on_area_exited(area: Area2D) -> void:
	entered=false

func set_location():
	position_x=randi_range(-64,288)
	position_y=randi_range(-64,128)
	print(position_x,position_y)
	position=Vector2(position_x,position_y)
