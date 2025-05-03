extends Area2D

var direction:Vector2
var speed=60
@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_2d_down: RayCast2D = $RayCast2DDown

var position_x
var position_y
var entered=true
var collision_point_right
var collision_point_left
func _ready() -> void:
	direction=Vector2.RIGHT
	
	
	set_location()
	#position=Vector2(-216,-104)
func _process(delta: float) -> void:
	
	for i in range(0,5):
		if position.y==88-i*48:
			for j in range(0,11):
				if position.x==-232+48*j:
					direction=Vector2.RIGHT
					break
				else:
					print("Y:",position.y)
					direction=Vector2.DOWN
					break
				
	position+=direction*speed*delta
	if ray_cast_2d_right.is_colliding():
		print("right colliding")
		collision_point_right=ray_cast_2d_right.get_collision_point()
		direction=Vector2.LEFT
		$AnimatedSprite2D.flip_h
		
	elif ray_cast_2d_left.is_colliding():
		print("left colliding")
		collision_point_left=ray_cast_2d_left.get_collision_point()
		$AnimatedSprite2D.flip_h
		direction=Vector2.RIGHT	
		
	elif ray_cast_up.is_colliding():
		#$AnimatedSprite2D.flip_h
		direction=Vector2.DOWN
		print("up colliding",direction)
		
	elif ray_cast_2d_down.is_colliding():
		#$AnimatedSprite2D.flip_h
		direction=Vector2.UP
		print("down colliding")
	
	
	

func _on_area_entered(area: Area2D) -> void:
	print("entered")
	entered=true
	


func _on_area_exited(area: Area2D) -> void:
	entered=false

func set_location():
	print(direction)
	position_x=randi_range(-264,264)
	if(position_x>=0):
		position_y=randi_range(-136,120)
	else:
		position_y=randi_range(8,120)
	position_x=(round(position_x/8)*8)
	position_y=(round(position_y/8)*8)
	if(position_x==(round(position_x/16)*16)):
		position_x-=8
	if(position_y==(round(position_y/16)*16)):
		position_y-=8
	
	position=Vector2(position_x,position_y)
	print(position)
