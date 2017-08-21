package ;
import flixel.effects.FlxFlicker;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

class Player extends FlxSprite
{
	public static var MAX_HEALTH:Int = 3;

	private var RUN_SPEED = 140;
	private var GRAVITY = 420;
	private var JUMP_SPEED = 250;

	private var charge:Float = 0;

	public function new()
	{
		super(40,0);
		loadGraphic("assets/images/dwarf-sheet.png", true, 38, 23);
		animation.add("move", [0], 1, false);
		animation.add("slash", [0,1,2,3], 20, false);
		animation.add("chant", [4,5], 5, true);
		animation.add("chant-glowing", [6,7], 5, true);
		animation.play("move");
		acceleration.y = GRAVITY;
		maxVelocity.y = JUMP_SPEED;
		this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
		this.centerOrigin();
		this.health = MAX_HEALTH;
		this.width = 12;
		this.height = 20;
		this.offset.set(9, 23-this.height);
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
			playState.swordSlash(this.getCenter(), this.facing);
			animation.play("slash");
		}
	}

	private function handleMovement():Void
	{
		if(InputHandler.LEFT() && !InputHandler.RIGHT())
		{
			this.set_facing(FlxObject.LEFT);
			velocity.x = -1 * RUN_SPEED;
			this.offset.set(38-9-this.width, 23-this.height);
		}
		if(InputHandler.RIGHT() && !InputHandler.LEFT())
		{
			this.set_facing(FlxObject.RIGHT);
			velocity.x = 1 * RUN_SPEED;
			this.offset.set(9, 23-this.height);
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
		if(charge > 2)
		{
			animation.play("chant-glowing");
		}
		else
		{
			animation.play("chant");
		}
	}

	private function releaseCharge():Void
	{
		if(charge > 2)
		{
			var playState:PlayState = cast FlxG.state;
			playState.lightCharge(this.getCenter(), this.charge-2);
		}
		if(charge > 0)
		{
			animation.play("move");
		}
		charge = 0;
	}

	private function getCenter():FlxPoint
	{
		var pos:FlxPoint = this.getPosition();
		pos.x = pos.x + this.width/2;
		pos.y = pos.y + this.height/2;
		return pos;
	}

	public function attemptHurt(damage:Float):Void
	{
		if(!FlxFlicker.isFlickering(this))
		{
			// Damage us:
			this.hurt(damage);
			FlxFlicker.flicker(this, 3);
		}
	}

}
