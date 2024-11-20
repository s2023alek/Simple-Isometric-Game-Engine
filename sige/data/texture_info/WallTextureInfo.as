package org.jinanoimateydragoncat.works.sige.data.texture_info {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 7:46
	 */
	public class WallTextureInfo extends AbstractTextureInfo implements ITextureInfo {
		
		//{ =^_^= CONSTRUCTOR
		
		function WallTextureInfo (spriteRef:DisplayObject) {
			if (!spriteRef) {throw new ArgumentError('spriteRef must be non-null');}
			this.spriteRef = spriteRef;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function get_spriteRef():DisplayObject {return spriteRef;}
		
		private var spriteRef:DisplayObject;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]