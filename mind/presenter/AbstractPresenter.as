package mind.presenter
{

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class AbstractPresenter extends EventDispatcher
	{
		public function AbstractPresenter ( target :IEventDispatcher = null )
		{
			super( target );
		}
	}
}