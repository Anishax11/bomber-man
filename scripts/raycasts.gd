extends Node2D
class_name Raycasts

@onready var right_horizontal_raycasts: Array [RayCast2D] = [
	$Horizontal/right/bottomhorizontalright,
	$Horizontal/right/tophorizontalright]
	


@onready var left_horizontal_raycasts: Array [RayCast2D] = [
	$Horizontal/left/bottomhorizontalleft,
	$Horizontal/left/tophorizontalleft
	
]


@onready var top_vertical_raycasts: Array [RayCast2D] = [
	$Vertical/top/topverticalright,
	$Vertical/top/topverticalleft
]


@onready var bottom_vertical_raycasts: Array [RayCast2D] = [
	$Vertical/bottom/bottomverticalleft,
	$Vertical/bottom/bottomverticalright
]

func check_collisions() ->Array[Vector2]:
	var collisions : Array[Vector2]=[]
	if $Horizontal/left/tophorizontalleft.is_colliding()||$Horizontal/left/bottomhorizontalleft.is_colliding():
		
	
		collisions.append(Vector2.LEFT)

	if $Horizontal/right/tophorizontalright.is_colliding()||$Horizontal/right/bottomhorizontalright.is_colliding():
		
		collisions.append(Vector2.RIGHT)
	
	if $Vertical/top/topverticalright.is_colliding()||$Vertical/top/topverticalleft.is_colliding():
		collisions.append(Vector2.UP)
	
	if $Vertical/bottom/bottomverticalleft.is_colliding()||$Vertical/bottom/bottomverticalright.is_colliding():
		collisions.append(Vector2.DOWN)
	
	return collisions
	
func is_raycast_colliding(acc: bool, next: RayCast2D):
	return next.is_colliding() || acc
