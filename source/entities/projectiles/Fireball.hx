package entities.projectiles;

import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Fireball extends FlxSprite {
    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X, Y);
        makeGraphic(10, 10, FlxColor.RED);

        velocity.x = FlxG.random.float(-1.0,1.0);
        velocity.y = FlxG.random.float(-1.0,1.0);
        var length = FlxMath.vectorLength(velocity.x, velocity.y);
        velocity.x = velocity.x/length*100;
        velocity.y = velocity.y/length*100;
        // trace(velocity);
    }
}