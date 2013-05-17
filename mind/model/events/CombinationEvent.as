package mind.model.events
{

	import flash.events.Event;

	public class CombinationEvent extends Event
	{
		static public const COMBINATIONS_UPDATED :String = "combinationsUpdated";
		static public const FOUND_SOLUTION :String = "foundSolution";

		public var combinations :Array = [];

		public function CombinationEvent ( type :String, combinations :Array = null )
		{
			super( type );

			if ( combinations != null )
				this.combinations = combinations;
		}
	}
}
