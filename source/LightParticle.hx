package ;

import flixel.FlxSprite;

class LightParticle extends FlxSprite
{
	private var timeToLive:Float = 0;
	private var initialX:Float;
	private var initialY:Float;
	private var rad:Float;
	private var radius:Float;

	public function new()
	{
		super();
		loadGraphic("assets/images/light_particle.png");
		this.health = 2;
	}


	public function resetWithIndex(X:Float, Y:Float, index:Int):Void
	{
		super.reset(X,Y);
		initialX = X;
		initialY = Y;
		timeToLive = 2;
		rad = 2 * Math.PI * (index / 12);
		radius = 0;
	}


	override public function update(elapsed:Float):Void
	{
		rad += 2 * Math.PI * elapsed;
		radius += 40 * elapsed;

		this.x = initialX + Math.cos(rad) * radius;
		this.y = initialY + Math.sin(rad) * radius;

		timeToLive -= elapsed;
		if(timeToLive <= 0)
		{
			this.kill();
		}
		super.update(elapsed);
	}
}