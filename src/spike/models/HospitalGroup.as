package spike.models 
{
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.core.IVisualElement;
	import mx.events.CollectionEvent;
	
	import org.juicekit.animate.Tween;
	import org.juicekit.util.Sort;
	import org.juicekit.util.Strings;
	
	/**
	 * A container for holding a collection of Hospitals 
	 */
	[Bindable]
	public class HospitalGroup implements IHospital
	{
		public var appModel:SpikeAppModel = SpikeAppModel.instance;

		public var itemRenderer:IVisualElement;
		
		public function set hospitalName(s:String):void {
		}
		
		public function get hospitalName():String {
			return toString();
		}
		
		/**
		 * Does a hospital with name `s` exist
		 */
		public function hospitalsContain(s:String):Boolean {
			for each (var h:Hospital in hospitals) {
				if (h.hospitalName == s) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Does any of the hospitals hospitalMames match the substring s
		 */
		public function hospitalsMatch(s:String):Boolean {
			for each (var h:Hospital in hospitals) {
				if (h.hospitalNameLowercase.indexOf(s) != -1) {
					return true;
				}
			}
			return false;
		}
		
		public function sortHospitals():void {
			//var cmp:Function = 
			var sort:mx.collections.Sort = new mx.collections.Sort();
			sort.compareFunction = org.juicekit.util.Sort.$('-score');
			sort.fields = null;
			hospitals.sort = sort;
			hospitals.refresh();
			dispatchEvent(new Event('hospitalChanged'));			
		}
		
		
		/**
		 * A collection of hospitals in a group
		 */
		public var hospitals:ArrayCollection = new ArrayCollection();

		/**
		 * Get average score of hositals
		 */
		public function get score():Number {
			var ttl:Number = 0;
			for each (var sd:Hospital in hospitals) {
				ttl += sd.score;
			}
			return ttl / this.hospitals.length;
		}
		/**
		 * Get average relative score of hositals
		 */
		public function get relativeScore():Number {
			var ttl:Number = 0;
			for each (var sd:Hospital in hospitals) {
				ttl += sd.relativeScore;
			}
			return ttl / this.hospitals.length;
		}
		public function set relativeScore(v:Number):void {			
		}
		

		[Bindable(event="hospitalChanged")]
		public function get selected():Boolean {
			for each (var h:Hospital in hospitals) {
				if (h.selected) return true
			}
			return false;
		}
				
		[Bindable(event="hospitalChanged")]
		public function toString():String {
			if (selected) {
				return Strings.format("{0} +{1} more", appModel.selectedHospitalName, this.hospitals.length-1);
			} else {
				if (this.hospitals.length == 1) {
					return Strings.format("{0}", (this.hospitals[0] as IHospital).hospitalName);
				} else {
					return Strings.format("{0} {1}", this.hospitals.length, appModel.pluralItemName);
				}
			}
		}
		
		public function changeHospitals():void {
			dispatchEvent(new Event('hospitalChanged'));			
		}
				
		public function HospitalGroup(hospitalArray:Array=null):void
		{
			this.hospitals.source = hospitalArray;
			ChangeWatcher.watch(appModel, 'selectedHospitalName', function():void {
				dispatchEvent(new Event('hospitalChanged'));
			}, false, true);
		}
		
	}
}