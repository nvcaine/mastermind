package mind.model.proxy
{

	import mind.model.Colors;

	import mx.collections.ArrayCollection;

	public class ColorProxy extends AbstractProxy
	{
		private var _colors :ArrayCollection = new ArrayCollection( Colors.colors );

		// ---------------------------------------------------------------------------
		// Constructor
		// ---------------------------------------------------------------------------

		public function ColorProxy ()
		{
		}

		// ---------------------------------------------------------------------------
		// Getters / Setters
		// ---------------------------------------------------------------------------

		public function get colors () :ArrayCollection
		{
			return _colors;
		}
	}
}