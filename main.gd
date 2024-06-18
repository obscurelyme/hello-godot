extends Node

@export var mob_scene: PackedScene
var score: int
var player: Player
var startTimer: Timer
var mobTimer: Timer
var scoreTimer: Timer

func _ready():
	player = $Player
	startTimer = $StartTimer
	mobTimer = $MobTimer
	scoreTimer = $ScoreTimer
	# new_game()
	pass

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	mobTimer.start()
	scoreTimer.start()

func _on_mob_timer_timeout():
	var mob: Mob = mob_scene.instantiate()

	var mob_spawn_location: PathFollow2D = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	var direction = mob_spawn_location.rotation + PI / 2

	mob.position = mob_spawn_location.position

	direction += randf_range( - PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)

func game_over():
	$DeathSound.play()
	$Music.stop()
	$HUD.show_game_over()
	scoreTimer.stop()
	mobTimer.stop()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Music.play()
	$HUD.update_score(score);
	$HUD.show_message("Get Ready")
	player.start($StartPosition.position)
	startTimer.start()
