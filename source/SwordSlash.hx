package ;
import flixel.FlxSprite;
import flixel.FlxObject;
class SwordSlash extends FlxSprite
{
	private var timeToLive:Float = 0;
	public function new()
	{
		super();
		loadGraphic("assets/images/sword_slash.png");
		this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
		this.health = 1.0;
	}


	public function resetWithFacing(X:Float, Y:Float, facing:Int):Void
	{
		super.reset(X,Y);
		this.facing = facing;
		timeToLive = 0.5;
	}


	override public function update(elapsed:Float):Void
	{
		timeToLive -= elapsed;
		if(timeToLive <= 0)
		{
			this.kill();
		}
		super.update(elapsed);
	}
}
