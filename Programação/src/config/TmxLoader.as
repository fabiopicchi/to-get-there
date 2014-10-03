package  config
{
	import com.adobe.serialization.json.JSON;
	import flash.net.FileReference;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public class TmxLoader 
	{
		private var tmxFile : XML;
		public function TmxLoader(xmlObject : String) 
		{
			tmxFile = new XML (xmlObject);
		}
		
		public function get tileWidth () : uint
		{
			return tmxFile.child("tileset").@tilewidth;
		}
		
		public function get tileHeight () :uint
		{
			return tmxFile.child("tileset").@tileheight;
		}
		
		public function getLayerWidth (layer : String) : uint
		{
			for each (var obj : XML in tmxFile.child("layer"))
			{
				if (obj.@name == layer)
					return obj.@width;
			}
			
			return null;
		}
		
		public function getLayerHeight (layer : String) : uint
		{
			for each (var obj : XML in tmxFile.child("layer"))
			{
				if (obj.@name == layer)
					return obj.@height;
			}
			
			return null;
		}
		
		public function getCollisionMap (layer : String) : String
		{
			var outPut : String = new String ();
			
			for each (var obj : XML in tmxFile.child("layer"))
			{
				if (obj.@name == layer)
				{
					var width : uint = getLayerWidth (layer);
					var height : uint = getLayerHeight (layer);
					var tileData : XMLList = obj.child ("data");
					
					for (var i : uint = 0; i < height; i++)
					{
						for (var j : uint = 0; j < width; j++)
						{
							outPut += (tileData.child("tile")[(i * width) + j].@gid) - 1;
							if (j + 1 != width) outPut += ",";
						}
						if (i + 1 != height)
							outPut += "\n";
					}	
					return outPut;				}
			}
			
			return null;
		}
		
		public function getObject (objectGroup : String, objectType : String) : Array
		{
			var arReturn : Array = [];
			var sObject : String;
			
			for each (var obj : XML in tmxFile.child("objectgroup"))
			{
				if (obj.@name == objectGroup)
				{
					for each (var elem : XML in obj.child("object"))
					{
						if (elem.@type == objectType)
						{
							sObject = new String ();
							sObject = "{ \"x\" : \"" + elem.@x + "\" , "+
										"\"y\" : \"" + elem.@y + "\" , "+
										"\"width\" : \"" + elem.@width + "\" , "+
										"\"height\" : \"" + elem.@height + "\"";
										
							for each (var prop : XML in elem.child("properties").child("property"))
							{
								sObject += " , \"" + prop.@name + "\" : \"" + prop.@value + "\"";
							}
							
							sObject += " }";
							arReturn.push(JSON.decode (sObject));
						}
					}
				}
			}
			return arReturn;
		}
	}

}