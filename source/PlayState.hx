package;

import flixel.text.FlxText;
import entities.collectibles.Coin;
import entities.terrain.Lava;
import entities.projectiles.Fireball;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import entities.player.Hero;
import entities.terrain.Wall;
import flixel.FlxState;

class PlayState extends FlxState
{

	private static var WORLD_LEFT(default,never) = -(1280*2);
	private static var WORLD_RIGHT(default,never) = 1280*2;
	private static var WORLD_TOP(default,never) = -(960*2);
	private static var WORLD_BOTTOM(default,never) = 960*2;

	private static var WALL_COUNT(default, never) = 10;
	private static var WALL_START_X(default, never) = 150;
	private static var WALL_START_Y(default, never) = 200;

	private static var LAVA_COUNT(default, never) = 10;
	private static var LAVA_START_X(default, never) = 150;
	private static var LAVA_START_Y(default, never) = 232;

	private static var FIREBALL_COUNT(default, never) = 10;
	private static var FIREBALL_SPAWN_BORDER(default, never) = 50;

	private var hero:Hero;
	private var coin:Coin;
	private var walls:FlxTypedGroup<Wall>;
	private var fireballs:FlxTypedGroup<Fireball>;
	private var lavaPools:FlxTypedGroup<Lava>;

	var score:FlxText;

	override public function create():Void
	{
		super.create();

		hero = new Hero();
		add(hero);
		FlxG.camera.target = hero;
		FlxG.camera.zoom = .5;
		initializeWalls();
		initializeLava();
		initializeFireballs();
		coin = new Coin();
		add(coin);
		score = new FlxText(100,100,0,"0",32);
		add(score);
	}

	private function initializeWalls() {
		FlxG.worldBounds.set(WORLD_LEFT-32,WORLD_TOP-32,WORLD_RIGHT-WORLD_LEFT+64,WORLD_BOTTOM-WORLD_TOP+64);
		walls = new FlxTypedGroup<Wall>();

		for (i in 0...WALL_COUNT) {
			var x:Float = WALL_START_X + (i * Wall.WIDTH);
			var y:Float = WALL_START_Y;
			var wall:Wall = new Wall(x, y);
			walls.add(wall);
		}

		for(i in -1...Math.floor((WORLD_RIGHT-WORLD_LEFT)/32)){
			var x:Float = (i) * 32+WORLD_LEFT;
			var wall:Wall = new Wall(x, WORLD_TOP-32);
			var wall2:Wall = new Wall(x, WORLD_BOTTOM);
			walls.add(wall);
			walls.add(wall2);
		}

		for(i in -1...Math.floor((WORLD_BOTTOM-WORLD_TOP)/32)){
			var y:Float = (i) * 32+WORLD_TOP;
			
			var wall:Wall = new Wall(WORLD_LEFT-32,y);
			var wall2:Wall = new Wall(WORLD_RIGHT,y);
			walls.add(wall);
			walls.add(wall2);
		}
		
		add(walls);
	}

	private function initializeLava(){
		lavaPools = new FlxTypedGroup<Lava>();

		for (i in 0...LAVA_COUNT) {
			var x:Float = LAVA_START_X + (i * Lava.WIDTH);
			var y:Float = LAVA_START_Y;
			var lava:Lava = new Lava(x, y);
			lavaPools.add(lava);
		}
			add(lavaPools);
	}

	private function initializeFireballs() {
		fireballs = new FlxTypedGroup<Fireball>();

		for (i in 0...FIREBALL_COUNT) {
			var x:Float = FlxG.random.int(FIREBALL_SPAWN_BORDER, 
				FlxG.width - FIREBALL_SPAWN_BORDER);
			var y:Float = FlxG.random.int(FIREBALL_SPAWN_BORDER, 
				FlxG.height - FIREBALL_SPAWN_BORDER);
			var fireball = new Fireball(x, y);
			fireballs.add(fireball);
		}
		add(fireballs);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);


		if(fireballs.length<FIREBALL_COUNT){
			fireballs = new FlxTypedGroup<Fireball>();

			var x:Float = FlxG.random.int(FIREBALL_SPAWN_BORDER, 
				FlxG.width - FIREBALL_SPAWN_BORDER);
			var y:Float = FlxG.random.int(FIREBALL_SPAWN_BORDER, 
				FlxG.height - FIREBALL_SPAWN_BORDER);
			var fireball = new Fireball(x, y);
			fireballs.add(fireball);
		}
		

		// Uncomment to collide hero against all wall objects.w
		FlxG.collide(hero, walls);

		FlxG.overlap(hero,lavaPools,resolveHeroLavaOverlap);

		FlxG.overlap(hero,coin,resolveHeroCoinOverlap);

		// Uncomment to trigger custom logic when a player overlaps with a fireball.
		FlxG.overlap(hero, fireballs, resolveHeroFireballOverlap);

		// Wrap various objects if gone offscreen.
		// screenWrapObject(hero);
		for (fireball in fireballs) {
			screenWrapObject(fireball);
		}
		score.x = hero.x - FlxG.width + 100;
		score.y = hero.y - FlxG.height + 100;

	}

	private function screenWrapObject(wrappingObject:FlxObject) {
		if (wrappingObject.x > WORLD_RIGHT) {
			wrappingObject.x = WORLD_LEFT - wrappingObject.width;
		} else if (wrappingObject.x + wrappingObject.width < WORLD_LEFT) {
			wrappingObject.x = WORLD_RIGHT;
		}

		if (wrappingObject.y > WORLD_BOTTOM) {
			wrappingObject.y = WORLD_TOP - wrappingObject.height;
		} else if (wrappingObject.y + wrappingObject.height < WORLD_TOP) {
			wrappingObject.y = WORLD_BOTTOM;
		}
	}

	/**
		Function called when an overlap between hero and fireball is detected.
	**/
	private function resolveHeroFireballOverlap(hero:Hero, fireball:Fireball) {
		fireball.kill();
		hero.kill();
		FlxG.switchState(new MenuState());
	}

	private function resolveHeroLavaOverlap(hero:Hero, lava:Lava){
		hero.kill();
		FlxG.switchState(new MenuState());
	}

	private function resolveHeroCoinOverlap(hero:Hero, thisCoin:Coin){
		hero.updateScore(10);
		score.text = hero.score+"";
		thisCoin.kill();
		coin = new Coin();
		add(coin);
	}
}
