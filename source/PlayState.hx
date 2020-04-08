package;

import flixel.FlxState;

class PlayState extends FlxState
{
	var text = new flixel.text.FlxText(0, 0, 0, "Hello World", 64);
	var xDir=1;
	var yDir=1;

	var player:Hero = new Hero();
	override public function create()
	{
		super.create();


		text.setFormat("Arial",40,0xffff00ff);
		text.screenCenter();
		text.moves = true;
		add(text);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		text.x += xDir;
		text.y += yDir;
		if(text.x+text.frameWidth >= 640){
			xDir = -1;
		}else if(text.x <= 0){
			xDir = 1;
		}

		if(text.y+text.frameHeight >= 480){
			yDir = -1;
		}else if(text.y <= 0){
			yDir = 1;
		}
	}
}
