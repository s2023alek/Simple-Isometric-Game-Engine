package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.FloorTextureInfo;
	
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	//} =^_^= END OF import
	
	
	/**
	 * determines object's appearance on screen
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 2:35
	 */
	public class FloorVisualModel extends AbstractSingleSpriteVisualModel implements IVisualModel {
		
		//{ =^_^= CONSTRUCTOR
		
		function FloorVisualModel (textureInfo:FloorTextureInfo) {
			super(textureInfo);
			wo = new WorldObject(0, 0, textureInfo.get_spriteRef(), true, 'floor');
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public override function setPosition(wx:Number, wy:Number):void {
			wo.set_wx(wx);
			wo.set_wy(wy);
		}
		public override function getSIEWorldObjects():Array {return [wo];}
		
		public override function set_isVisible(a:Boolean):void {
			wo.set_isVisible(a);
		}
		
		public override function set_owner (a:GameWorldObject):void {
			super.set_owner(a);
			setPosition(owner.get_wx(), owner.get_wy());
		}
		
		/**
		 * прикрепленный спрайт отображающийся поверх всех объектов
		 */
		public override function set_interfaceSpriteRef (a:DisplayObject):void {
			wo.set_interfaceSpriteRef(a);
		}
		/**
		 * прикрепленный спрайт отображающийся поверх всех объектов
		 */
		public override function get_interfaceSpriteRef():DisplayObject {
			return wo.get_interfaceSpriteRef();
		}
		
		public override function addRemoveEventLister(eventType:uint, listener:Function, add:Boolean):void {
			CL_L4OGILSBUA.addRemoveEventLister(eventType, listener, add, wo, ev_spritePress, ev_spriteOver, ev_spriteOut, ev_spriteRelease);
			
			switch (eventType) {
			case GameWorldObject.EVENT_PRESS:onPressRef = listener;break;
			case GameWorldObject.EVENT_OVER:onOverRef = listener;break;
			case GameWorldObject.EVENT_OUT:onOutRef = listener;break;
			}
		}
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]