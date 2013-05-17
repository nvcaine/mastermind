package mind.model.vo
{

	import mx.collections.ArrayCollection;

	public class CombinationVO
	{
		public var colors :Array = [];
		public var results :Array = [];

		public function CombinationVO ()
		{
		}

		// TODO: Think of a better solution for using array collections
		public function getColors () :ArrayCollection
		{
			return new ArrayCollection( colors );
		}

		public function getResults () :ArrayCollection
		{
			return new ArrayCollection( results );
		}
	}
}