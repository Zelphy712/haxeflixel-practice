package;

import flixel.math.*;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Hero extends FlxSprite{

    var xDir = 1;
    var yDir = 1;
    var boxColor:FlxColor = FlxColor.WHITE;
    var target:FlxPoint;
    var mode = 0;
    
    public function new(){
        super();
    }

    override function update(elapsed:Float){
        target = FlxG.mouse.getWorldPosition();
        

        if(mode == 0){
            //Toroidal mode
            if(x + frameWidth >= 640){
                x = 0;
                // xDir = -1;
            }else if(x <= 0){
                x = 640;
                // xDir = 1;
            }
    
            if(y + frameHeight >= 480){
                y = 0;
                // yDir = -1;
            }else if(y <= 0){
                y = 480;
                // yDir = 1;
            }
        }else if(mode == 1){
            //Mouse mode
            x = target.x;
            y = target.y;
        }else {
            //Bounce mode
            if(x + frameWidth >= 640){
                // x = 0;
                xDir = -1;
            }else if(x <= 0){
                // x = 640;
                xDir = 1;
            }
    
            if(y + frameHeight >= 480){
                // y = 0;
                yDir = -1;
            }else if(y <= 0){
                // y = 480;
                yDir = 1;
            }
        }
        
        if(FlxG.keys.justPressed.SPACE){
            mode = (mode+1)%3;
            trace(mode);
        }

        x += xDir;
        y += yDir;

        boxColor = FlxColor.fromRGB(Math.floor(255*y/480),0,Math.floor(255*x/640),255);
        makeGraphic(32,32,boxColor);
    } 
}