package mind.presenter
{

	import flash.events.Event;

	import mind.model.events.ColorEvent;
	import mind.model.events.InterfaceEvent;
	import mind.model.proxy.ColorProxy;
	import mind.model.proxy.ResultProxy;
	import mind.model.vo.ColorVO;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	[Event( name = "addColor", type = "mind.model.events.ColorEvent" )]
	[Event( name = "undoColor", type = "mind.model.events.ColorEvent" )]
	[Event( name = "startNewGame", type = "mind.model.events.InterfaceEvent" )]
	[Event( name = "showHelpPopup", type = "flash.events.Event" )]
	[ManagedEvents( "addColor,undoColor,startNewGame,showHelpPopup" )]

	[Bindable]
	public class PaletterPresenter extends AbstractPresenter
	{
		[Inject]
		public var colorProxy :ColorProxy;

		[Inject]
		public var resultProxy :ResultProxy;

		public var initialColors :ArrayCollection = new ArrayCollection();

		private var _solutionVisible :Boolean = false;

		// ---------------------------------------------------------------------------
		// Constructor
		// ---------------------------------------------------------------------------

		public function PaletterPresenter ()
		{
			super();
		}

		[Init]
		public function init () :void
		{
			resultProxy.addEventListener( ColorEvent.SET_COLORS, setColorsHandler );
			getNewColorCombination();
		}

		// ---------------------------------------------------------------------------
		// Getters / Setters
		// ---------------------------------------------------------------------------

		public function get colors () :ArrayCollection
		{
			return colorProxy.colors;
		}

		[Bindable( event = "updateSolutionAvaiable" )]
		public function get solutionAvailable () :Boolean
		{
			return _solutionVisible;
		}

		public function set solutionAvailable ( value :Boolean ) :void
		{
			_solutionVisible = value;

			// For binding
			dispatchEvent( new Event( "updateSolutionAvaiable" ));
		}

		// ---------------------------------------------------------------------------
		// Public functions
		// ---------------------------------------------------------------------------

		public function addColor ( color :ColorVO ) :void
		{
			dispatchEvent( new ColorEvent( ColorEvent.ADD_COLOR, color ));
		}

		public function startNewGame () :void
		{
			getNewColorCombination();
			solutionAvailable = false;
			dispatchEvent( new InterfaceEvent( InterfaceEvent.START_NEW_GAME ));
		}

		public function undoColor () :void
		{
			dispatchEvent( new ColorEvent( ColorEvent.UNDO_COLOR ));
		}

		public function showHelp () :void
		{
			dispatchEvent( new Event( "showHelpPopup" ));
		}

		// ---------------------------------------------------------------------------
		// Private methods
		// ---------------------------------------------------------------------------

		private function getNewColorCombination () :void
		{
			resultProxy.setInitialCombination( colorProxy.colors );
		}

		private function setColorsHandler ( event :ColorEvent ) :void
		{
			initialColors = new ArrayCollection( event.colors );
		}

		private function alertCloseHandler ( event :CloseEvent ) :void
		{
			if ( event.detail == Alert.YES )
				startNewGame();
		}


		[MessageHandler( selector = "foundSolution" )]
		public function foundSolutionHandler () :void
		{
			solutionAvailable = true;
			Alert.show( "You have solved the puzzle!\nWould you like start a new game?", "Congratulations!", Alert.YES | Alert.NO, null, alertCloseHandler );
		}
	}
}
