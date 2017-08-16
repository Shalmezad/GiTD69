package;

class EnemyGhost extends Enemy
{
	private var initial_y:Float;
	private var timeAlive:Float = 0;
	public function new()
	{
		super(64,128);
		initial_y = 128;
		loadGraphic("assets/images/ghost-sheet.png", true, 32, 32);
		this.centerOrigin();
		animation.add("hover", [0,1,2,3], 6, true);
		animation.play("hover");
		velocity.x = 20;
	}

	override public function update(elapsed:Float):Void
	{
		timeAlive += elapsed;
		this.y = initial_y +  Math.cos(timeAlive) * 20;
		super.update(elapsed);
	}

}
