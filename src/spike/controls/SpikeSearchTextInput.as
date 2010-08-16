package spike.controls
{
	import spike.models.SpikeAppModel;
	
	import mx.binding.utils.BindingUtils;
	
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	public class SpikeSearchTextInput extends TextInput
	{
		private var appModel:SpikeAppModel = SpikeAppModel.instance;
		
		public function SpikeSearchTextInput()
		{
			super();
			this.addEventListener(TextOperationEvent.CHANGE, function(e:TextOperationEvent):void {
				appModel.searchHospitalName = text.toLowerCase();
			});
		}
	}
}