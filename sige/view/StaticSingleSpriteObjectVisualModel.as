package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.StaticSingleSpriteObjectTextureInfo;
	//} =^_^= END OF import
	
	
	/**
	 * determines object's appearance on screen
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 2:35
	 */
	public class StaticSingleSpriteObjectVisualModel extends AbstractSingleSpriteVisualModel implements IVisualModel {
		
		//{ =^_^= CONSTRUCTOR
		
		function StaticSingleSpriteObjectVisualModel(textureInfo:StaticSingleSpriteObjectTextureInfo) {
			super(textureInfo);
			wo = new WorldObject(0, 0, textureInfo.get_spriteRef());
		}
		//} =^_^= END OF CONSTRUCTOR
		
		//{ =^_^= general
		
		public override function addedOnScreen():void {
			bw = owner.get_container().get_blockWidth();
			set_rotation(rotation);
		}
		
		
		public override function setPosition(wx:Number, wy:Number):void {
			wo.set_wx(wx+.99*objectWidth);
			wo.set_wy(wy);
			
			//Sprite(wo.get_sprite()).graphics.beginFill(0x00FF00);
			//Sprite(wo.get_sprite()).graphics.drawRect(-3, -3, 6, 6);
			
		}
		
		public override function getSIEWorldObjects():Array {return [wo];}
		
		public override function set_isVisible(a:Boolean):void {
			wo.set_isVisible(a);
		}
		
		public override function set_owner (a:GameWorldObject):void {
			super.set_owner(a);
			wo.set_isWallAttachable(owner.get_isWallAttachable());
			if (a.get_ww()==a.get_wh()) {
				objectWidth=Math.max(a.get_ww(),1);
			}
			setPosition(owner.get_wx(), owner.get_wy());
			//trace('112> '+a+' vm objectWidth='+objectWidth);
		}
		
		/**
		 * 0 or >0
		 */
		public override function get_rotation():uint {return rotation;}
		/**
		 * 0 or >0
		 */
		public override function set_rotation(angle:uint):void {
			if (!owner.get_container()) {return;}
			
			rotation = angle;
			(wo.get_sprite() as DisplayObjectContainer).getChildAt(0).x = (angle > 0)?(bw * objectWidth):0;
			(wo.get_sprite() as DisplayObjectContainer).getChildAt(0).scaleX = (angle > 0)?-1:1;
		}
		
		private var objectWidth:uint=1;
		
		/**
		 * the registration point of sprite object located on block's left corner
		 */
		//public static const SPRITE_LOCATION_LEFT:uint = 1;
		/**
		 * the registration point of sprite object located on block's top corner
		 */
		//public static const SPRITE_LOCATION_TOP:uint = 0;
		
		
		
		/*public function set_spriteLocation (a:uint):void {
			spriteLocation = a;
		}*/
		
		private var bw:Number;
		
		private var rotation:uint;
		

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
		
		
		//} =^_^= END OF general
		
		
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]