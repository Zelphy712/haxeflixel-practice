package;

import lime.system.System;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;

class MenuState extends FlxState{

    override public function create():Void{
        super.create();

        var button:FlxButton = new FlxButton(FlxG.width/2, FlxG.height/2-25, "Play Game", StartGame);
        add(button);
        var exitButton:FlxButton = new FlxButton(FlxG.width/2,FlxG.height/2+25, "Exit Game",ExitGame);
        add(exitButton);
    }

    private function StartGame():Void{
        FlxG.switchState(new PlayState());
    }

    private function ExitGame():Void{
        System.exit(0);
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
    
}