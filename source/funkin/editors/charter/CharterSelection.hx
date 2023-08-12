package funkin.editors.charter;

import funkin.options.type.NewOption;
import funkin.backend.system.framerate.Framerate;
import flixel.util.FlxColor;
import funkin.menus.FreeplayState.FreeplaySonglist;
import funkin.editors.EditorTreeMenu;
import funkin.options.*;
import funkin.options.type.*;

class CharterSelection extends EditorTreeMenu {
	public var freeplayList:FreeplaySonglist;
	public override function create() {
		bgType = "charter";

		super.create();

		Framerate.offset.y = 60;

		freeplayList = FreeplaySonglist.get(false);

		var list:Array<OptionType> = [
			for(s in freeplayList.songs) new IconOption(s.name, "Press ACCEPT to choose a difficulty to edit.", s.icon, function() {
				var list:Array<OptionType> = [
					for(d in s.difficulties) new TextOption(d, "Press ACCEPT to edit the chart for the selected difficulty", function() {
						FlxG.switchState(new Charter(s.name, d));
					})
				];
				list.push(new NewOption("New Difficulty", "New Difficulty", function() {

				}));
				optionsTree.add(new OptionsScreen(s.name, "Select a difficulty to continue.", list));
			})
		];

		list.insert(0, new NewOption("New Chart", "New Chart", function() {
			FlxG.state.openSubState(new SongCreationScreen());
		}));

		main = new OptionsScreen("Chart Editor", "Select a song to modify the charts from.", list);
	}

	override function createPost() {
		super.createPost();

		main.changeSelection(1);
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);

		bg.colorTransform.redOffset = lerp(bg.colorTransform.redOffset, 0, 0.0625);
		bg.colorTransform.greenOffset = lerp(bg.colorTransform.greenOffset, 0, 0.0625);
		bg.colorTransform.blueOffset = lerp(bg.colorTransform.blueOffset, 0, 0.0625);
		bg.colorTransform.redMultiplier = lerp(bg.colorTransform.redMultiplier, 1, 0.0625);
		bg.colorTransform.greenMultiplier = lerp(bg.colorTransform.greenMultiplier, 1, 0.0625);
		bg.colorTransform.blueMultiplier = lerp(bg.colorTransform.blueMultiplier, 1, 0.0625);
	}

	public override function onMenuChange() {
		super.onMenuChange();
		if (optionsTree.members.length > 1) { // selected a song
			// small flashbang
			if(freeplayList.songs.length <= main.curSelected-1) return;

			var color:FlxColor = freeplayList.songs[main.curSelected-1].parsedColor.getDefault(0xFFFFFFFF);

			bg.colorTransform.redOffset = 0.25 * color.red;
			bg.colorTransform.greenOffset = 0.25 * color.green;
			bg.colorTransform.blueOffset = 0.25 * color.blue;
			bg.colorTransform.redMultiplier = FlxMath.lerp(1, color.redFloat, 0.25);
			bg.colorTransform.greenMultiplier = FlxMath.lerp(1, color.greenFloat, 0.25);
			bg.colorTransform.blueMultiplier = FlxMath.lerp(1, color.blueFloat, 0.25);
		}
	}
}