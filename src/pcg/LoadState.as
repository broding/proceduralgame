package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	import pcg.levelgenerator.RandomLevelGenerator;

	public class LoadState extends FlxState
	{
		private var _level:Level;
		private var _text:FlxText;
		private var _startedTransition:Boolean;
		
		[Embed(source = "../../assets/fonts/small_bold_pixel-7.ttf", fontName = "bold20", embedAsCFF="false", mimeType="application/x-font")]
		private var FontClass:Class;
		
		[Embed(source = "../../assets/fonts/5threezy.ttf", fontName = "5th", embedAsCFF="false", mimeType="application/x-font")]
		private var FontClass2:Class;
		
		[Embed(source = "../../assets/fonts/smallest_pixel-7.ttf", fontName = "normal10", embedAsCFF="false", mimeType="application/x-font")]
		private var FontClass3:Class;
		
		public function LoadState()
		{
			_startedTransition = false;
		}
		
		override public function create():void
		{
			super.create();
			
			FlxG.flash(0xff000000, 0.3);
			
			_text = new FlxText(0, 200, 320, "Building you a level..", true);
			_text.alignment = "center";
			_text.setFormat("normal10", 10);
			add(_text);
			
			_level = new Level(new RandomLevelGenerator());
		}
		
		override public function update():void
		{
			super.update();
			
			if(_level.loaded && !_startedTransition)
			{
				_startedTransition = true;
				FlxG.fade(0xff000000, 1, function():void
				{
					FlxG.switchState(new GameState(_level));
				});
			}
				
		}
	}
}