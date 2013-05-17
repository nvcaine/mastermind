package mind.model.proxy
{

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class AbstractProxy extends EventDispatcher
	{
		public function AbstractProxy ( target :IEventDispatcher = null )
		{
			super( target );
		}
	}
}