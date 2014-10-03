package interactive
{
	import flash.utils.getQualifiedClassName;
	import org.flixel.FlxSprite;
	import assets.Assets;
	/**
	 * ...
	 * @author fábio picchi
	 */
	public class GameObject extends FlxSprite
	{
		//Asset
		protected var _asset : Class;
		private var _nId : int;
		private var _spriteWidth : uint;
		private var _spriteHeight : uint;
		
		public function GameObject ()
		{
		}
		
		public function setup (objData : Object, offsetX : Number = 0, offsetY : Number = 0):void
		{
			//Load Data
			this.x 			= objData.x;
			this.y 			= objData.y;
			this._nId 		= objData.id;
			this._asset		= Assets.getAsset (getQualifiedClassName (this), objData.tipo);
			
			//Apply offset
			this.x += offsetX;
			this.y += offsetY;
			
			this.loadGraphic(_asset, true, true, _spriteWidth, _spriteHeight);
		}
		
		public function get id () : int
		{
			return _nId;
		}
		
		public function get spriteWidth():uint 
		{
			return _spriteWidth;
		}
		
		public function set spriteWidth(value:uint):void 
		{
			_spriteWidth = value;
		}
		
		public function get spriteHeight():uint 
		{
			return _spriteHeight;
		}
		
		public function set spriteHeight(value:uint):void 
		{
			_spriteHeight = value;
		}
	}

}