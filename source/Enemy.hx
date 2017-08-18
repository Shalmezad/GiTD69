package;

import flixel.effects.FlxFlicker;
import flixel.FlxSprite;

class Enemy extends FlxSprite
{
	public function attemptHurt(damage:Float)
	{
		if(!FlxFlicker.isFlickering(this))
		{
			// Damage us:
			this.hurt(damage);
			FlxFlicker.flicker(this);
		}
	}
}
