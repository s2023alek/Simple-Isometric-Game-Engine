package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import org.jinanoimateydragoncat.works.contract.business_family.pure_mvc.view.HomeWorldViewportMediator;
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.WallTextureInfo;
	
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	
	//} =^_^= END OF import
	
	
	/**
	 * determines object's appearance on screen
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 2:35
	 */
	public class WallVisualModel extends AbstractSingleSpriteVisualModel implements IVisualModel {
		
		//{ =^_^= CONSTRUCTOR
		
		function WallVisualModel (textureInfo:WallTextureInfo) {
			super(textureInfo);
			wo = new WorldObject(0, 0, textureInfo.get_spriteRef(), false, 'wall', true);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public override function setPosition(wx:Number, wy:Number):void {
			wo.set_wx(wx+.99);
			wo.set_wy(wy);
		}
		
		public override function set_isVisible(a:Boolean):void {
			wo.set_isVisible(a);
		}
		
		public override function getSIEWorldObjects():Array {return [wo];}
		public override function set_owner (a:GameWorldObject):void {
			super.set_owner(a);
			setPosition(owner.get_wx(), owner.get_wy());
		}
		
		public override function get_rotation():uint {return rotation;}
		public override function set_rotation(angle:uint):void {
			rotation = angle;
			
			//if (!owner.get_container()) {return;}
			
			//Sprite(wo.get_sprite()).graphics.beginFill(0xFF0000);
			//Sprite(wo.get_sprite()).graphics.drawRect(-3, -3, 6, 6);

			(wo.get_sprite() as DisplayObjectContainer).getChildAt(0).x = (angle > 0)?(bw):0;
			(wo.get_sprite() as DisplayObjectContainer).getChildAt(0).scaleX = (angle > 0)?-1:1;
		}
		
		public override function addedOnScreen():void {
			bw = owner.get_container().get_blockWidth();
			set_rotation(rotation);
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
		
		
		private var bw:Number;
		private var rotation:uint;
		
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]