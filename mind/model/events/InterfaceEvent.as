package mind.model.events
{

	import flash.events.Event;

	public class InterfaceEvent extends Event
	{
		static public const START_NEW_GAME :String = "startNewGame";

		public function InterfaceEvent ( type :String )
		{
			super( type );
		}
	}
}