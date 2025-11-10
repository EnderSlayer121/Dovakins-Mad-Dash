extends CanvasLayer

func _ready():
	GameState.coin_change.connect(coins)
	$LifeLabel.text = "Lives: " + str(GameState.lives)
	coins(GameState.num_coins)

func coins(new_coins: int) -> void:
	$CoinsLabel.text = "Gold: " + str(new_coins)
