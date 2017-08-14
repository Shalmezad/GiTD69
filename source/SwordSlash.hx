package ;
import flixel.FlxSprite;
class SwordSlash extends FlxSprite
{
	private var timeToLive:Float = 0;
	public function new()
	{
		super();
		makeGraphic(2,10,0xFFFF0000);
	}


	override public function reset(X:Float, Y:Float):Void
	{
		super.reset(X,Y);
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
