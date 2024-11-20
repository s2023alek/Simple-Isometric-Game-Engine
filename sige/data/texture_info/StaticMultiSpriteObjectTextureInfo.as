package org.jinanoimateydragoncat.works.sige.data.texture_info {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 09.02.2011_[17#47#39]_[3]
	 */
	public class StaticMultiSpriteObjectTextureInfo extends AbstractTextureInfo implements ITextureInfo {
		
		//{ =^_^= CONSTRUCTOR
		
		function StaticMultiSpriteObjectTextureInfo (spriteRef0:DisplayObject, spriteRef1:DisplayObject) {
			if (!spriteRef0) {throw new ArgumentError('spriteRef must be non-null');}
			if (!spriteRef1) {throw new ArgumentError('spriteRef must be non-null');}
			this.spriteRef0 = spriteRef0;
			this.spriteRef1 = spriteRef1;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function get_spriteRef0():DisplayObject {return spriteRef0;}
		public function get_spriteRef1():DisplayObject {return spriteRef1;}
		
		private var spriteRef0:DisplayObject;
		private var spriteRef1:DisplayObject;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]