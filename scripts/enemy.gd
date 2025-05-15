extends Area2D

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
var collision_point_up
var collision_point_down
var found
var right_collided=false
var up_collided=false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	direction=Vector2.RIGHT
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
				
	
	
func _process(delta: float) -> void:
	var label=get_node("/root/game/Label2")	
	if label.text=="You Win!!":
		return
	
				
	position+=direction*speed*delta
	if ray_cast_2d_right.is_colliding():
		
		collision_point_right=ray_cast_2d_right.get_collision_point()
		direction=Vector2.LEFT
		$AnimatedSprite2D.flip_h
		
	elif ray_cast_2d_left.is_colliding():
		
		collision_point_left=ray_cast_2d_left.get_collision_point()
		$AnimatedSprite2D.flip_h
		direction=Vector2.RIGHT	
		
	elif ray_cast_up.is_colliding():
		collision_point_up=ray_cast_up.get_collision_point()
		direction=Vector2.DOWN
		#print("up colliding",direction)
		
	elif ray_cast_2d_down.is_colliding():
		collision_point_down=ray_cast_2d_down.get_collision_point()
		direction=Vector2.UP
	
	
	if right_collided==false and collision_point_right!=null and collision_point_left!=null and collision_point_right.distance_to(collision_point_left)==16:
		direction=Vector2.UP
		right_collided=true
		print("enemy right_collided")
		
	if up_collided==false and collision_point_up!=null and collision_point_down!=null and collision_point_up.distance_to(collision_point_down)==16:
		direction=Vector2.RIGHT
		up_collided=true
		print("enemy up_collided")



func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		if Utils.invincible!=true:
			var player=get_node("/root/game/Player")
			player.die()
	
func enemy_death():
	animated_sprite_2d.play("death")
	


func _on_animated_sprite_2d_animation_finished() -> void:


	queue_free()
