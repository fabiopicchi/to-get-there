package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class ControlConfig 
	{
		
		private var _type : uint;
		public static const SETAS : uint = 1;
		public static const WASD : uint = 2;
		public static const IJKL : uint = 3;
		
		public function ControlConfig(type : uint) 
		{
			_type = type;
		}
		
		public function get leftKeyCode () : String
		{
			switch (_type)
			{
			case 1:
				return "LEFT";
			case 2:
				return "A";
			case 3:
				return "J";
			default:
				return null;
			}
		}
		
		public function get rightKeyCode () : String
		{
			switch (_type)
			{
			case 1:
				return "RIGHT";
			case 2:
				return "D";
			case 3:
				return "L";
			default:
				return null;
			}
		}
		
		public function get upKeyCode () : String
		{
			switch (_type)
			{
			case 1:
				return "UP";
			case 2:
				return "W";
			case 3:
				return "I";
			default:
				return null;
			}
		}
		
		public function get downKeyCode () : String
		{
			switch (_type)
			{
			case 1:
				return "DOWN";
			case 2:
				return "S";
			case 3:
				return "K";
			default:
				return null;
			}
		}
		
		public function isLeftPressed () : Boolean
		{
			switch (_type)
			{
			case 1:
				return FlxG.keys.LEFT;
			case 2:
				return FlxG.keys.A;
			case 3:
				return FlxG.keys.J;
			default:
				return false;
			}
		}
		
		public function isRightPressed () : Boolean
		{
			switch (_type)
			{
			case 1:
				return FlxG.keys.RIGHT;
			case 2:
				return FlxG.keys.D;
			case 3:
				return FlxG.keys.L;
			default:
				return false;
			}
		}
		
		public function isUpPressed () : Boolean
		{
			switch (_type)
			{
			case 1:
				return FlxG.keys.UP;
			case 2:
				return FlxG.keys.W;
			case 3:
				return FlxG.keys.I;
			default:
				return false;
			}
		}
		
		public function isDownPressed () : Boolean
		{
			switch (_type)
			{
			case 1:
				return FlxG.keys.DOWN;
			case 2:
				return FlxG.keys.S;
			case 3:
				return FlxG.keys.K;
			default:
				return false;
			}
		}
	}

}