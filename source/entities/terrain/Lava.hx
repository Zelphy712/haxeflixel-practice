package entities.terrain;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Lava extends FlxSprite {
    public static var WIDTH(default, never) = 32;
    public static var HEIGHT(default, never) = 32;
    
    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.ORANGE);

        // Set immovable to true, prevents this from getting pushed during FlxG.collide()
        immovable = true;
    }
}