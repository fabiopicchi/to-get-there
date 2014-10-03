package players
{
	import assets.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class Menino extends Player 
	{
		public function Menino ()
		{
			WIDTH = 42;
			HEIGHT = 64;
			addAnimation ("IDLE", [0], 15, false);
			addAnimation ("WALKING", [1,2,3,4,5,6], 15, true);
			addAnimation ("JUMPING", [7], 15, false);
			addAnimation ("FALLING", [8], 15, false);
			facing = RIGHT;
			_config = new ControlConfig (ControlConfig.WASD);
		}
	}

}