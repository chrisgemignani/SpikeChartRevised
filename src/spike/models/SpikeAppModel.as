/*
* -*- Mode: Actionscript -*-
* *************************************************************************
* FILE IDENTIFICATION
*
* Name:          AppModel.as
* Purpose:       A singleton container for application settings. Key
*                application constants are defined here. AppModel can be
*                accessed anywhere with AppModel.instance.
* Author:        Chris Gemignani
* Date Started:  December 2009
*
* The contents of this file are Copyright (c) 2009 by Juice Analytics, Inc.
* In addition, the contents are proprietary and confidential.
*
* *************************************************************************
*/

package spike.models  {
	import flash.events.EventDispatcher;
	
	import org.juicekit.encoder.SizeEncoder;
	
	/**
	 * Stores settings for a set of Spike charts
	 */
	[Bindable]
	public class SpikeAppModel extends EventDispatcher {
		// Used to enforce the singleton.
		private static var _instance:SpikeAppModel = new SpikeAppModel(SingletonLock);
		
		public var selectedHospitalName:String = '';
		public var hoverHospitalName:String = '';
		public var searchHospitalName:String = '';

		public var singularItemName:String = 'hospital';
		public var pluralItemName:String = 'hospitals';
		
		public var SPIKEWIDTH:Number = 200;
		public var SPIKEHEIGHT:Number = 150;
		
		public var BASELINE_DOWN_COLOR:uint = 0xcc3300;
		public var BASELINE_UP_COLOR:uint = 0x00cc33;
		public var BASELINE_THICKNESS:Number = 2;
		
		public var NORMAL_TEXT_COLOR:uint = 0x333333;
		public var SELECTED_TEXT_COLOR:uint = 0xff7700;
		public var HOVERED_TEXT_COLOR:uint = 0x0066ff;

		
		/**
		 * The spike chart transition length.
		 */
		public var TRANSITION_PERIOD:Number = 1.5;
		
		public var positionEncoder:SizeEncoder = new SizeEncoder('score', 'itemRenderer.y', null, null);
		
		/**
		 * Under what conditions should hospitals be grouped
		 */
		public var joinHospitals:Function = function(a:IHospital, b:IHospital):Boolean {
			return Math.abs(a.score - b.score) < 1;
		};
		
		[Bindable('instanceChange')]
		public static function get instance():SpikeAppModel {
			return _instance;
		}
		
		/**
		 * Constructor
		 */
		public function SpikeAppModel(lock:Class) {
			if (lock != SingletonLock) {
				throw new Error("Invalid Singleton access. Use SpikeAppModel.instance");
			}
		}
		
	}
}


// A design pattern that ensures that the constructor can only be called from within this class
class SingletonLock {
}
