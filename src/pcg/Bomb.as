package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;

	public class Bomb extends FlxSprite
	{
		[Embed(source = "../../assets/bomb.png")] private var _bombImage:Class;
		[Embed(source = "../../assets/explosion.png")] private var _explodeImage:Class;
		
		private var _exploding:Boolean;
		private var _timer:Number;
		
		public function Bomb()
		{
			_timer = 0;
			_exploding = false;
			this.loadGraphic(_bombImage, true, false, 16, 19);
			addAnimation("boom", [0,1,2,3,4], 5);
			play("boom");
		}
		
		override public function update():void
		{
			super.update();
			
			_timer += FlxG.elapsed;
			
			if(_timer > 1 && !_exploding)
				explode();
			
			if(!_exploding)
				velocity.y += 10;
		}
		
		private function explode():void
		{
			_exploding = true;
			
			loadGraphic(_explodeImage, true, false, 55, 55);
			
			addAnimation("explode", [12, 13, 14, 15, 16, 17, 18], 13, false);
			
			this.addAnimationCallback(function(animationName:String, currentFrame:uint, currentFrameIndex:uint):void
			{
				if(animationName == "explode" && currentFrameIndex == 18)
					visible = false;
				
				if(animationName == "explode" && currentFrameIndex == 13)
				{
					var event:GameEvent = new GameEvent(GameEvent.EXPLOSION);
					event.position = new FlxPoint(x, y);
					event.radius = 3;
					
					Game.emitGameEvent(event);
					
					FlxG.shake(0.006, 0.15);
				}
			});
			
			this.offset.x = 27;
			this.offset.y = 27;
			play("explode");
		}
	}
}