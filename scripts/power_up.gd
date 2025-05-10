extends Area2D

class_name PowerUp
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@onready var animations=["fire","invincible","bomb"]
var timeout=false
var entered=false
var index
var check=false
var size_of_label

func _ready() -> void:
	#print("path:",self.get_path())
	index=randi_range(0,2)

	print("POWER UP CALLED!",index)
	animated_sprite_2d.play(animations[index])
	
	


func _on_area_entered(area: Area2D) -> void:
	var game = get_node_or_null("/root/game")
	var bomb_placement=get_node("/root/game/Player/BombPlacementManager")
	if area is Player:
		print(self.name)
		entered=true
		print("timer started")
		
		
	
		$Timer.start()
		if(index==0):
			Utils.get_active(self)
			print("Fire Up!")
			Utils.create_labels(Vector2(-128,-208),"Power Up Activated!\nExplosion range doubled!")
			
			
		elif(index==1):
			print("Invincible")
			Utils.create_labels(Vector2(-248,-208),"Power Up Activated!\nPlayer is immortal for the next 15 seconds!")
			
			Utils.invincible_power_up()
			
		elif(index==2):
			print("Bomb Up!")
			Utils.create_labels(Vector2(-248,-208),"Power Up Activated!\nBomb capacity increased. You can now plant 4 bombs!")
			
			bomb_placement.bomb_limit=4
			check=true
			
		$CollisionShape2D.queue_free()
		$AnimatedSprite2D.queue_free()
		



func _on_timer_timeout() -> void:
	
	
	print("Timeout")	
	if Utils.label!=null:
		
		Utils.label.queue_free()
	
	var bomb_placement=get_node("/root/game/Player/BombPlacementManager")
	if bomb_placement==null:
		print("bomb manager is NULL")
			
	
	for j in range(Utils.active.size()):
		
		if Utils.active[j]!=null and Utils.active[j].index==2:
			bomb_placement.bomb_limit=4
		elif j==Utils.active.size()-1:
			bomb_placement.bomb_limit=2
			
	if index==1:
		Utils.invincible=false
	
	Utils.remove_power_up(self.name)
	timeout=true
