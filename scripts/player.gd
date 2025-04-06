extends Area2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var bomb_placement_manager: BombPlacementManager = $BombPlacementManager

var movement: Vector2 = Vector2.ZERO
@export var movement_speed : float = 75 
@onready var raycasts: Node2D = $Raycasts
var is_dead=false
func _process(delta: float) ->void:
	
	var collisions = raycasts.check_collisions()
	
	if collisions.has(movement):
		return
	
	position+=movement * delta * movement_speed 
	
	
func _input(event : InputEvent) ->void:
	if(is_dead==true): 
		return
	if Input.is_action_pressed("right"):
		movement=Vector2.RIGHT
		animated_sprite_2d.play("walk right")
		if(Input.is_action_just_pressed("place bomb")):
			bomb_placement_manager.place_bomb()
		
	elif(Input.is_action_pressed("left")):
		movement=Vector2.LEFT
		animated_sprite_2d.play("walk left")
		if(Input.is_action_just_pressed("place bomb")):
			bomb_placement_manager.place_bomb()
	elif(Input.is_action_pressed("up")):
		movement=Vector2.UP
		animated_sprite_2d.play("walk up")
		if(Input.is_action_just_pressed("place bomb")):
			bomb_placement_manager.place_bomb()
		
	elif(Input.is_action_pressed("down")):
		movement=Vector2.DOWN
		animated_sprite_2d.play("walk down")
		if(Input.is_action_just_pressed("place bomb")):
			bomb_placement_manager.place_bomb()
		
	elif(Input.is_action_just_pressed("place bomb")):		
		bomb_placement_manager.place_bomb()
	else:
		movement=Vector2.ZERO
		animated_sprite_2d.stop()

func die():
	print("you have died")
	is_dead=true
	animated_sprite_2d.play("death")

	
	
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation=="death":
		queue_free()
		
