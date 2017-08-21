package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.math.FlxRandom;
import flixel.FlxBasic.FlxType;
import flixel.FlxObject;
import flixel.group.FlxGroup;
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

class PlayState extends FlxTransitionableState
{
	private var SLASH_SPEED = 140;

	public var player:Player;
	var bg_1:FlxSprite;
	var bg_2:FlxSprite;
	var bg_3:FlxSprite;
	var tileMap:FlxTilemap;
	var swordSlashes:FlxTypedGroup<SwordSlash>;
	var lightParticles:FlxTypedGroup<LightParticle>;
	var enemies:FlxGroup;
	var gui:GUI;

	var spawnTimer:Float;

	public var random:FlxRandom;

	override public function create():Void
	{
		super.create();
		random = new FlxRandom();
		player = new Player();
		tileMap = new FlxTilemap();
		swordSlashes = new FlxTypedGroup(4);
		lightParticles = new FlxTypedGroup(12);
		enemies = new FlxTypedGroup();
		gui = new GUI();

		bg_1 = new FlxSprite();
		bg_2 = new FlxSprite();
		bg_3 = new FlxSprite();

		//Load our backgrounds:
		bg_1.loadGraphic("assets/images/background_1.png");
		bg_2.loadGraphic("assets/images/background_2.png");
		bg_3.loadGraphic("assets/images/background_3.png");
		bg_1.scrollFactor.set(0,0);
		bg_2.scrollFactor.set(0,0);
		bg_3.scrollFactor.set(0,0);

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
		for(i in 0...12)
		{
			var light:LightParticle = new LightParticle();
			light.exists = false;
			lightParticles.add(light);
		}

		add(bg_1);
		add(bg_2);
		add(bg_3);

		add(tileMap);
		add(swordSlashes);
		add(lightParticles);
		add(player);
		add(enemies);

		add(gui);

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		spawnTimer = 1;

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		handleSpawn(elapsed);
		FlxG.collide(player, tileMap);
		FlxG.overlap(lightParticles, enemies, projectileEnemyOverlap);
		FlxG.overlap(swordSlashes, enemies, projectileEnemyOverlap);
		FlxG.overlap(enemies, player, enemyPlayerOverlap);
	}

	private function projectileEnemyOverlap(bullet:Dynamic, enemy:Dynamic):Void
	{
		var castedEnemy:Enemy = cast enemy;
		var castedBullet:FlxSprite = cast bullet;

		castedEnemy.attemptHurt(castedBullet.health);
	}

	private function enemyPlayerOverlap(enemy:Dynamic, p:Dynamic):Void
	{
		player.attemptHurt(1);
	}

	private function handleSpawn(elapsed:Float):Void
	{
		spawnTimer -= elapsed;
		if(spawnTimer <= 0)
		{
			spawnTimer = 5;
			//Spawn something:
			var enemyChoice:Int = random.int(0, 1);
			if(enemyChoice == 0)
			{
				var ghost:EnemyGhost = cast enemies.recycle(EnemyGhost);
				ghost.resetSpawn();
			}
			else
			{
				var orb:EnemyOrb = cast enemies.recycle(EnemyOrb);
				orb.resetSpawn();
			}
		}
	}


	//Direction is based on FlxObject directions
	public function swordSlash(location:FlxPoint, direction:Int)
	{
		var slash:SwordSlash = swordSlashes.recycle();
		slash.resetWithFacing(location.x, location.y, direction);
		if(direction == FlxObject.LEFT)
		{
			slash.velocity.x = -SLASH_SPEED;
		}
		else
		{
			slash.velocity.x = SLASH_SPEED;
		}
	}

	public function lightCharge(location:FlxPoint, charge:Float)
	{
		for(i in 0...12)
		{
			var light:LightParticle = lightParticles.recycle();
			light.resetWithIndex(location.x, location.y, i);
		}
	}
}
