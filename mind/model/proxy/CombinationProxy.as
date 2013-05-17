package mind.model.proxy
{

	import mind.model.events.CombinationEvent;
	import mind.model.vo.CombinationVO;

	public class CombinationProxy extends AbstractProxy
	{
		private var _combinations :Array = [];

		// ---------------------------------------------------------------------------
		// Constructor
		// ---------------------------------------------------------------------------

		public function CombinationProxy ()
		{
			super();
		}

		// ---------------------------------------------------------------------------
		// Getters / Setters
		// ---------------------------------------------------------------------------

		public function get combinations () :Array
		{
			return _combinations.concat();
		}

		// ---------------------------------------------------------------------------
		// Public functions
		// ---------------------------------------------------------------------------

		public function addCombination ( combination :CombinationVO ) :void
		{
			_combinations.push( combination );

			dispatchEvent( new CombinationEvent( CombinationEvent.COMBINATIONS_UPDATED ));
		}

		public function clearCombinations () :void
		{
			_combinations = [];

			dispatchEvent( new CombinationEvent( CombinationEvent.COMBINATIONS_UPDATED ));
		}
	}
}