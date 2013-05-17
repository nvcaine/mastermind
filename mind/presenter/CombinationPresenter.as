package mind.presenter
{

	import flash.events.Event;
	
	import mind.model.Colors;
	import mind.model.Results;
	import mind.model.events.CombinationEvent;
	import mind.model.events.InterfaceEvent;
	import mind.model.proxy.CombinationProxy;
	import mind.model.vo.CombinationVO;
	import mind.model.vo.ResultVO;
	
	import mx.collections.ArrayCollection;

	[Event( name = "foundSolution", type = "mind.model.events.CombinationEvent" )]
	[ManagedEvents( "foundSolution" )]

	public class CombinationPresenter extends AbstractPresenter
	{
		[Inject]
		public var combinationProxy :CombinationProxy;

		// ---------------------------------------------------------------------------
		// Constructor
		// ---------------------------------------------------------------------------

		public function CombinationPresenter ()
		{
			super();
		}

		[Init]
		public function init () :void
		{
			combinationProxy.addEventListener( CombinationEvent.COMBINATIONS_UPDATED, combinationsUpdatedHandler );
		}

		// ---------------------------------------------------------------------------
		// Getters / Setters
		// ---------------------------------------------------------------------------

		[Bindable( event = "combinationsUpdated" )]
		public function get combinations () :ArrayCollection
		{
			var result :ArrayCollection = new ArrayCollection();

			for each ( var combination :CombinationVO in combinationProxy.combinations )
				result.addItemAt( combination, 0 );

			return result;
		}

		// ---------------------------------------------------------------------------
		// Private functions
		// ---------------------------------------------------------------------------

		private function isSolution ( combination :CombinationVO ) :Boolean
		{
			if ( combination.results.length != Colors.COLOR_LENGTH )
				return false;
			else
				for each ( var item :ResultVO in combination.results )
					if ( item.result != Results.BLACK )
						return false;

			return true;
		}

		private function solutionFound () :void
		{
			dispatchEvent( new CombinationEvent( CombinationEvent.FOUND_SOLUTION ));
		}

		private function checkLastCombination () :void
		{
			var lastCombination :CombinationVO = combinations.getItemAt( 0 ) as CombinationVO;

			if ( isSolution( lastCombination ))
				solutionFound();
		}

		// ---------------------------------------------------------------------------
		// Handlers
		// ---------------------------------------------------------------------------

		private function combinationsUpdatedHandler ( event :CombinationEvent ) :void
		{
			if ( combinations.length > 0 )
				checkLastCombination();

			// For binding
			dispatchEvent( new Event( "combinationsUpdated" ));
		}

		// ---------------------------------------------------------------------------
		// Parsley handlers
		// ---------------------------------------------------------------------------

		[MessageHandler]
		public function interfaceHandler ( event :InterfaceEvent ) :void
		{
			combinationProxy.clearCombinations();
		}
	}
}
