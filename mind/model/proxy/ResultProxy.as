package mind.model.proxy
{

	import mind.model.Colors;
	import mind.model.Results;
	import mind.model.events.ColorEvent;
	import mind.model.vo.ColorVO;
	import mind.model.vo.CombinationVO;
	import mind.model.vo.ResultVO;

	import mx.collections.ArrayCollection;

	public class ResultProxy extends AbstractProxy
	{
		private var _initialColorList :Array = [];

		// ---------------------------------------------------------------------------
		// Constructor
		// ---------------------------------------------------------------------------

		public function ResultProxy ()
		{
			super();
		}

		// ---------------------------------------------------------------------------
		// Public functions
		// ---------------------------------------------------------------------------

		public function setInitialCombination ( colors :ArrayCollection ) :void
		{
			_initialColorList = getInitialCombination( colors );

			dispatchEvent( new ColorEvent( ColorEvent.SET_COLORS, _initialColorList.concat()));
		}

		public function evaluateColors ( colors :ArrayCollection ) :CombinationVO
		{
			var result :CombinationVO = new CombinationVO();

			for ( var currentIndex :Number = 0; currentIndex < colors.length; currentIndex++ )
			{
				var color :ColorVO = colors.getItemAt( currentIndex ) as ColorVO;
				var evaluationResult :ResultVO = evaluateColor( color, _initialColorList, currentIndex );

				result.colors.push( color );

				if ( evaluationResult.result == Results.BLACK )
					result.results = [ evaluationResult ].concat( result.results );
				else if ( evaluationResult.result == Results.WHITE )
					result.results.push( evaluationResult );
			}

			return result;
		}

		// ---------------------------------------------------------------------------
		// Protected functions
		// ---------------------------------------------------------------------------

		protected function evaluateColor ( color :ColorVO, colors :Array, currentIndex :Number ) :ResultVO
		{
			var result :ResultVO = new ResultVO( Results.WRONG );
			var colorIndex :Number = colors.indexOf( color );

			if ( currentIndex == colorIndex )
				result.result = Results.BLACK;
			else if ( colorIndex != -1 )
				result.result = Results.WHITE;

			return result;
		}

		// ---------------------------------------------------------------------------
		// Private functions
		// ---------------------------------------------------------------------------

		private function getInitialCombination ( colors :ArrayCollection ) :Array
		{
			var result :Array = [];
			var indices :Array = [];

			for ( var i :Number = 0; i < Colors.COLOR_LENGTH; i++ )
			{
				var colorIndex :Number = getNewColorIndex( colors.length, indices );

				result.push( colors.getItemAt( colorIndex ));
				indices.push( colorIndex );
			}

			return result;
		}

		private function getNewColorIndex ( maxIndex :Number, addedIndices :Array ) :Number
		{
			var result :Number = Math.round( Math.random() * 1000 ) % maxIndex;

			while ( addedIndices.indexOf( result ) != -1 )
				result = Math.round( Math.random() * 1000 ) % maxIndex;

			return result;
		}
	}
}
