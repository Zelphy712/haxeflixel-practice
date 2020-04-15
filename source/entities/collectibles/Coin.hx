package entities.collectibles;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Coin extends FlxSprite {
    public function new() {
        var x:Float = FlxG.random.int(0, 
            FlxG.width);
        var y:Float = FlxG.random.int(0, 
            FlxG.height);
        super(x, y);
        makeGraphic(10, 10, FlxColor.YELLOW);
    }

    override public function update(elapsed:Float){
        super.update(elapsed);
    }
}