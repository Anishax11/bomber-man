extends Area2D
#add point system
var direction:Vector2
var speed=60
@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_2d_down: RayCast2D = $RayCast2DDown

var position_x
var position_y

var collision_point_right
var collision_point_left
var found
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	direction=Vector2.RIGHT
	
	
func _process(delta: float) -> void:
	
	for i in range(0,8):
		if position.y==104-i*32:
			for j in range(0,17):#if position is assigned at occupied location,enemy moves left right
				if position.x==-248+32*j:
					position.x-=8
					position.y+=16
					direction=Vector2.RIGHT
					found=true
					print("right left")
					break
			
			if found!=true :
				print(found)
				print("Y:",position.y)#if enemy spawns between two tiles,it moves up-down
				direction=Vector2.DOWN
				print("UP down")
				break
				
	position+=direction*speed*delta
	if ray_cast_2d_right.is_colliding():
		#print("right colliding")
		collision_point_right=ray_cast_2d_right.get_collision_point()
		direction=Vector2.LEFT
		$AnimatedSprite2D.flip_h
		
	elif ray_cast_2d_left.is_colliding():
		#print("left colliding")
		collision_point_left=ray_cast_2d_left.get_collision_point()
		$AnimatedSprite2D.flip_h
		direction=Vector2.RIGHT	
		
	elif ray_cast_up.is_colliding():
		#$AnimatedSprite2D.flip_h
		direction=Vector2.DOWN
		#print("up colliding",direction)
		
	elif ray_cast_2d_down.is_colliding():
		#$AnimatedSprite2D.flip_h
		direction=Vector2.UP
		#print("down colliding")
	
	
	


	
	






func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		if Utils.invincible!=true:
			var player=get_node("/root/game/Player")
			player.die()

func enemy_death():
	animated_sprite_2d.play("death")
	


func _on_animated_sprite_2d_animation_finished() -> void:

	
	
	

	queue_free()
