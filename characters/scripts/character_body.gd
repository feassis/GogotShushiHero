extends Node3D
class_name Body

@export_category("Setup")
@export var rotationVelocity: float = 0.15

@export_category("Objects")
@export var character: CharacterBody3D = null
@export var animation: AnimationPlayer = null
@export var cookingPan:Node3D = null
@export var cookingTimer: Timer = null
@export var knife:Node3D = null
@export var choppingTimer: Timer = null

var isCooking : bool = false
var isChopping : bool = false
var isEnabled: bool = false

func apply_rotation(velocity: Vector3) -> void:
	var angularVelocity:float = atan2( velocity.x, velocity.z)
	rotation.y = lerp_angle(
		rotation.y,  angularVelocity, rotationVelocity
	)


func animate(velocity: Vector3) -> void:
	if OnAction():
		return
	
	if velocity:
		if character.is_running():
			animation.play("Run")
			return
		animation.play("Walk")
		return
	animation.play("Idle")
			
func OnAction() -> bool:
	if isCooking and not isEnabled:
		animation.play("Pan_Start")
		cookingPan.show()
		isEnabled = true
		return true
		
	if isCooking:
		return true
		
	if isChopping and not isEnabled:
		animation.play("Chop_Start")
		knife.show()
		isEnabled = true
		return true
		
	if isChopping:
		return true
	
	return false
	


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Pan_Start":
			cookingTimer.start()
			animation.play("Pan")
		"Pan_End":
			isEnabled = false
			cookingPan.hide()
			character.OnCookFinished()
		"Chop_Start":
			choppingTimer.start()
		"Chop_End":
			isEnabled = false
			knife.hide()
			character.OnChopFinished()
			

func _on_cooking_timer_timeout():
	animation.play("Pan_End")


func _on_chopping_timer_timeout():
	animation.play("Chop_End")
