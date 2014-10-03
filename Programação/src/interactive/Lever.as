package interactive 
{
	import assets.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class Lever extends ActivationObject
	{
		private const WIDTH : uint = 34;
		private const HEIGHT : uint = 24;
		
		//Specific properties from the lever
		private var _timer : Number;
		private var _effectDuration : Number;
		
		private static var _levers : FlxGroup;
		
		public function Lever ()
		{
		}
		
		override public function setup(objData:Object, offsetX:Number = 0, offsetY:Number = 0):void 
		{
			this.spriteWidth = WIDTH;
			this.spriteHeight = HEIGHT;
			
			super.setup(objData, offsetX, offsetY);
			
			//Center object over the tile
			this.x += (Jogo.TILE_WIDTH - width) / 2;
			this.y += (Jogo.TILE_WIDTH - height);
			
			this._effectDuration	= objData.tempo;
			addAnimation ("ACTIVATE", [0, 1, 2], 15, false);
			addAnimation ("DEACTIVATE", [2, 1, 0], 15, false);
			
			this.immovable = true;
		}
		
		public function pull () : void
		{
			_timer = 0;
			if (!_bActive)
				play ("ACTIVATE");
			_bActive = true;
		}
		
		override public function update():void 
		{
			if (_bActive) 
			{
				_timer += FlxG.elapsed;
				if (_timer > _effectDuration)
				{
					_bActive = false;
					play ("DEACTIVATE");
				}
			}
			
			if (_activatedObject)
			{
				if (isActive())
					_activatedObject.activate();
				else
					_activatedObject.deactivate();
			}
			
			super.update();
		}
		
		public static function get levers () : FlxGroup
		{
			if (!_levers )
			{
				_levers  = new FlxGroup ();
				for each (var obj : ActivationObject in members)
				{
					if (obj is Lever)
						_levers.add (obj);
				}
			}
			return _levers ;
		}
	}

}