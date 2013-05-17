package mind.model
{

	import mind.model.vo.ColorVO;

	public class Colors
	{
		static public const COLOR_LENGTH :Number = 4;

		static private var _colors :Array = [ new ColorVO( "red", 0xFF0000 ),
			new ColorVO( "green", 0x00FF00 ),
			new ColorVO( "blue", 0x0000FF ),
			new ColorVO( "yellow", 0xFFFF00 ),
			new ColorVO( "purple", 0xCC00CC ),
			new ColorVO( "cyan", 0xAABBFF )];

		public function Colors ()
		{
		}

		/**
		 *
		 * @return a copy of the array containing all the colors
		 */
		static public function get colors () :Array
		{
			return _colors.concat();
		}
	}
}
