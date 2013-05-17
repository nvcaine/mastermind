package mind.model.events
{

	import flash.events.Event;

	import mind.model.vo.ColorVO;

	public class ColorEvent extends Event
	{
		static public const ADD_COLOR :String = "addColor";
		static public const SET_COLORS :String = "setColors";
		static public const UNDO_COLOR :String = "undoColor";

		public var color :ColorVO;
		public var colors :Array;

		public function ColorEvent ( type :String, ... params )
		{
			super( type );

			switch ( type )
			{
				case ADD_COLOR:
				{
					color = params[ 0 ] as ColorVO;
					break;
				}

				case SET_COLORS:
				{
					colors = params[ 0 ];
					break;
				}
			}
		}
	}
}