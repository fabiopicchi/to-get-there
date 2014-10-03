package interactive
{
	/**
	 * ...
	 * @author fábio picchi
	 */
	public class ActivationObject extends GameObject
	{
		public static const members : Array = [];

		protected var _bActive : Boolean = false;
		protected var _activatedObject : ActivatedObject;
		
		public function ActivationObject ()
		{
			members.push(this);
		}
		
		public function isActive () : Boolean
		{
			return _bActive;
		}
		
		override public function preUpdate () : void
		{
			super.update ();
			if (!_activatedObject)
			{
				getActivatedObejct();
			}
		}
		
		private function getActivatedObejct () : void
		{
			if (!_activatedObject)
			{
				for each (var obj : ActivatedObject in interactive.ActivatedObject.members)
					if (obj.id == this.id)
						_activatedObject = obj;
			}
		}
	}

}