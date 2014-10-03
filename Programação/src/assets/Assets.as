package assets 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Fabio e Helo
	 */
	public final class Assets 
	{
		private static const BUTTON : String = 'interactive::Button';
		private static const LEVER : String = 'interactive::Lever';
		private static const MOVING_PLATFORM : String = 'interactive::MovingPlatform';
		private static const MENINA : String = 'players::Menina';
		private static const MENINO : String = 'players::Menino';
		
		[Embed(source = 'resources/player.png')] public static const PLAYER_ASSET: Class;
		[Embed(source = '../../../Arte/menino.png')] public static const MENINO_ASSET: Class;
		[Embed(source = '../../../Arte/menina.png')] public static const MENINA_ASSET: Class;
		[Embed(source = '../../../Arte/abraco.png')] public static const ABRACO: Class;
		[Embed(source = '../../../Arte/botao.png')] public static const BOTAO_ASSET: Class;
		[Embed(source = '../../../Arte/alavanca.png')] public static const ALAVANCA_ASSET: Class;
		[Embed(source = '../../../Arte/tiles-v4-2-tileset_final.png')] public static const TILE_MAP:Class;
		[Embed(source = '../../../Arte/divisoria.png')] public static const DIVISORIA:Class;
		[Embed(source = '../../../Arte/platmovel_2ver.png')] public static const VER2:Class;
		[Embed(source = '../../../Arte/platmovel_3ver.png')] public static const VER3:Class;
		[Embed(source = '../../../Arte/platmovel_3hor.png')] public static const HOR3:Class;
		[Embed(source = '../../../Arte/togetthere-titulo.png')] public static const MENU_SCREEN:Class;
		[Embed(source = '../../../Arte/togetthere-controls.png')] public static const CONTROLS_SCREEN:Class;
		[Embed(source = '../../../Arte/togetthere-credits.png')] public static const CREDITS_SCREEN:Class;
		[Embed(source = '../../../Arte/fundo.gif')] public static const FUNDO:Class;
		[Embed(source = '../../../Arte/botao1.png')] public static const PLAY:Class;
		[Embed(source = '../../../Arte/botao2.png')] public static const CONTROLS:Class;
		[Embed(source = '../../../Arte/botao3.png')] public static const CREDITS:Class;
		[Embed(source = '../../../Arte/theend_393_431.png')] public static const THE_END:Class;
		[Embed(source = '../../../Arte/som.png')] public static const MUSIC_ICO:Class;
		[Embed(source = '../../../Musica/ToGetThere.mp3')] public static const MAIN_THEME:Class;
		
		public function Assets() 
		{
			
		}
		
		public static function getAsset (cl : String, option : String = '') : Class
		{
			switch (cl)
			{
				case BUTTON:
					return BOTAO_ASSET;
				case LEVER:
					return ALAVANCA_ASSET;
				case MOVING_PLATFORM:
					if (option == 'v2')
						return VER2;
					else if (option == 'v3')
						return VER3;
					else if (option == 'h3')
						return HOR3;
				case MENINA:
					return MENINA_ASSET;
				case MENINO:
					return MENINO_ASSET;
				default:
					return PLAYER_ASSET;
			}
		}
		
	}

}