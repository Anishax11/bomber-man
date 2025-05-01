extends Area2D

var direction:Vector2
var speed=60
@onready var ray_cast_2d_right: RayCast2D = $RayCast2D2
@onready var ray_cast_2d_left: RayCast2D = $RayCast2D4

func _ready() -> void:
	direction=Vector2.RIGHT
	
func _process(delta: float) -> void:
	
	
	position+=direction*speed*delta
	if ray_cast_2d_right.is_colliding():
		direction=Vector2.LEFT
		$AnimatedSprite2D.flip_h
	elif ray_cast_2d_left.is_colliding():
		print("Colliding")
		$AnimatedSprite2D.flip_h
		direction=Vector2.RIGHT	
