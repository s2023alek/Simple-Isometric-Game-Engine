package org.jinanoimateydragoncat.works.sige.data.texture_info {
	
	//{ =^_^= import
	import flash.display.MovieClip;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 07.02.2011_[00#44#20]_[1]
	 */
	public class ActorMultiSpriteObjectTextureInfo extends AbstractTextureInfo implements ITextureInfo {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * 
		 * @param	frontSide
		 * @param	backSide
		 * @param	leftSide can be null
		 * @param	rightSide can be null
		 */
		function ActorMultiSpriteObjectTextureInfo (frontSide:MovieClip, backSide:MovieClip, leftSide:MovieClip=null, rightSide:MovieClip=null) {
			this.frontSide = frontSide;
			this.backSide = backSide;
			this.leftSide = leftSide;
			this.rightSide = rightSide;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function get_rightSide():MovieClip {return rightSide;}
		public function get_frontSide():MovieClip {return frontSide;}
		public function get_leftSide():MovieClip {return leftSide;}
		public function get_backSide():MovieClip {return backSide;}
		
		private var frontSide:MovieClip;
		private var backSide:MovieClip;
		private var leftSide:MovieClip;
		private var rightSide:MovieClip;
		
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]