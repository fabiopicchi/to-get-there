package 
{
	import config.TmxLoader;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	[SWF(width="960", height="512", backgroundColor="#000000")]
	[Frame(factoryClass = "PreLoader")]
	
	
	/**
	 * ...
	 * @author Fabio e Helo
	 */

	public class Jogo extends FlxGame 
	{
		[Embed(source = '../../GameDesign/menino.tmx', mimeType = 'application/octet-stream')]private var tmxFile:Class;
		[Embed(source = '../../GameDesign/menina.tmx', mimeType = 'application/octet-stream')]private var tmxFile2:Class;
		[Embed(source = '../../GameDesign/fase.txt', mimeType = 'application/octet-stream')]public static var fase:Class;
		[Embed(source = '../../GameDesign/fundo1.txt', mimeType = 'application/octet-stream')]private static var fundo1:Class;
		[Embed(source = '../../GameDesign/fundo2.txt', mimeType = 'application/octet-stream')]private static var fundo2:Class;
		[Embed(source = '../../GameDesign/fundo3.txt', mimeType = 'application/octet-stream')]private static var fundo3:Class;
		[Embed(source = '../../GameDesign/fundo4.txt', mimeType = 'application/octet-stream')]private static var fundo4:Class;
		
		public var tmxMap : TmxLoader;
		public var tmxMap2 : TmxLoader;
		public var focusScreen : Sprite;
		private static var jogoInstance : Jogo;
		
		//World properties
		public static const TILE_WIDTH : uint = 32;
		public static const TILE_HEIGHT : uint = 32;
		
		//Main layers
		public static const OBJECT_LAYER : String = "objetos";
		public static const TILE_MAP_LAYER : String = "tiles";
		public static const SPAWN_LAYER : String = "spawn";
		
		//Background layers
		public static const FUNDO_LAYER : String = "fundo";
		public static const NUM_FUNDOS : uint = 4;
		public static const AR_SCROLL : Array = [0, 1.0, 1.0, 0.625, 0.25];
		public static const AR_FUNDOS : Array = [0, fundo1, fundo2, fundo3, fundo4];

		public function Jogo ()
		{
			tmxMap = new TmxLoader (new tmxFile ());
			tmxMap2 = new TmxLoader (new tmxFile2 ());
			
			super(960, 512, MenuState);
			
			jogoInstance = this;	
			
			focusScreen = _focus;
		}
		
		public static function getInstance () : Jogo
		{
			return jogoInstance;
		}
		
		public function pause () : void
		{
			_focus.visible = true;
			FlxG.pauseSounds();
		}
		
		public function resume () : void
		{
			_focus.visible = false;
			FlxG.resumeSounds();
		}
		
		override protected function onFocus(FlashEvent:Event = null):void 
		{
			super.onFocus(FlashEvent);
			
			if (FlxG.paused) _focus.visible = true;
		}
	}
	
}