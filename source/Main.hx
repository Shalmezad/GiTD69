package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		var zoom:Int=1;
		var updateFrameRate:Int = 30;
		var drawFrameRate:Int = 30;
		var skipSplash:Bool = true;
		var fullScreen:Bool = false;
		addChild(new FlxGame(320, 240, PlayState, zoom, updateFrameRate, drawFrameRate, skipSplash, fullScreen));
	}
}
