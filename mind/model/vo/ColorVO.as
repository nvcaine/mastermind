package mind.model.vo
{

	[Bindable]
	public class ColorVO
	{
		public var name :String;

		public var color :Number;

		public function ColorVO ( name :String = "", color :Number = 0x000000 )
		{
			this.name = name;
			this.color = color;
		}
	}
}