package;

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
	var player:Player;
	var tileMap:FlxTilemap;
	override public function create():Void
	{
		super.create();
		player = new Player();
		tileMap = new FlxTilemap();


		//loadMapFromCSV(MapData:String, TileGraphic:FlxTilemapGraphicAsset, TileWidth:Int = 0, TileHeight:Int = 0,
		//?AutoTile:FlxTilemapAutoTiling, StartingIndex:Int = 0, DrawIndex:Int = 1, CollideIndex:Int = 1)
		tileMap.loadMapFromCSV(Assets.getText("assets/data/map.csv"), "assets/images/tileset.png",32,32, FlxTilemapAutoTiling.OFF,0,1,1);

		add(tileMap);
		add(player);

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(player, tileMap);
	}
}
