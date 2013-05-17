package mind.presenter
{

	import flash.events.EventDispatcher;

	[Bindable]
	public class PopupsPresenter extends EventDispatcher
	{

		public var showHelpPopup :Boolean = false;

		public function PopupsPresenter ()
		{
		}

		[MessageHandler( selector = "showHelpPopup" )]
		public function showHelpPopupHandler () :void
		{
			showHelpPopup = true;
		}
	}

}
