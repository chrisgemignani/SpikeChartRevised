package spike.models 
{
	import mx.core.IVisualElement;

	public interface IHospital
	{
		
		function get itemRenderer():IVisualElement;
		function set itemRenderer(u:IVisualElement):void;
		
		function get hospitalName():String;
		function get score():Number;
		// score relative to a percentile
		function get relativeScore():Number;
		function set relativeScore(v:Number):void;
	}
}