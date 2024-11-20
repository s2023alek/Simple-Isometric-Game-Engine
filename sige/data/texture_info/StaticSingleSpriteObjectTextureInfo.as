package org.jinanoimateydragoncat.works.sige.data.texture_info {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 8:07
	 */
	public class StaticSingleSpriteObjectTextureInfo extends AbstractTextureInfo implements ITextureInfo {
		
		//{ =^_^= CONSTRUCTOR
		
		function StaticSingleSpriteObjectTextureInfo (spriteRef:DisplayObject) {
			if (!spriteRef) {throw new ArgumentError('spriteRef must be non-null');}
			var containerSprite:Sprite = new Sprite();
			containerSprite.addChild(spriteRef);
			this.spriteRef = containerSprite;
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