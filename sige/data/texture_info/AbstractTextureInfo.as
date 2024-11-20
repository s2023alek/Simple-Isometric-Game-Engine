package org.jinanoimateydragoncat.works.sige.data.texture_info {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import org.jinanoimateydragoncat.works.sige.ani.SideAnimation;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 3:32
	 */
	public class AbstractTextureInfo implements ITextureInfo {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * only one animation for all sides
		 */
		public function getAnimation():SideAnimation {
			// override and place your code here
			return animation;
		}
		
		public function setAnimation(ani:SideAnimation):void {
			// override and place your code here
			animation = ani;
		}
		
		private var animation:SideAnimation;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]