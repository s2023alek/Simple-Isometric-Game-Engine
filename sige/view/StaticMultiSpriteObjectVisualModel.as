package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.StaticMultiSpriteObjectTextureInfo;
	//} =^_^= END OF import
	
	
	/**
	 * determines object's appearance on screen
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 2:35
	 */
	public class StaticMultiSpriteObjectVisualModel extends AbstractVisualModel implements IVisualModel {
		
		//{ =^_^= CONSTRUCTOR
		
		function StaticMultiSpriteObjectVisualModel(textureInfo:StaticMultiSpriteObjectTextureInfo) {
			super(textureInfo);
			wo0 = new WorldObject(0, 0, textureInfo.get_spriteRef0());
			wo1 = new WorldObject(0, 0, textureInfo.get_spriteRef1());
			setPosition(0, 0);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		//{ =^_^= general
		
		//{ =^_^= Events
		public override function addRemoveEventLister(eventType:uint, listener:Function, add:Boolean):void {
			
			switch (eventType) {
			case GameWorldObject.EVENT_PRESS:onPressRef = listener;break;
			case GameWorldObject.EVENT_OVER:onOverRef = listener;break;
			case GameWorldObject.EVENT_OUT:onOutRef = listener;break;
			}
			
			var sprites:Array = [wo0, wo1];
			for each(var i:WorldObject in sprites) {
				CL_L4OGILSBUA.addRemoveEventLister(eventType, listener, add, i, ev_spritePress, ev_spriteOver, ev_spriteOut, ev_spriteRelease);
			}
		}
		//} =^_^= END OF Events
		
		
		//{ =*^_^*= access
		public override function call__Sprites(methodName:String, args:Array):* {
			var f:Function;
			for each(var wo:WorldObject in [wo0, wo1]) {
				wo.get_sprite()[methodName];
			}
			return null;
		}
		public override function set__Sprites(propertieName:String, value:Object):void {
			for each(var wo:WorldObject in [wo0, wo1]) {
				wo.get_sprite()[propertieName] = value;
			}
		}
		public override function get__Sprites(propertieName:String):* {
			return wo0.get_sprite()[propertieName];
		}
		/**
		 * @return [DisplayObject]
		 */
		public override function getSprites():Array {
			return [wo0.get_sprite(), wo1.get_sprite()];
		}
		//} =*^_^*= END OF access
		
		
		
		public override function addedOnScreen():void {
			bw = owner.get_container().get_blockWidth();
			set_rotation(rotation);
		}
		
		public override function setPosition(wx:Number, wy:Number):void {
			this.wx = wx;
			this.wy = wy;
			
			if (calcPostionMethod_!=null) {
				calcPostionMethod();
			} else {
				determinePositionCalcMethod();
			}
			
		}
		public override function getSIEWorldObjects():Array {return [wo0, wo1];}
		
		public override function set_isVisible(a:Boolean):void {
			var objects:Array = getSIEWorldObjects();				
			for each(var i:WorldObject in objects) {
				i.set_isVisible(a);
			}
		}
		
		
		public override function set_owner (a:GameWorldObject):void {
			super.set_owner(a);
			setPosition(owner.get_wx(), owner.get_wy());
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
			rotated = angle > 0;
			
			determinePositionCalcMethod();
			
		}
		
		private function determinePositionCalcMethod():void {
			if (!owner) {
				//trace('!owner');
				return;
			}
			if (owner.get_ww() < 1 && owner.get_wh() < 1) {
				//trace('<0:',owner.get_ww() , owner.get_wh());
				return;
			}
				
			if (owner.get_ww() == 1 && owner.get_wh() == 2) {
				if (rotated) {
					//trace('calcPosition12');
					calcPostionMethod_ = calcPosition12;
				} else {
					//trace('calcPosition21');
					calcPostionMethod_ = calcPosition21;
				}
			} else if (owner.get_ww() == 2 && owner.get_wh() == 3) {
				if (rotated) {
					//trace('calcPosition23');
					calcPostionMethod_ = calcPosition23;
				} else {
					//trace('calcPosition32');
					calcPostionMethod_ = calcPosition32;
				}
			} else {
				trace(owner.get_ww()+'x'+owner.get_wh())
			}
			calcPostionMethod();
		}
		
		private function calcPostionMethod():void {
			if (calcPostionMethod_==null) {return;}
			calcPostionMethod_();
		}
		private var calcPostionMethod_:Function;
		
		private var wo0:WorldObject;
		private var wo1:WorldObject;
		
		private var wx:Number = 0;
		private var wy:Number = 0;
		private var rotated:Boolean;
		private var rotation:uint;
		
		private var bw:Number;
		//} =^_^= END OF general
		
		
		
		//{ =^_^= calc position
		
		//{ =^_^= =^_^= helpers
		private function set w0txt_x (a:Number):void {DisplayObjectContainer(wo0.get_sprite()).getChildAt(0).x = a;}
		private function set w0txt_y (a:Number):void {DisplayObjectContainer(wo0.get_sprite()).getChildAt(0).y = a;}
		private function set w0txt_sx (a:Number):void {DisplayObjectContainer(wo0.get_sprite()).getChildAt(0).scaleX = a;}
		private function set w1txt_x (a:Number):void {DisplayObjectContainer(wo1.get_sprite()).getChildAt(0).x = a;}
		private function set w1txt_y (a:Number):void {DisplayObjectContainer(wo1.get_sprite()).getChildAt(0).y = a;}
		private function set w1txt_sx (a:Number):void {DisplayObjectContainer(wo1.get_sprite()).getChildAt(0).scaleX = a;}
		//} =^_^= =^_^= END OF helpers
		
		private function calcPosition12():void {
			//trace('calcPosition12')
			w1txt_x = bw;
			wo1.set_wx(wx+.99);
			wo1.set_wy(wy);
			w1txt_sx = 1;
			//
			w0txt_x = 0;
			w0txt_y = 0;
			wo0.set_wx(wx+1.99);
			wo0.set_wy(wy);
			w0txt_sx = 1;
			
		}
		private function calcPosition21():void {
			
			//trace('calcPosition21')
			w1txt_x = 0;
			wo1.set_wx(wx+.99);
			wo1.set_wy(wy);
			w1txt_sx = -1;
			//
			w0txt_x = bw;
			w0txt_y = 0;
			wo0.set_wx(wx+.99);
			wo0.set_wy(wy+1);
			w0txt_sx = -1;
			
		}
		private function calcPosition23():void {
			//Sprite(wo1.get_sprite()).graphics.beginFill(0xFF00FF);
			//Sprite(wo1.get_sprite()).graphics.drawRect(-3, -3, 6, 6);
			//
			//
			//Sprite(wo0.get_sprite()).graphics.beginFill(0x0000FF);
			//Sprite(wo0.get_sprite()).graphics.drawRect(-3, -3, 6, 6);
			//wo1.get_sprite().alpha = .8;
			
			
			
			
			//trace('calcPosition23')
			w1txt_x = bw;
			wo1.set_wx(wx+1);
			wo1.set_wy(wy+1);
			w1txt_sx = 1;
			//
			w0txt_x = 0;
			w0txt_y = 0;
			wo0.set_wx(wx+2.99);
			wo0.set_wy(wy);
			w0txt_sx = 1;
			
		}
		private function calcPosition32():void {
			//trace('calcPosition32')
			w1txt_x = -bw*2;
			wo1.set_wx(wx-.01);
			wo1.set_wy(wy+2);
			w1txt_sx = -1;
			//
			w0txt_x = 0;
			w0txt_y = 0;
			wo0.set_wx(wx);
			wo0.set_wy(wy+2.99);
			w0txt_sx = -1;
			
		}
		
		//} =^_^= END OF calc position
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]