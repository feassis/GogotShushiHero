extends ColorRect
class_name Fps

@export_category("Objects")
@export var fpsText: Label = null

func _physics_process(delta) -> void:
	fpsText.text = str(Engine.get_frames_per_second()) + " - FPS"
