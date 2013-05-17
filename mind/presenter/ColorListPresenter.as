package mind.presenter
{

	import flash.events.Event;

	import mind.model.Colors;
	import mind.model.events.ColorEvent;
	import mind.model.events.InterfaceEvent;
	import mind.model.proxy.CombinationProxy;
	import mind.model.proxy.ResultProxy;
	import mind.model.vo.ColorVO;
	import mind.model.vo.CombinationVO;

	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;

	[Bindable]
	public class ColorListPresenter extends AbstractPresenter
	{
		[Inject]
		public var resultProxy :ResultProxy;

		[Inject]
		public var combinationProxy :CombinationProxy;

		private var _currentColors :ArrayCollection = new ArrayCollection();

		// ---------------------------------------------------------------------------
		// Constructor
		// ---------------------------------------------------------------------------

		public function ColorListPresenter ()
		{
			super();
		}

		[Init]
		public function init () :void
		{
			currentColors.addEventListener( CollectionEvent.COLLECTION_CHANGE, updateCurrentColorsHandler );
		}

		// ---------------------------------------------------------------------------
		// Getters / Setters
		// ---------------------------------------------------------------------------

		[Bindable( event = "updateCurrentColors" )]
		public function get currentColors () :ArrayCollection
		{
			return _currentColors;
		}

		public function set currentColors ( value :ArrayCollection ) :void
		{
			_currentColors = value;
		}

		// ---------------------------------------------------------------------------
		// Private functions
		// ---------------------------------------------------------------------------

		private function handleColorEvent ( event :ColorEvent ) :void
		{
			switch ( event.type )
			{
				case ColorEvent.ADD_COLOR:
				{
					addColor( event.color );
					break;
				}

				case ColorEvent.UNDO_COLOR:
				{
					undoColor();
					break;
				}
			}
		}

		private function addColor ( color :ColorVO ) :void
		{
			if ( isUnique( color ))
				currentColors.addItem( color );

			// For binding
			dispatchEvent( new Event( "updateCurrentColors" ));
		}

		private function undoColor () :void
		{
			if ( currentColors.length > 0 )
			{
				currentColors.removeItemAt( currentColors.length - 1 );

				// For binding
				dispatchEvent( new Event( "updateCurrentColors" ));
			}
		}

		private function clearCurrentColors () :void
		{
			currentColors.removeAll();

			// For binding
			dispatchEvent( new Event( "updateCurrentColors" ));
		}

		private function isUnique ( currentColor :ColorVO ) :Boolean
		{
			for each ( var color :ColorVO in currentColors )
				if ( color.name == currentColor.name )
					return false;

			return true;
		}

		// ---------------------------------------------------------------------------
		// Handlers
		// ---------------------------------------------------------------------------

		private function updateCurrentColorsHandler ( event :CollectionEvent ) :void
		{
			if ( currentColors.length == Colors.COLOR_LENGTH )
			{
				var combination :CombinationVO = resultProxy.evaluateColors( currentColors );

				combinationProxy.addCombination( combination );
				clearCurrentColors();
			}
		}

		// ---------------------------------------------------------------------------
		// Parsley handlers
		// ---------------------------------------------------------------------------

		[MessageHandler]
		public function colorHandler ( event :ColorEvent ) :void
		{
			handleColorEvent( event );
		}

		[MessageHandler]
		public function interfaceHandler ( event :InterfaceEvent ) :void
		{
			currentColors.removeAll();
		}
	}
}