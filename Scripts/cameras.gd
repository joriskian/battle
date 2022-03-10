extends Spatial



# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBodyPlanete/PlanetCol120.disabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_input()


func get_input():
	if Input.is_action_just_pressed("ui_1"):
		$GlobalCamera.current = true
		$player/positionCamera/Camera.current = false
		$InterpolatedCamera.current = false
	if Input.is_action_just_pressed("ui_2"):
		$player/positionCamera/Camera.current = true
		$GlobalCamera.current = false
		$InterpolatedCamera.current = false
	if Input.is_action_just_pressed("ui_3"):
		$InterpolatedCamera.current = true
		$GlobalCamera.current = false
		$player/positionCamera/Camera.current = false
	if Input.is_action_just_pressed("ui_cancel"):
		if $StaticBodyPlanete/PlanetCol100.disabled == true:
			$StaticBodyPlanete/PlanetCol100.disabled = false
			$StaticBodyPlanete/PlanetCol120.disabled = true
		else:
			$StaticBodyPlanete/PlanetCol100.disabled = true
			$StaticBodyPlanete/PlanetCol120.disabled = false
