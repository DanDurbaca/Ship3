extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var fireIncrements = 0.1 # the shader increments 

@export var angularVelocity = 0 # how fast is the ship turning
@export var maxAngularVelocity = 0.05 # how fast the ship MAXIMALY turning


var screen_size # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	
	var curFire = $FireRightThurster.material.get("shader_parameter/fire_intensity")
	if Input.is_action_pressed("turn_right"):
		velocity.y -= 0.1
		if (curFire<4):
			curFire+=fireIncrements
		if (angularVelocity<maxAngularVelocity):
			angularVelocity += 0.001
	else:
		if (angularVelocity>0):
			angularVelocity -= 0.001
		if (curFire>0):
			curFire-=fireIncrements
	$FireRightThurster.material.set("shader_parameter/fire_intensity",curFire)
	
	
	curFire = $FireLeftThurster.material.get("shader_parameter/fire_intensity")
	if Input.is_action_pressed("turn_left"):
		velocity.y -= 0.1
		if (curFire<4):
			curFire+=fireIncrements
		if (angularVelocity>-maxAngularVelocity):
			angularVelocity -= 0.001
	else:
		if (angularVelocity<0):
			angularVelocity += 0.001
		if (curFire>0):
			curFire-=fireIncrements
	$FireLeftThurster.material.set("shader_parameter/fire_intensity",curFire)

		
	curFire = $FireMainThrusters.material.get("shader_parameter/fire_intensity")
	if Input.is_action_pressed("acc"):
		velocity.y -= 1	
		if (curFire<4):
			curFire+=fireIncrements		
	else:
		if (curFire>0):
			curFire-=fireIncrements
	$FireMainThrusters.material.set("shader_parameter/fire_intensity",curFire)
		
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	self.rotate(angularVelocity)
	velocity = velocity.rotated(self.rotation)
	
	position += velocity * delta
	
	position = position.clamp(Vector2.ZERO, screen_size)

	
	
	
