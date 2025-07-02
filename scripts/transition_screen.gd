extends CanvasLayer

signal on_transition_finished

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.visible = false

func transition():
	print("start transition")
	color_rect.visible = true
	animation_player.play("fade_to_black")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("start transition" + anim_name)
	
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
