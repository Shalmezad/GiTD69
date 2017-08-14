package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;
class InputHandler
{
	public static function JUMP():Bool
	{
		return FlxG.keys.anyJustPressed([FlxKey.UP, FlxKey.W]);
	}

	public static function LEFT():Bool
	{
		return FlxG.keys.anyPressed([FlxKey.LEFT, FlxKey.A]);
	}

	public static function RIGHT():Bool
	{
		return FlxG.keys.anyPressed([FlxKey.RIGHT, FlxKey.D]);
	}

	public static function DOWN():Bool
	{
		return FlxG.keys.anyPressed([FlxKey.DOWN, FlxKey.S]);
	}

	public static function CHARGE():Bool
	{
		return FlxG.keys.anyPressed([FlxKey.Z, FlxKey.Y]);
	}

	public static function ROLL():Bool
	{
		return FlxG.keys.anyPressed([FlxKey.X]);
	}

	public static function SLASH():Bool
	{
		return FlxG.keys.anyPressed([FlxKey.C]);
	}

}
