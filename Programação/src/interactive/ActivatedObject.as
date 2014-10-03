package  interactive
{
	/**
	 * ...
	 * @author fábio picchi
	 */
	public class ActivatedObject extends GameObject
	{
		internal static const members : Array = [];
		protected var _bActivated : Boolean;
		
		public function ActivatedObject ()
		{
			members.push(this);
		}
		
		internal function activate () : void
		{
			_bActivated = true;
		}
		
		internal function deactivate () : void
		{
			_bActivated = false;
		}
	}

}