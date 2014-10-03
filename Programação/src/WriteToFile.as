package
{
	import flash.display.MovieClip;
	import flash.net.FileReference;
	import config.TmxLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class WriteToFile extends MovieClip
	{
		[Embed(source = '../../GameDesign/menino.tmx', mimeType = 'application/octet-stream')]private var tmxFile:Class;
		//[Embed(source = '../../GameDesign/menina.tmx', mimeType = 'application/octet-stream')]private var tmxFile2:Class;
		public var tmxMap : TmxLoader;
		public var tmxMap2 : TmxLoader;
		
		//Main layers
		public static const OBJECT_LAYER : String = "objetos";
		public static const TILE_MAP_LAYER : String = "tiles";
		public static const SPAWN_LAYER : String = "spawn";
		
		//Background layers
		public static const FUNDO_LAYER : String = "fundo";
		public static const NUM_FUNDOS : uint = 4;
		
		
		var myFileRefSave:FileReference = new FileReference();
		
		public function WriteToFile() 
		{
			tmxMap = new TmxLoader (new tmxFile ());
			//tmxMap2 = new TmxLoader (new tmxFile2 ());
			//var tileMap : String = juntarMapas (tmxMap.getCollisionMap(TILE_MAP_LAYER), tmxMap2.getCollisionMap(TILE_MAP_LAYER));
			myFileRefSave.save(tileMap, "fase.txt");
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