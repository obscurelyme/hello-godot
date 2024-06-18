extends RigidBody2D
class_name Mob

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _process(_delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()