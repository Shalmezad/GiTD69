package ;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	public function new()
	{
		super(40,0);
		makeGraphic(10,10,0xFFFF00FF);
		acceleration.y = 200;
	}
}
