package org.jinanoimateydragoncat.works.sige.data.texture_info {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.sige.ani.SideAnimation;
	//} =^_^= END OF import
	
	
	/**
	 * @usage considered as marker
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 3:49
	 */
	public interface ITextureInfo {
		
		function getAnimation():SideAnimation;
		function setAnimation(ani:SideAnimation):void;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 15.07.2011_20#09#41 + ani
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]