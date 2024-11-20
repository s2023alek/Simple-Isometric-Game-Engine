package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.ITextureInfo;
	//} =^_^= END OF import
	
	
	/**
	 * @usage ABSTRACT!
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 22.07.2011 4:09
	 */
	public class AbstractSingleSpriteVisualModel extends AbstractVisualModel implements IVisualModel {
		
		//{ =^_^= CONSTRUCTOR
		
		function AbstractSingleSpriteVisualModel (textureInfo:ITextureInfo) {
			super(textureInfo);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		protected var wo:WorldObject;
		
		//{ =*^_^*= access
		public override function call__Sprites(methodName:String, args:Array):* {
			var f:Function = wo.get_sprite()[methodName];
			return f.apply(this, args);
		}
		public override function set__Sprites(propertieName:String, value:Object):void {
			wo.get_sprite()[propertieName] = value;
		}
		public override function get__Sprites(propertieName:String):* {
			return wo.get_sprite()[propertieName];
		}
		/**
		 * @return [DisplayObject]
		 */
		public override function getSprites():Array {
			return [wo.get_sprite()];
		}
		//} =*^_^*= END OF access
	
		
		//{ =^_^= Events
		public override function addRemoveEventLister(eventType:uint, listener:Function, add:Boolean):void {
			switch (eventType) {
			case GameWorldObject.EVENT_PRESS:onPressRef = listener;break;
			case GameWorldObject.EVENT_OVER:onOverRef = listener;break;
			case GameWorldObject.EVENT_OUT:onOutRef = listener;break;
			}
			
			CL_L4OGILSBUA.addRemoveEventLister(eventType, listener, add, wo, ev_spritePress, ev_spriteOver, ev_spriteOut, ev_spriteRelease);
		}
		//} =^_^= END OF Events
		
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]