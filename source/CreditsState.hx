package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var descBox:AttachedSprite;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	var offsetThing:Float = -75;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		//trace("finding mod shit");
		for (folder in Paths.getModDirectories())
		{
			var creditsFile:String = Paths.mods(folder + '/data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		};
		var folder = "";
			var creditsFile:String = Paths.mods('data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['FNF Hiro mod Team'],
			['HIRO NOT HILO',			'hilo',				'EVERYTHING of Hiro mod',												'https://www.youtube.com/channel/UC73PBwTkGsDXwMVSLf77Sww/featured',		'9999FF'],
			['Astrogod',				'astrogod',			'V-TUBER CHANNEL\n(he hate rick roll so much lol)',						'https://www.youtube.com/channel/UCBhGjgzrrbL8V4zmYhH53hA',					'CC3366'],
			['apro716',					'apro',				'cool \nmake engine even more better',																	'https://www.youtube.com/watch?v=a3Z7zEc7AXQ',								'66FFFF'],
			['Soji Rikuta',				'yuu',				'play tester\ncool youtuber lol',										'https://www.youtube.com/channel/UCWzBFdgN59Nnziwpb8hhX8g/featured',		'66FFFF'],
			[''],
			/*['Special Thanks'],
			['matt-sudo-jpg',			'shadowmario',		'judgement counter',													'https://github.com/ShadowMario/FNF-PsychEngine/discussions/3707',			'389A58'],
			['andromeda-engine',		'shadowmario',		'highest combo, epic judgement, ms counter idea and osu mania combo',	'https://github.com/nebulazorua/andromeda-engine',							'9999FF'],
			['jloor engine',			'bb-panzu',			'cool title screen',													'https://github.com/JloorMC/Jloor-Engine-Main',								'389A58'],
			['Just Jack',				'bb-panzu',			'cool Cache screen but bruh i dont use',								'https://twitter.com/Just_Jack6',											'389A58'],
			['Notice Me Senpai',		'bb-panzu',			'loading screen in story mode',											'https://gamebanana.com/mods/350057',										'389A58'],
			['FNF vs cassette girl',	'bb-panzu',			'loading text lol',														'https://gamebanana.com/mods/339085',										'389A58'],
			['Friday Night Voltex',		'bb-panzu',			'ms counter (old)',														'https://gamebanana.com/mods/345560',										'389A58'],
			['Project fnf 2',			'bb-panzu',			'cool transition',														'https://github.com/l1ttleO/ProjectFNF',									'389A58'],
			['FNF grafex engine',		'shadowmario',		'camera zoom in freeplay state',										'https://github.com/XaleTheCat/fnf-grafex',									'389A58'],
			['psych engine 0.5.2',		'shadowmario',		'hit sound  and  credit state',											'https://github.com/ShadowMario/FNF-PsychEngine',							'389A58'],
			['fnf lore engine',			'bb-panzu',			'osu mania combo',														'https://github.com/sayofthelor/lore-engine/tree/0.3-LE,					'389A58'],
			[''],*/
			['Psych Engine Team'],
			['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',											'https://twitter.com/Shadow_Mario_',	'444444'],
			['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',										'https://twitter.com/river_oaken',		'C30085'],
			['bb-panzu',			'bb-panzu',			'Additional Programmer of Psych Engine',									'https://twitter.com/bbsub3',			'389A58'],
			[''],
			['Engine Contributors'],
			['shubs',				'shubs',			'New Input System Programmer',												'https://twitter.com/yoshubs',			'4494E6'],
			['SqirraRNG',			'gedehari',			'Chart Editor\'s Sound Waveform base',										'https://twitter.com/gedehari',			'FF9300'],
			['iFlicky',				'iflicky',			'Delay/Combo Menu Song Composer\nand Dialogue Sounds',						'https://twitter.com/flicky_i',			'C549DB'],
			['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',												'https://twitter.com/polybiusproxy',	'FFEAA6'],
			['Keoiki',				'keoiki',			'Note Splash Animations',													'https://twitter.com/Keoiki_',			'FFFFFF'],
			[''],		
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",										'https://twitter.com/ninja_muffin99',	'F73838'],
			['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",											'https://twitter.com/PhantomArcade3K',	'FFBB1B'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",											'https://twitter.com/evilsk8r',			'53E52C'],
			['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",											'https://twitter.com/kawaisprite',		'6475F3']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}

		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}
	var moveTween:FlxTween = null;

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
