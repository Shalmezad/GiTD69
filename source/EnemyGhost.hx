package;

import flixel.math.FlxRandom;
import flixel.FlxObject;
import flixel.FlxObject;
import flixel.FlxG;
class EnemyGhost extends Enemy
{
	private var timeAlive:Float = 0;
	public function new()
	{
		super(64,128);
		loadGraphic("assets/images/ghost-sheet.png", true, 32, 32);
		this.centerOrigin();
		animation.add("hover", [0,1,2,3], 6, true);
		animation.play("hover");
		maxVelocity.set(75,75);
		this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
	}

	override public function update(elapsed:Float):Void
	{
		timeAlive += elapsed;

		var desiredRad:Float = timeAlive;

		var playState:PlayState = cast FlxG.state;
		var desiredX = playState.player.x + Math.cos(desiredRad) * 40;
		var desiredY = playState.player.y + Math.sin(desiredRad) * 40;

		// Adjust our acceleration to get us to desiredX/Y:
		var deltaX = desiredX - this.x;
		var deltaY = desiredY - this.y;

		var deltaAngle = Math.atan2(deltaY, deltaX);

		acceleration.x = Math.cos(deltaAngle) * 60;
		acceleration.y = Math.sin(deltaAngle) * 60;

		if(this.velocity.x < 0)
			this.facing = FlxObject.LEFT;
		else
			this.facing = FlxObject.RIGHT;

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
		this.health = 5;
		reset(tempX,tempY);
	}

}
