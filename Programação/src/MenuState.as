package  
{
	import assets.Assets;
	import flash.ui.Mouse;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class MenuState extends FlxState
	{
		private var _credits : FlxObject = new FlxObject (383, 348, 163, 64);
		private var _controls : FlxObject = new FlxObject (383, 275, 163, 64);
		private var _play : FlxObject = new FlxObject (383, 202, 163, 64);
		private var _playPressed : FlxSprite = new FlxSprite (383, 202, Assets.PLAY);
		private var _creditsPressed : FlxSprite = new FlxSprite (383, 348, Assets.CREDITS);
		private var _controlsPressed : FlxSprite = new FlxSprite (383, 275, Assets.CONTROLS);
		
		private var _menuScreen : FlxSprite = new FlxSprite (0, 0, Assets.MENU_SCREEN);
		private var _controlsScreen : FlxSprite = new FlxSprite (0, 0, Assets.CONTROLS_SCREEN);
		private var _bControls : Boolean = false;
		private var _creditsScreen : FlxSprite = new FlxSprite (0, 0, Assets.CREDITS_SCREEN);
		private var _bCredits : Boolean = false;
		
		private var _bPlaySelected : Boolean = false;
		private var _bControlsSelected : Boolean = false;
		private var _bCreditsSelected : Boolean = false;
		
		private var _pMouseX : Number;
		private var _pMouseY : Number;
		
		//private const textBoxWidth:uint = 200;
		override public function create():void 
		{
			add (_credits);
			add (_controls);
			add (_play);
			add (_menuScreen);
			
			FlxG.mouse.show();
			Mouse.hide();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.justPressed('DOWN'))
			{
				if (_bPlaySelected)
				{
					_bPlaySelected = false;
					_bControlsSelected = true;
				}
				else if (_bControlsSelected)
				{
					_bControlsSelected = false;
					_bCreditsSelected = true;
				}
				else if (_bCreditsSelected)
				{
					_bCreditsSelected = false;
					_bPlaySelected = true;
				}
				else
				{
					_bPlaySelected = true;
				}
			}
			
			if (FlxG.keys.justPressed('UP'))
			{
				if (_bPlaySelected)
				{
					_bPlaySelected = false;
					_bCreditsSelected = true;
				}
				else if (_bControlsSelected)
				{
					_bControlsSelected = false;
					_bPlaySelected = true;
				}
				else if (_bCreditsSelected)
				{
					_bCreditsSelected = false;
					_bControlsSelected = true;
				}
				else
				{
					_bCreditsSelected = true;
				}
			}
			
			var mousePoint : FlxPoint = new FlxPoint (FlxG.mouse.x, FlxG.mouse.y);
			if (FlxG.mouse.x != _pMouseX && FlxG.mouse.y != _pMouseY)
			{
				if (_credits.overlapsPoint(mousePoint) && !_bControls && !_bCredits)
				{
					_bCreditsSelected = true;
					_bControlsSelected = false;
					_bPlaySelected = false;
				}
				else if (_controls.overlapsPoint(mousePoint) && !_bControls && !_bCredits)
				{
					_bCreditsSelected = false;
					_bControlsSelected = true;
					_bPlaySelected = false;
				}
				else if (_play.overlapsPoint(mousePoint) && !_bControls && !_bCredits)
				{
					_bCreditsSelected = false;
					_bControlsSelected = false;
					_bPlaySelected = true;
				}
			}
			
			if (!_bControls && !_bCredits)
			{
				if (_bPlaySelected)
					playSelected();
				else if (_bControlsSelected)
					controlsSelected();
				else if (_bCreditsSelected)
					creditsSelected();
			}
			
			if (FlxG.mouse.justPressed())
			{
				if (_credits.overlapsPoint(mousePoint) && !_bControls && !_bCredits)
				{
					showCredits();
				}
				else if (_controls.overlapsPoint(mousePoint) && !_bControls && !_bCredits)
				{
					showControls();
				}
				else if (_play.overlapsPoint(mousePoint) && !_bControls && !_bCredits)
				{
					FlxG.switchState(new PlayState ());
				}
				else
				{
					backToMainMenu();
				}
			}
			
			if (FlxG.keys.justPressed('ENTER'))
			{
				if (_bCreditsSelected && !_bControls && !_bCredits)
					showCredits();
				else if (_bControlsSelected && !_bControls && !_bCredits)
					showControls();
				else if (_bPlaySelected && !_bControls && !_bCredits)
					FlxG.switchState(new PlayState ());
				else
					backToMainMenu();
			}
			
			_pMouseX = FlxG.mouse.x;
			_pMouseY = FlxG.mouse.y;
		}
		
		private function showCredits():void 
		{
			add (_creditsScreen);
			remove (_playPressed);
			remove (_creditsPressed);
			remove (_controlsPressed);
			_bCredits = true;
		}
		
		private function showControls():void 
		{
			add (_controlsScreen);
			remove (_playPressed);
			remove (_creditsPressed);
			remove (_controlsPressed);
			_bControls = true;
		}
		
		private function creditsSelected():void 
		{
			add(_creditsPressed);
			remove (_playPressed);
			remove (_controlsPressed);
		}
		
		private function controlsSelected():void 
		{
			add(_controlsPressed);
			remove (_playPressed);
			remove (_creditsPressed);
		}
		
		private function playSelected():void 
		{
			add(_playPressed);
			remove (_creditsPressed);
			remove (_controlsPressed);
		}
		
		private function noneSelected():void 
		{
			remove (_playPressed);
			remove (_creditsPressed);
			remove (_controlsPressed);
		}
		
		private function backToMainMenu():void 
		{
			remove (_controlsScreen);
			remove (_creditsScreen);
			_bControls = false;
			_bCredits = false;
		}
		
	}

}