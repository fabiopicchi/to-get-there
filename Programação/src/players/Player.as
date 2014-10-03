package players
{
	import assets.Assets;
	import com.adobe.serialization.json.JSON;
	import interactive.Button;
	import interactive.GameObject;
	import interactive.Lever;
	import interactive.MovingPlatform;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class Player extends GameObject
	{	
		//Fisica
		private static const MAX_VELOCITY_X : uint 		= 200;
		private static const MAX_VELOCITY_Y : uint		= 600;
		private static const GRAVITY 		: uint 		= 1600;
		private static const FRICTION 		: uint 		= 2 * MAX_VELOCITY_X; //Não está sendo usado atrito
		private static const JUMP_HEIGHT 	: Number	= (7 / 2) * Jogo.TILE_HEIGHT; //Tres tiles e meio de altura de pulo
		
		//Tamanho do Sprite
		protected var WIDTH 	: uint = 32;
		protected var HEIGHT 	: uint = 64;
		
		//Bounding box offset
		private const WIDTH_BOX		: uint 	= 24;
		private const HEIGHT_BOX	: uint 	= 50;
		
		//Command
		protected var _config : ControlConfig;
		
		protected var _wasTouchingPlatform : MovingPlatform;
		protected var _touchingPlatform : MovingPlatform;
		protected var _referentialSpeed : FlxPoint;
		public var _bNoControl : Boolean = false;
		
		/* 
		 * Configuração de controles varia de 1 a 3
		 * (o resto é inválido)
		*/
		
		public function Player ()
		{
		}
		
		override public function setup (objData : Object, offsetX : Number = 0, offsetY : Number = 0) : void
		{
			this.spriteWidth = WIDTH;
			this.spriteHeight = HEIGHT;
			
			super.setup(objData, offsetX, offsetY);
			
			//Bounding Box e Posicionamento
			this.width = WIDTH_BOX;
			this.height = HEIGHT_BOX;
			
			//Center image over hitbox
			this.offset.x += (WIDTH - WIDTH_BOX) / 2;
			this.offset.y += (HEIGHT - HEIGHT_BOX);
			
			//Física
			this.acceleration.y = GRAVITY;
		}
		
		override public function set spriteHeight(value:uint):void 
		{
			super.spriteHeight = value;
		}
		
		private function inputUpdate () : void
		{
			//Movimentação Esquerda e Direita
			if(_config.isLeftPressed())
			{
				this.facing = FlxObject.LEFT;
				this.velocity.x = (!_bNoControl) ? -200 : -100;
				if (touchingPlatform && touchingPlatform.velocity.x < 0)
					this.velocity.x += touchingPlatform.velocity.x;
			}
			else if(_config.isRightPressed())
			{
				this.facing = FlxObject.RIGHT;
				this.velocity.x = (!_bNoControl) ? 200 : 100;
				if (touchingPlatform && touchingPlatform.velocity.x > 0)
					this.velocity.x += touchingPlatform.velocity.x;
			}
			else
				velocity.x = 0;
			
			if (touchingPlatform && this.isTouching(DOWN) && touchingPlatform.isTouching (UP)) {
				if (_referentialSpeed) this.velocity.y += _referentialSpeed.y;
			}
			
			//Interação com objetos
			var interactableObject : Object = interactableInRange ();
			if (interactableObject)
			{
				if (FlxG.keys.justPressed(_config.downKeyCode))
				{
					if (interactableObject is Lever)
						(interactableObject as Lever).pull();
				}
			}
			
			if (!_bNoControl)
			{
				//Pulo
				if(FlxG.keys.justPressed(_config.upKeyCode) && this.isTouching(FlxObject.FLOOR))
					this.velocity.y = - Math.ceil(Math.sqrt(2 * GRAVITY * JUMP_HEIGHT));
			}
		}
		
		private function interactableInRange () : Object
		{
			//testa por alavancas
			for each (var lev : Lever in Lever.levers.members)
			{
				if (this.overlaps(lev))
				{
					return lev;
				}
			}
			
			return null;
		}
		
		override public function update():void 
		{
			inputUpdate ();
			super.update ();
			
			if (touchingPlatform && this.overlaps(touchingPlatform) && (touchingPlatform.y < this.y)) this.touching |= UP;
			
			//impede de ser esmagada
			if (touchingPlatform)
			{
				if ((this.touching & DOWN) == DOWN && (this.touching & UP) == UP)
				{
					touchingPlatform.blocked = true;
				}
				else
				{
					touchingPlatform.blocked = false;
				}
			}
			else
			{
				if (_wasTouchingPlatform)
				{
					_wasTouchingPlatform.blocked = false;
				}
			}
			//animations
			if (velocity.y < 0 && !isTouching(DOWN))
				play("JUMPING");
			else if (velocity.y > 0 && !isTouching(DOWN))
				play("FALLING");
			else if (velocity.x != 0)
				play ("WALKING");
			else
				play ("IDLE");
			
			_wasTouchingPlatform = _touchingPlatform;
			if (touchingPlatform && !this.overlaps(touchingPlatform)) _touchingPlatform = null;
		}
		
		public function get touchingPlatform():MovingPlatform 
		{
			return _touchingPlatform;
		}
		
		public function set touchingPlatform(value:MovingPlatform):void 
		{
			if (value) 
			{
				if (this.isTouching(DOWN) && value.isTouching(UP))
					this._referentialSpeed = value.velocity;
			}
			_touchingPlatform = value;
		}
		
		public function get referentialSpeed():FlxPoint 
		{
			return _referentialSpeed;
		}
		
		public function set referentialSpeed(value:FlxPoint):void 
		{
			_referentialSpeed = value;
		}
		
		static public function separatePlayer (Object1:FlxObject, Object2:FlxObject):Boolean
		{
			var separatedX:Boolean = FlxObject.separateX(Object1,Object2);
			var separatedY:Boolean = Player.separatePlayerY(Object1,Object2);
			return separatedX || separatedY;
		}
		
		static public function separatePlayerY(Object1:FlxObject, Object2:FlxObject):Boolean
		{
			//can't separate two immovable objects
			var obj1immovable:Boolean = Object1.immovable;
			var obj2immovable:Boolean = Object2.immovable;
			if(obj1immovable && obj2immovable)
				return false;
			
			//If one of the objects is a tilemap, just pass it off.
			if(Object1 is FlxTilemap)
				return (Object1 as FlxTilemap).overlapsWithCallback(Object2,separateY);
			if(Object2 is FlxTilemap)
				return (Object2 as FlxTilemap).overlapsWithCallback(Object1,separateY,true);

			//First, get the two object deltas
			var overlap:Number = 0;
			var obj1delta:Number = Object1.y - Object1.last.y;
			var obj2delta:Number = Object2.y - Object2.last.y;
			if(obj1delta != obj2delta)
			{
				//Check if the Y hulls actually overlap
				var obj1deltaAbs:Number = (obj1delta > 0)?obj1delta:-obj1delta;
				var obj2deltaAbs:Number = (obj2delta > 0)?obj2delta:-obj2delta;
				var obj1rect:FlxRect = new FlxRect(Object1.x,Object1.y-((obj1delta > 0)?obj1delta:0),Object1.width,Object1.height+obj1deltaAbs);
				var obj2rect:FlxRect = new FlxRect(Object2.x,Object2.y-((obj2delta > 0)?obj2delta:0),Object2.width,Object2.height+obj2deltaAbs);
				if((obj1rect.x + obj1rect.width > obj2rect.x) && (obj1rect.x < obj2rect.x + obj2rect.width) && (obj1rect.y + obj1rect.height > obj2rect.y) && (obj1rect.y < obj2rect.y + obj2rect.height))
				{
					var maxOverlap:Number = obj1deltaAbs + obj2deltaAbs + OVERLAP_BIAS;
					
					//If they did overlap (and can), figure out by how much and flip the corresponding flags
					if(obj1delta > obj2delta)
					{
						overlap = Object1.y + Object1.height - Object2.y;
						if((overlap > maxOverlap) || !(Object1.allowCollisions & DOWN) || !(Object2.allowCollisions & UP))
							overlap = 0;
						else
						{
							Object1.touching |= DOWN;
							Object2.touching |= UP;
						}
					}
					else if(obj1delta < obj2delta)
					{
						overlap = Object1.y - Object2.height - Object2.y;
						if((-overlap > maxOverlap) || !(Object1.allowCollisions & UP) || !(Object2.allowCollisions & DOWN))
							overlap = 0;
						else
						{
							Object1.touching |= UP;
							Object2.touching |= DOWN;
						}
					}
				}
			}
			
			//Then adjust their positions and velocities accordingly (if there was any overlap)
			if(overlap != 0)
			{
				var obj1v:Number = Object1.velocity.y;
				var obj2v:Number = Object2.velocity.y;
				
				if(!obj1immovable && !obj2immovable)
				{
					overlap *= 0.5;
					Object1.y = Object1.y - overlap;
					Object2.y += overlap;

					var obj1velocity:Number = Math.sqrt((obj2v * obj2v * Object2.mass)/Object1.mass) * ((obj2v > 0)?1:-1);
					var obj2velocity:Number = Math.sqrt((obj1v * obj1v * Object1.mass)/Object2.mass) * ((obj1v > 0)?1:-1);
					var average:Number = (obj1velocity + obj2velocity)*0.5;
					obj1velocity -= average;
					obj2velocity -= average;
					Object1.velocity.y = average + obj1velocity * Object1.elasticity;
					Object2.velocity.y = average + obj2velocity * Object2.elasticity;
				}
				else if(!obj1immovable)
				{
					Object1.y = Object1.y - overlap;
					Object1.velocity.y = 0;
					//Object1.velocity.y = obj2v - obj1v*Object1.elasticity;
					
					//This is special case code that handles cases like horizontal moving platforms you can ride
					if (Object2.active && Object2.moves && (obj1delta > obj2delta))
					{
						if (Object1.velocity.x == 0) Object1.x += Object2.x - Object2.last.x;
					}
				}
				else if(!obj2immovable)
				{
					Object2.y += overlap;
					Object2.velocity.y = 0;
					//Object2.velocity.y = obj1v - obj2v*Object2.elasticity;
					
					//This is special case code that handles cases like horizontal moving platforms you can ride
					if (Object1.active && Object1.moves && (obj1delta < obj2delta))
					{
						if (Object2.velocity.x == 0) Object2.x += Object1.x - Object1.last.x;
					}
				}
				return true;
			}
			else
				return false;
		}
	}

}