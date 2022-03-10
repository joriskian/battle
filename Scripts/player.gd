extends KinematicBody

onready var center = Vector3.ZERO


export var radius:float = 460.0  # rayon de la planete (seuil d'altitude )
export var min_speed:float = 40.0 # vitesse minimum
export var max_speed:float = 250.0 # vitesse maximum
export var steer_limit = 1.2 # limite de rotation
export var rot_weight:float = 0.1 # poids de remise a 0
#tweens
var roll
var boost

var speed:float # vitesse de l'avion
var steer_target:float = 0 as float # direction gauche/droite

var rollBack:bool = false # remet l'avion en assiette ( a l'horizontal ) 
var is_boost:bool = false # acceleration fulgurante

# Called when the node enters the scene tree for the first time.
func _ready():

	# mets le kinematic a la bonne hauteur
	self.translation.y = radius
	#initialise la vitesse
	speed = min_speed

func _process(delta):
	# gestion des touches
	get_input(delta)
	if rollBack:
		steer_target = steer_target + (0 - steer_target) * rot_weight

	# velocity v = vecteur de direction tangentiel
	self.translate(-Vector3.FORWARD * delta * speed)
	# poids du vecteur v (longueur du vecteur )
	var v = delta * speed
	# realigne l'axe y en direction du centre
	self.global_transform = align_with_y(self.global_transform,(self.translation - center).normalized())
	#calcule la distance restante pour toucher le rayon : acceleration centripete
	var ac = sqrt(pow(v,2) + pow(radius,2)) - radius
	# ajout de l'acc centripete
	self.translate(Vector3.DOWN * ac)
	
	print(self.translation.distance_to(center))
	
func get_input(delta):
	# gestion des touches gauche et droite
	if Input.is_action_pressed("ui_left"):
		rollBack = false
		# tourne progressivement
		steer_target += steer_limit * delta
		steer_target = clamp(steer_target, -90 ,90)
	if Input.is_action_just_released("ui_left"):
		rollBack = true
		
	if Input.is_action_pressed("ui_right"):
		rollBack = false
		#  tourne progressivement
		steer_target +=  - steer_limit * delta
		steer_target = clamp(steer_target, -90 , 90)
	if Input.is_action_just_released("ui_right"):
		rollBack = true
	# tourne le player sur son axe y
	self.rotate_y( steer_target)
		
	

	


func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = - xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

