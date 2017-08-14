package ;
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
			//TODO: Handle slash
			//TODO: Handle roll
		}
		else
		{
			handleCharging(elapsed);
		}
		super.update(elapsed);
	}

	private function handleMovement():Void
	{
		if(InputHandler.LEFT() && !InputHandler.RIGHT())
		{
			velocity.x = -1 * RUN_SPEED;
		}
		if(InputHandler.RIGHT() && !InputHandler.LEFT())
		{
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
			//TODO: Release a charge
			//From flxinvaders:
			//var playState:PlayState = cast FlxG.state;
			//Little hacky, but it'll get me the objects I need...
		}
		charge = 0;
	}


}
