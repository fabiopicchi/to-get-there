package interactive
{
	import assets.Assets;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class MovingPlatform extends ActivatedObject
	{
		private const WIDTH : uint = 26;
		
		//Constants for the platform direction
		private static const LEFT : uint = 0;
		private static const UP : uint = 1;
		private static const RIGHT : uint = 2;
		private static const DOWN : uint = 3;
		
		//Specific properties of the moving platform
		private var _initX : uint;
		private var _initY : uint;
		private var _way : uint;
		private var _distance : Number;
		private var _platSpeed : Number;
		private var _blockedA:Boolean = false;
		private var _blockedD:Boolean = false;
		
		private static var _movingPlatforms : FlxGroup;
		
		public function MovingPlatform ()
		{
		}
		
		override public function setup(objData:Object, offsetX:Number = 0, offsetY:Number = 0):void 
		{
			if ((objData.tipo as String).indexOf('v') != -1)
			{
				this.spriteWidth = WIDTH;
				this.spriteHeight = objData.height;
			}
			else if ((objData.tipo as String).indexOf('h') != -1)
			{
				this.spriteWidth = objData.width;
				this.spriteHeight = WIDTH;
			}
			
			super.setup(objData, offsetX, offsetY);
			
			//Center object over the tile
			if ((objData.tipo as String).indexOf('v') != -1)
			{
				this.x += (Jogo.TILE_WIDTH - width) / 2;
			}
			else if ((objData.tipo as String).indexOf('h') != -1)
			{
				this.y += (Jogo.TILE_WIDTH - height) / 2;
			}
			
			_initX = x;
			_initY = y;
			_way = objData.sentido;
			_distance = objData.distancia * Jogo.TILE_WIDTH;
			_platSpeed = objData.velocidade;
			
			this.immovable = true;
		}
		override internal function activate () : void
		{
			super.activate();
			if (!_blockedA)
			{
				switch (_way)
				{
					case LEFT:
						velocity.x = -_platSpeed;
						if (x <= _initX - _distance)
						{
							velocity.x = 0;
							x = _initX - _distance;
						}
						break;
					case RIGHT:
						velocity.x = _platSpeed;
						if (x >= _initX + _distance)
						{
							velocity.x = 0;
							x = _initX + _distance;
						}
						break;
					case UP:
						velocity.y = -_platSpeed;
						if (y <= _initY - _distance)
						{
							velocity.y = 0;
							y = _initY - _distance;
						}
						break;
					case DOWN:
						velocity.y = _platSpeed;
						if (y >= _initY + _distance)
						{
							velocity.y = 0;
							y = _initY + _distance;
						}
						break;
				}
			}
			else
			{
				velocity.x = 0;
				velocity.y = 0;
			}
		}
		
		override internal function deactivate () : void
		{
			super.deactivate();
			if (!_blockedD)
			{
				switch (_way)
				{
					case LEFT:
						velocity.x = _platSpeed;
						if (x >= _initX) 
						{
							velocity.x = 0;
							x = _initX;
						}
						break;
					case RIGHT:
						velocity.x = -_platSpeed;
						if (x <= _initX) 
						{
							velocity.x = 0;
							x = _initX;
						}
						break;
					case UP:
						velocity.y = _platSpeed;
						if (y >= _initY)
						{
							velocity.y = 0;
							y = _initY;
						}
						break;
					case DOWN:
						velocity.y = -_platSpeed;
						if (y <= _initY)
						{
							velocity.y = 0;
							y = _initY;
						}
						break;
				}
			}
			else
			{
				velocity.x = 0;
				velocity.y = 0;
			}
		}
		
		public static function get movingPlatforms () : FlxGroup
		{
			if (!_movingPlatforms)
			{
				_movingPlatforms = new FlxGroup ();
				for each (var obj : ActivatedObject in members)
				{
					if (obj is MovingPlatform)
						_movingPlatforms.add (obj);
				}
			}
			return _movingPlatforms;
		}
		
		public function set blocked(value:Boolean):void 
		{
			if (value)
			{
				if (_bActivated)
				{
					if (!_blockedD) _blockedA = true;
				}
				else
				{
					if (!_blockedA) _blockedD = true;
				}
			}
			else
			{
				_blockedA = false;
				_blockedD = false;
			}
		}
		
	}

}