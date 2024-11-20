package org.jinanoimateydragoncat.works.sige.data {
	
	//{ =^_^= import
	import flash.display.Stage;
	import org.jinanoimateydragoncat.works.sie.ViewPort;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 1:36
	 */
	public class GameWorld {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * @param	objectMovementStepInterval deley between "move objects" iterations(not supported yet
		 */
		function GameWorld (width:uint, height:uint, blockWidth:Number, objectMovementStepInterval:Number, stageRef:Stage) {
			this.stageRef = stageRef;
			map = new WorldMap(width, height, blockWidth, objectMovementStepInterval, stageRef);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function addObject(a:GameWorldObject):void {
			a.set_container(this);
			map.addObject(a);
		}
		
		public function removeObject(a:GameWorldObject):void {
			a.set_container(null);
			map.removeObject(a);
		}
		public function removeAllObjects():void {
			for each(var i:GameWorldObject in map.get_objects()) {
				i.set_container(null);
				map.removeObject(i);
			}
		}
		
		public function get_map():WorldMap {return map;}
		public function get_viewPort():ViewPort {return map.get_viewPort();}
		
		public function getWidth():uint {return map.getWidth();}
		public function getHeight():uint {return map.getHeight();}
		public function get_blockWidth():Number {return map.get_blockWidth();}
		
		private var stageRef:Stage;
		private var map:WorldMap;
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]