package;

import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.FlxCamera.FlxCameraFollowStyle;
import openfl.Assets;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	private var SLASH_SPEED = 140;

	var player:Player;
	var tileMap:FlxTilemap;
	var swordSlashes:FlxTypedGroup<SwordSlash>;

	override public function create():Void
	{
		super.create();
		player = new Player();
		tileMap = new FlxTilemap();
		swordSlashes = new FlxTypedGroup(4);

		//Set up our tilemap:
		//loadMapFromCSV(MapData:String, TileGraphic:FlxTilemapGraphicAsset, TileWidth:Int = 0, TileHeight:Int = 0,
		//?AutoTile:FlxTilemapAutoTiling, StartingIndex:Int = 0, DrawIndex:Int = 1, CollideIndex:Int = 1)
		tileMap.loadMapFromCSV(Assets.getText("assets/data/map.csv"), "assets/images/tileset.png",32,32, FlxTilemapAutoTiling.OFF,0,1,1);
		FlxG.camera.setScrollBoundsRect(0,0,tileMap.width, tileMap.height);
		FlxG.worldBounds.set(0,0,tileMap.width, tileMap.height);


		// Set up our pools:
		for (i in 0...4)
		{
			var slash:SwordSlash = new SwordSlash();
			slash.exists = false;
			swordSlashes.add(slash);
		}


		add(tileMap);
		add(player);
		add(swordSlashes);

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(player, tileMap);
	}


	//Direction is based on FlxObject directions
	public function swordSlash(location:FlxPoint, direction:Int)
	{
		trace("swordSlash");
		var slash:SwordSlash = swordSlashes.recycle();
		slash.reset(location.x, location.y);
		if(direction == FlxObject.LEFT)
		{
			slash.velocity.x = -SLASH_SPEED;
		}
		else
		{
			slash.velocity.x = SLASH_SPEED;
		}
	}
}
