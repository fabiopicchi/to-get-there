package interactive 
{
	import assets.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class Button extends ActivationObject
	{
		private const WIDTH : uint = 18;
		private const HEIGHT : uint = 8;
		
		private static var _buttons : FlxGroup;
		
		public function Button ()
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
			
			addAnimation ("RELEASED", [0]);
			addAnimation ("PRESSED", [1]);
			
			this.immovable = true;
		}
		
		private function isObjectPressing () : Boolean
		{
			for each (var pl : MovingPlatform in MovingPlatform.movingPlatforms.members)
			{
				if (this.overlaps(MovingPlatform.movingPlatforms))
					return true;
			}
			
			if (this.overlaps(PlayState.getInstance()._menino))
			{
				return true;
			}
			
			if (this.overlaps(PlayState.getInstance()._menina))
			{
				return true;
			}
			
			return false;
		}
		
		override public function update():void 
		{		
			if (_activatedObject)
			{
				_bActive = isObjectPressing ();
				
				if (isActive())
				{
					play ("PRESSED");
					_activatedObject.activate();
				}
				
				else
				{
					play ("RELEASED");
					_activatedObject.deactivate();
				}
			}
			
			super.update();
		}
		
		public static function get buttons () : FlxGroup
		{
			if (!_buttons)
			{
				_buttons = new FlxGroup ();
				for each (var obj : ActivationObject in members)
				{
					if (obj is Button)
						_buttons.add (obj);
				}
			}
			return _buttons;
		}
	}

}