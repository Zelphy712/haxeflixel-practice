package;

import flixel.text.FlxText;
import lime.system.System;
import flixel.FlxG;
import flixel.FlxState;

class WinState extends FlxState{

    override public function create():Void{
        super.create();

        var text = new FlxText(FlxG.width/2,FlxG.height/2,0,"You won! Press space to go back to the menu.",32);
        text.x = FlxG.width/2 - text.width/2;
        text.y = FlxG.height/2 - text.height/2;
        add(text);
    }

    private function StartGame():Void{
        FlxG.switchState(new PlayState());
    }

    private function ExitGame():Void{
        System.exit(0);
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);

        if(FlxG.keys.justPressed.SPACE){
            FlxG.switchState(new MenuState());
        }
    }
    
}