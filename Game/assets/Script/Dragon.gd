extends KinematicBody2D

export var movement_speed = 75.0
export var hp = 30;
export var knockback_recovery = 3.5
export var experience = 35
var knockback = Vector2.ZERO

onready var dmg = $AnimatedSprite/Damage
onready var sprite = $AnimatedSprite
onready var anim = $AnimatedSprite
onready var player = get_tree().get_nodes_in_group("player")[0]

var xp_scene = preload("res://assets/Utiles/xp.tscn")
var coin_scene = preload("res://assets/Utiles/coin.tscn")

func _ready():
	anim.play("walk")

func _physics_process(_delta):
	if hp <= 0:
		death();
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	if str(player)=="[Deleted Object]":
		return;
	var direction = global_position.direction_to(player.global_position)
	var velocity = direction*movement_speed
	velocity += knockback
	move_and_slide(velocity)
	
	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false

func death():
	queue_free();
	var xp = xp_scene.instance()
	xp.global_position = global_position
	xp.xp = experience;
	get_tree().get_root().add_child(xp)
	var rng = RandomNumberGenerator.new()
	rng.randomize();
	if rng.randi_range(0, 5) == 5:
		var coin = coin_scene.instance()
		coin.global_position = global_position
		coin.global_position.y += 15;
		get_tree().get_root().add_child(coin)
