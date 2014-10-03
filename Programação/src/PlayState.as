package  
{
	// imports - Flixel
	import assets.Assets;
	import com.adobe.utils.ArrayUtil;
	import config.TmxLoader;
	import flash.net.FileReference;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	import interactive.Button;
	import interactive.Lever;
	import interactive.MovingPlatform;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTilemapBuffer;
	import players.Menina;
	import players.Menino;
	import players.Player;
	
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class PlayState extends FlxState
	{
		public var _playerCollisionGroup:FlxGroup = new FlxGroup();
		private var _arTmxObjects : Array = [ { type : Button, id : "botao", layer : Jogo.OBJECT_LAYER },
												{type : Lever, id : "alavanca", layer : Jogo.OBJECT_LAYER },
												{type : MovingPlatform, id : "plataforma", layer : Jogo.OBJECT_LAYER }];
		public var _menina : Menina;
		public var _menino : Menino;
		public var _collisionMap : FlxTilemap = new FlxTilemap();
		public var _camMenina : FlxCamera;
		public var _camMenino : FlxCamera;
		public var _bSingleCamera : Boolean = false;
		public var divisoria : FlxSprite;
		public var music : FlxSound = new FlxSound ();
		//public var musicIco : FlxSprite;
		//private var bMusic : Boolean = true;
		//private var pauseGroup : FlxGroup = new FlxGroup ();
		
		private static var _instance : PlayState;
		
		public function PlayState () {
			_instance = this;
		}
		
		public static function getInstance () : PlayState
		{
			return _instance;
		}
				
		override public function create():void 
		{			
			//FlxG.visualDebug = true;
			//Inicialização da aplicação (configura ambiente)
			//FlxG.framerate = 30
			
			//FlxG.mouse.hide();
			//Mouse.hide();
			setBG ();
			
			//Instancia menino
			_menino = new Menino ();
			_menino.setup (Jogo.getInstance().tmxMap.getObject(Jogo.SPAWN_LAYER, "spawnpoint_menino")[0], offsetX);
			add (_menino);
			loadMap (Jogo.getInstance().tmxMap, _arTmxObjects);
			
			//Offset para todos os elementos do mapa da menina
			var offsetX : uint = Jogo.getInstance().tmxMap.getLayerWidth ("tiles") * Jogo.TILE_WIDTH;
			
			//Instancia menina
			_menina = new Menina ();
			_menina.setup (Jogo.getInstance().tmxMap2.getObject(Jogo.SPAWN_LAYER, "spawnpoint_menina")[0], offsetX);
			add(_menina);
			loadMap (Jogo.getInstance().tmxMap2, _arTmxObjects, offsetX);
			
			var tileMap : String = new Jogo.fase ();
			
			if (tileMap)
			{
				_collisionMap.loadMap(tileMap, Assets.TILE_MAP, Jogo.TILE_WIDTH, Jogo.TILE_HEIGHT);
				add(_collisionMap);
			}
			FlxG.worldBounds = new FlxRect(0, 0, _collisionMap.width, _collisionMap.height);
			setCamera (_menino, _menina, _collisionMap);
			setHUD ();
			
			music.loadEmbedded (Assets.MAIN_THEME, true);
			music.fadeIn (2);
			
			//A ORDEM IMPORTA - A COLISAO COM O MAPA DEVE SER FEITA POR ULTIMO
			_playerCollisionGroup.add (MovingPlatform.movingPlatforms);
			_playerCollisionGroup.add (_collisionMap);
			
			//musicIco = new FlxSprite (0, 0);
			//musicIco.loadGraphic (Assets.MUSIC_ICO, true, false, 17, 15);
			//musicIco.x = FlxG.stage.stageWidth - musicIco.width - 15;
			//musicIco.y = 15;
			//musicIco.velocity = _menina.velocity;
			//musicIco.addAnimation ('OFF', [0, 1], 100, false);
			//musicIco.addAnimation ('ON', [1, 0], 100, false);
			//pauseGroup.add (musicIco);
		}
		
		private function setBG():void 
		{
			var tileMap : String;
			var bgTileMap : FlxTilemap;
			//FlxG.bgColor = 0xFF6BC3C6;
			var fundo : FlxSprite = new FlxSprite ();
			fundo.loadGraphic (Assets.FUNDO);
			fundo.scrollFactor = new FlxPoint (0, 0);
			add (fundo);
			
			for (var i : uint = Jogo.NUM_FUNDOS; i > 0; i--)
			{
				tileMap = new Jogo.AR_FUNDOS[i] ();
				bgTileMap = new FlxTilemap ();
				bgTileMap.loadMap (tileMap, Assets.TILE_MAP, Jogo.TILE_WIDTH, Jogo.TILE_HEIGHT);
				add(bgTileMap);
				bgTileMap.scrollFactor = new FlxPoint (Jogo.AR_SCROLL[i], 0);
				bgTileMap.solid = false;
			}
		}
		
		private function setCamera (_menino : Menino, _menina : Menina, _collisionMap : FlxTilemap) : void
		{
			//Set camera
			_camMenino = new FlxCamera (0, 0, FlxG.stage.stageWidth / 2, FlxG.stage.stageHeight);
			_camMenino.follow (_menino);
			_camMenino.setBounds (0, 0, _collisionMap.width, _collisionMap.height);
			FlxG.addCamera (_camMenino);
			
			_camMenina = new FlxCamera(FlxG.stage.stageWidth / 2, 0, FlxG.stage.stageWidth / 2, FlxG.stage.stageHeight); // we put the first one in the top left corner
			_camMenina.follow(_menina);
			_camMenina.setBounds(0,0,_collisionMap.width, _collisionMap.height);
			FlxG.addCamera(_camMenina);	
		}
		
		private function setHUD () : void
		{
			//divisoria = new FlxSprite ();
			//divisoria.loadGraphic (Assets.DIVISORIA);
			//divisoria.scrollFactor = new FlxPoint (0, 0);
			//divisoria.x = FlxG.stage.stageWidth / 2 - Jogo.TILE_WIDTH / 2;
			//divisoria.y = 0;
			//add (divisoria);
		}
		
		override public function update():void 
		{
			//Pause
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.paused = !FlxG.paused;
			}
			
			if (FlxG.paused)
			{
				Jogo.getInstance().pause();
				return;
			}
			else
			{
				Jogo.getInstance().resume();
			}
			
			music.update ();
			super.update();
			
			//Teste para tirar o controle dos dois personagens (somente quando eles tiverem atravessado as portas
			if (_menina.x <= 6611.2 &&
					_menino.x >= 6134.4)
			{
				_menina._bNoControl = true;
				_menino._bNoControl = true;
				_camMenina.follow (null);
				_camMenino.follow (null);
				_bSingleCamera = true;
			}
			
			if (_menina.x <= 6611.2)
			{
				_camMenina.follow (null);
			}
			else if (!_bSingleCamera)
			{
				_camMenina.follow (_menina);
			}
			
			if (_menino.x >= 6134.4)
			{
				_camMenino.follow (null);
			}
			else if (!_bSingleCamera)
			{
				_camMenino.follow (_menino);
			}
			
			//Reajuste da câmera
			//if (_menina._bNoControl && _menino._bNoControl && !_bSingleCamera && (_menina.x + _menina.width) - _menino.x < FlxG.stage.stageWidth / 2)
			//{
				//_bSingleCamera = true;
				//FlxG.removeCamera (_camMenina, false);
				//FlxG.removeCamera (_camMenino, false);
				//
				//var cam : FlxCamera = new FlxCamera (0, 0, FlxG.stage.stageWidth, FlxG.stage.stageHeight);
				//cam.setBounds (0, 0, _collisionMap.width, _collisionMap.height);
				//FlxG.addCamera(cam);
				//cam.focusOn (new FlxPoint (_collisionMap.width / 2 - Jogo.TILE_WIDTH, _collisionMap.height / 2));
				//remove (divisoria);
			//}
			
			//collides everything against everything - mover para dentro das respectivas classes
			FlxG.collide (_menina, _menino, function (obj1 : FlxObject, obj2 : FlxObject) : void
			{
				remove (obj1);
				remove (obj2);
				var spr : FlxSprite;
				if (obj1 is Menino)
					spr = new FlxSprite (obj1.x, obj1.y - 14);
				else
					spr = new FlxSprite (obj2.x, obj2.y - 14);
				spr.loadGraphic (Assets.ABRACO, true, false, 52, 64, true);
				spr.addAnimation ('ABRACO', [0, 1, 2, 3], 10, false);
				add (spr);
				spr.play ('ABRACO');
				
				setTimeout(function () : void { 
					var theEnd : FlxSprite = new FlxSprite (0, 0, Assets.THE_END);
					theEnd.x = _collisionMap.width / 2 - theEnd.width / 2.0 - 24;
					theEnd.y = 30;
					add (theEnd); } , 3000);
				
				music.fadeOut(2);
			});
			FlxG.overlap (_menina, _playerCollisionGroup, function (obj1 : FlxObject, obj2 : FlxObject) : void
			{
				if (obj1 is Menina && obj2 is MovingPlatform)
				{
					(obj1 as Menina).touchingPlatform = (obj2 as MovingPlatform);
				}
				else if (obj2 is Menina && obj1 is MovingPlatform)
				{
					(obj2 as Menina).touchingPlatform = (obj1 as MovingPlatform);
				}
			}, Player.separatePlayer);
			
			//collides everything against everything - mover para dentro das respectivas classes
			FlxG.overlap (_menino, _playerCollisionGroup, function (obj1 : FlxObject, obj2 : FlxObject) : void
			{
				if (obj1 is Menino && obj2 is MovingPlatform)
				{
					(obj1 as Menino).touchingPlatform = (obj2 as MovingPlatform);
				}
				else if (obj2 is Menino && obj1 is MovingPlatform)
				{
					(obj2 as Menino).touchingPlatform = (obj1 as MovingPlatform);
				}
			}, Player.separatePlayer);
		}
		
		override public function draw():void 
		{	
			super.draw();
		}
		
		
		/*
		 * Loads objects from a Tiled Editor map
		 * @map : tmx file loaded into a TmxLoader object
		 * @arObject : array containing the classes (@class attribute) 
		 * 				and how they are identified in the tmx file (@id attribute)
		 * @offsetX : an offset applied to the x coordinate of the object on the map
		 * @offsetY : an offset applied to the y coordinate of the object on the map
		 */ 
		private function loadMap (map : TmxLoader, arObjects : Array, offsetX : Number = 0, offsetY : Number = 0) : void
		{
			for each (var obj : Object in arObjects)
			{
				loadObjects (obj.type, obj.id, map, obj.layer, offsetX, offsetY);
			}
		}
		
		/*
		 * Loads a certain class of objects from a Tiled Editor map
		 * @cl : AS3 class of the objects to be loaded
		 * @id : String that represent them in the tmx file
		 * @map : tmx file loaded into a TmxLoader object
		 * @layer : tmx layer in which the objects are found
		 * @offsetX : apply an offset to the x coordinate of all the objects to be loaded
		 * @offsetY : apply an offset to the y coordinate of all the objects to be loaded
		 */ 
		private function loadObjects (cl : Class, id : String, map : TmxLoader, layer : String, offsetX : Number = 0, offsetY : Number = 0) : void
		{
			var object : FlxSprite;
			for each (var objData : Object in map.getObject (Jogo.OBJECT_LAYER, id))
			{
				object = new cl ();
				(object as cl).setup (objData, offsetX, offsetY);
				add (object);
			}
		}
		
		private function juntarMapas (meninoMap : String, meninaMap : String) : String
		{	
			var strReturn : String = new String ();
			
			var arMenino : Array = meninoMap.split ('\n');
			var arMenina : Array = meninaMap.split ('\n');
			
			for (var i : uint = 0; i < arMenino.length; i++)
			{
				strReturn += arMenino[i] + "," + arMenina[i] + "\n";
			}
			
			return strReturn;
		}
	}
}