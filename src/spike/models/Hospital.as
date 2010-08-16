package spike.models 
{
	import flash.events.EventDispatcher;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	
	import org.juicekit.animate.Tween;

	[Bindable]
	public class Hospital extends EventDispatcher implements IHospital
	{
		public var appModel:SpikeAppModel = SpikeAppModel.instance;
		public var hospitalName:String = 'Unknown';
		public var hospitalNameLowercase:String = 'unknown';
		public var score:Number = 0;
		public var relativeScore:Number = 0;
		
		public var itemRenderer:IVisualElement;
		
		
		[Bindable(event="hospitalChanged")]
		public function get selected():Boolean {
			return this.hospitalName == appModel.selectedHospitalName;
		}
		
		
		public function Hospital(hospitalName:String, score:Number, encodedScore:Number):void
		{
			this.hospitalName = hospitalName;
			this.hospitalNameLowercase = hospitalName.toLowerCase();
			this.score = score;

			ChangeWatcher.watch(appModel, 'selectedHospitalName', function():void {
				dispatchEvent(new Event('hospitalChanged'));
			}, false, true);
		}
		
		override public function toString():String {
			return this.hospitalName;
		}
	}
}