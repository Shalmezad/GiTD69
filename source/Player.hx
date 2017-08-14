package ;
import flixel.FlxObject;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

class Player extends FlxSprite
{

	private var RUN_SPEED = 140;
	private var GRAVITY = 420;
	private var JUMP_SPEED = 250;

	private var charge:Float = 0;

	public function new()
	{
		super(40,0);
		makeGraphic(10,10,0xFFFF00FF);
		acceleration.y = GRAVITY;
		maxVelocity.y = JUMP_SPEED;
	}

	override public function update(elapsed:Float):Void
	{
		velocity.x = 0;
		if(!InputHandler.CHARGE())
		{
			handleMovement();
			releaseCharge();
			handleSlash();
			//TODO: Handle roll
		}
		else
		{
			handleCharging(elapsed);
		}
		super.update(elapsed);
	}

	private function handleSlash():Void
	{
		//TODO: Implement cooldown
		if(InputHandler.SLASH())
		{
			var playState:PlayState = cast FlxG.state;
			playState.swordSlash(this.getPosition(), this.facing);
		}
	}

	private function handleMovement():Void
	{
		if(InputHandler.LEFT() && !InputHandler.RIGHT())
		{
			this.set_facing(FlxObject.LEFT);
			velocity.x = -1 * RUN_SPEED;
		}
		if(InputHandler.RIGHT() && !InputHandler.LEFT())
		{
			this.set_facing(FlxObject.RIGHT);
			velocity.x = 1 * RUN_SPEED;
		}
		if(InputHandler.JUMP() && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -JUMP_SPEED;
		}
		//TODO: Handle dropdown
	}

	private function handleCharging(elapsed:Float):Void
	{
		charge += elapsed;
	}

	private function releaseCharge():Void
	{
		if(charge > 0)
		{
			var playState:PlayState = cast FlxG.state;
			playState.lightCharge(this.getPosition(), this.charge);
		}
		charge = 0;
	}


}
