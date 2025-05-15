extends Area2D
class_name CentralExplosion
var size=1

@onready var raycasts: Array[RayCast2D]=[
	$Raycasts/RayCast2DUp,
	$Raycasts/RayCast2DRight,
	$Raycasts/RayCast2DDown,
	$Raycasts/RayCast2DLeft
]
var animation_names=["up","right","down","left"]
var animation_directions:Array[Vector2]=[
	Vector2(0,-16),
	Vector2(16,0),
	Vector2(0,16),
	Vector2(-16,0)
]
var DIRECTIONAL_EXPLOSION = preload("res://scenes/directional_explosion.tscn")
var brick_position:Vector2
var x
var y
var scale_x
var scale_y
var scale_x_after_power_up=4.0
var scale_y_after_power_up=4.0
var probability

func _ready():
		
		var bomb_up_applied
		for j in range(Utils.active.size()):
			
		
			var power_up=get_node("/root/game/"+(Utils.active[j]).name)
			print(power_up)
			
			
		
			
			if power_up!=null and power_up.timeout!=true and power_up.entered==true:
				
				print("power_up here")
				
				bomb_up_applied=apply_fire_up()
				
					
			if power_up==null:
				print("power_up not here or isnt pickedup yet")
				
			
		for i in range(4):
			
			
			var explosion_instance = DIRECTIONAL_EXPLOSION.instantiate()
			raycasts[i].global_position=global_position
			raycasts[i].force_raycast_update()
			
			

			if raycasts[i].is_colliding():
			
				var collision_point=raycasts[i].get_collision_point()
				var distance=raycasts[i].global_position.distance_to(collision_point)
				
				var tiles=round(distance/16)-1
			
				var collider=raycasts[i].get_collider()
				print(collider,raycasts[i])
				print("Type: ", typeof(collider))
				
				
				if(collider is BrickWall):
					brick_position=collider.get_position()
					var sprite = collider.get_node("AnimatedSprite2D")
					sprite.play("destroyed")
					probability=randi_range(0,1)
					if probability==0:
						Utils.set_power_up(brick_position)
					elif probability==1:
						Utils.exit(brick_position)
						

					 
					
				if(tiles!=0):
					
					if(raycasts[i]==raycasts[0]):
						x=raycasts[i].position.x
						y=raycasts[i].position.y-(distance+8)/2
						scale_x=1.0
						scale_y=tiles
					elif(raycasts[i]==raycasts[1]):
						x=raycasts[i].position.x+(distance+8)/2
						y=raycasts[i].position.y
						scale_x=tiles
						scale_y=1.0
					elif(raycasts[i]==raycasts[2]):
						x=raycasts[i].position.x
						y=raycasts[i].position.y+(distance+8)/2
						scale_x=1.0
						scale_y=tiles
					elif(raycasts[i]==raycasts[3]):
						x=raycasts[i].position.x-(distance+8)/2
						y=raycasts[i].position.y
						scale_x=tiles
						scale_y=1.0
					
					
					explosion_instance.position=Vector2(x,y)
					print("explosion pos:",explosion_instance.position)
					
					explosion_instance.scale=Vector2(scale_x,scale_y)
					print(" scale:",explosion_instance.scale)
					
					get_parent().add_child(explosion_instance) 
					print(explosion_instance.animated_sprite_2d)  # Should not be null
					#explosion_instance.play_animation(animation_names[i])					
					explosion_instance.animated_sprite_2d.play(animation_names[i])
					explosion_instance.animated_sprite_2d.animation_finished.connect(func():
						
						explosion_instance.queue_free()
						
						queue_free()
					
						
							
						
						
					)
					
					print(animation_names[i])
					
					  
					 
					
			else:
				if(bomb_up_applied==true):
					if(raycasts[i]==raycasts[0]):
						x=raycasts[i].position.x
						y=raycasts[i].position.y-72
						scale_x=1.0
						scale_y=scale_y_after_power_up
					
					elif(raycasts[i]==raycasts[1]):
						x=raycasts[i].position.x+72
						y=raycasts[i].position.y
						scale_x=scale_x_after_power_up
						scale_y=1.0
						
					elif(raycasts[i]==raycasts[2]):
						x=raycasts[i].position.x
						y=raycasts[i].position.y+72
						scale_x=1.0
						scale_y=scale_x_after_power_up
					elif(raycasts[i]==raycasts[3]):
						x=raycasts[i].position.x-72
						y=raycasts[i].position.y
						scale_x=scale_x_after_power_up
						scale_y=1.0
				else:
							
					if(raycasts[i]==raycasts[0]):
						x=raycasts[i].position.x
						y=raycasts[i].position.y-40
						scale_x=1.0
						scale_y=scale_y_after_power_up
						
					elif(raycasts[i]==raycasts[1]):
						x=raycasts[i].position.x+40
						y=raycasts[i].position.y
						scale_x=scale_x_after_power_up
						scale_y=1.0
					
					elif(raycasts[i]==raycasts[2]):
						x=raycasts[i].position.x
						y=raycasts[i].position.y+40
						scale_x=1.0
						scale_y=scale_x_after_power_up
					elif(raycasts[i]==raycasts[3]):
						x=raycasts[i].position.x-40
						y=raycasts[i].position.y
						scale_x=scale_x_after_power_up
						scale_y=1.0
					
						
						
				
				explosion_instance.position=Vector2(x,y)
				print("explosion pos:",explosion_instance.position)
				

				explosion_instance.scale=Vector2(scale_x,scale_y)
				print("else scale:",explosion_instance.scale)
				
				get_parent().add_child(explosion_instance) 
				print(explosion_instance.animated_sprite_2d) 					
				explosion_instance.animated_sprite_2d.play(animation_names[i])
				explosion_instance.animated_sprite_2d.animation_finished.connect(func():
					
					
					explosion_instance.queue_free()
					
					queue_free()
				
					
						
					
				)
				
				
				
		
func apply_fire_up() ->bool:
	var bomb_up_applied
	
	#var power_up=get_node("/root/game/"+str(Utils.active))
	
	for j in range(Utils.active.size()):
		print(Utils.active[j])
		if Utils.active[j]!=null and Utils.active[j].index==0:
		
		
			scale_x_after_power_up=8
			scale_y_after_power_up=8
			raycasts[0].target_position=Vector2(0,-128)
			raycasts[1].target_position=Vector2(128,0)
			raycasts[2].target_position=Vector2(0,128)
			raycasts[3].target_position=Vector2(-128,0)
			print("fire Up Applied")
			bomb_up_applied=true
			print("fire up func called")
			break
		else:
			bomb_up_applied=false
		
			
	return bomb_up_applied
			

		
			
