package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
class GUI extends FlxGroup
{
	var hearts:Array<FlxSprite>;

	public function new()
	{
		super();
		hearts = new Array();
		for(i in 0...Player.MAX_HEALTH)
		{
			var heart:FlxSprite = new FlxSprite();
			heart.x = 20 + 24 * i;
			heart.y = 10;
			heart.scrollFactor.set(0,0);
			heart.loadGraphic("assets/images/heart-sheet.png", true, 16, 15);
			heart.animation.add("empty", [0], 1, false);
			heart.animation.add("filled", [1], 1, false);
			heart.animation.play("filled");
			hearts.push(heart);
			add(heart);
		}
	}


	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		var playState:PlayState = cast FlxG.state;
		// Get the player health:
		for(i in 0...Player.MAX_HEALTH)
		{
			if((i+1) <= playState.player.health)
			{
				hearts[i].animation.play("filled");
			}
			else
			{
				hearts[i].animation.play("empty");
			}
		}

	}

}
