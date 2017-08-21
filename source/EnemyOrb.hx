package;

import flixel.FlxG;
import flixel.math.FlxRandom;
class EnemyOrb extends Enemy
{
	private var initial_y:Float;
	private var timeAlive:Float = 0;
	public function new()
	{
		super(64,128);
		initial_y = 128;
		loadGraphic("assets/images/orb-sheet.png", true, 32, 32);
		this.centerOrigin();
		animation.add("bubble", [0,1,2,3], 6, true);
		animation.play("bubble");
	}

	override public function update(elapsed:Float):Void
	{
		timeAlive += elapsed;
		this.y = initial_y +  Math.cos(timeAlive) * 20;
		// Kill if we're at the opposite side
		if(this.velocity.x < 0 && this.x < -40)
		{
			kill();
		}
		if(this.velocity.x > 0 && this.x > FlxG.worldBounds.width)
		{
			kill();
		}
		super.update(elapsed);
	}

	public function resetSpawn():Void
	{
		//Pick either left or right:
		var playState:PlayState = cast FlxG.state;
		var directionToFace:Int = playState.random.int(0, 2);
		var tempX:Float = 0;
		var tempY:Float = 0;
		if(directionToFace == 0)
		{
			tempX = 0 - width;
		}
		else
		{
			tempX = FlxG.worldBounds.width;
		}
		//Give us a y:
		tempY = playState.random.float(0,FlxG.worldBounds.height);
		reset(tempX,tempY);
		if(tempX < 0)
			velocity.x = 40;
		else
			velocity.x = -40;

		this.health = 2;

		initial_y = tempY;
	}
}
