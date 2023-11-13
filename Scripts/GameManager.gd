extends Node

var camera = preload("res://Scenes/camera_2d.tscn")
var catPlayer = preload("res://Scenes/cat_player.tscn")
var deadCat = preload("res://Scenes/dead_cat.tscn")
signal playerDeath
var maxRespawnTime = 2
var respawnTime = 0
var isRespawning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var spawnPlayer = catPlayer.instantiate()
	spawnPlayer.position = Vector2(0,0)
	add_child(spawnPlayer)
	var spawnCamera = camera.instantiate()
	spawnPlayer.add_child(spawnCamera)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isRespawning:
		respawnTime += delta
		if respawnTime >= maxRespawnTime:
			var cat = catPlayer.instantiate()
			cat.position = Vector2(0,0)
			isRespawning = false
			respawnTime = 0
			var newCamera = camera.instantiate()
			cat.add_child(newCamera)
			add_child(cat)

func _on_player_death():
	isRespawning = true
	var currentCat = get_node("CatPlayer")
	var deadCatObject = deadCat.instantiate()
	deadCatObject.position = currentCat.position
	deadCatObject.get_child(0).flip_h = currentCat.get_child(0).flip_h
	add_child(deadCatObject)
	currentCat.queue_free()
	var deathCamera = camera.instantiate()
	deadCatObject.add_child(deathCamera)
