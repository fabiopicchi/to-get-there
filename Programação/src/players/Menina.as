package players
{
	import assets.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class Menina extends Player 
	{
		public function Menina ()
		{
			WIDTH = 42;
			HEIGHT = 56;
			addAnimation ("IDLE", [0], 15, false);
			addAnimation ("WALKING", [1,2,3,4,5,6], 10, true);
			addAnimation ("JUMPING", [7], 10, false);
			addAnimation ("FALLING", [8], 10, false);
			facing = LEFT;
			_config = new ControlConfig (ControlConfig.SETAS);
		}
	}

}