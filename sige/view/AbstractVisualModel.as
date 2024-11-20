package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.events.Event;
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.ITextureInfo;
	//} =^_^= END OF import
	
	
	/**
	 * determines object's appearance on screen
	 * @usage ABSTRACT!
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 2:13
	 */
	public class AbstractVisualModel implements IVisualModel {
		
		//{ =^_^= CONSTRUCTOR
		
		function AbstractVisualModel (textureInfo:ITextureInfo) {
			this.textureInfo = textureInfo;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		//{ =*^_^*= access
		public function call__Sprites(methodName:String, args:Array):* {
			// override and place your code here
		}
		public function set__Sprites(propertieName:String, value:Object):void {
			// override and place your code here
		}
		public function get__Sprites(propertieName:String):* {
		// override and place your code here
		}
		/**
		 * @return [DisplayObject]
		 */
		public function getSprites():Array {
			// override and place your code here
			return null;
		}
		//} =*^_^*= END OF access
		
		public function setPosition(wx:Number, wy:Number):void {
			// override and place your code here
		}
		public function set_rotation(angle:uint):void {
			// override and place your code here
		}
		public function get_rotation():uint {
			return 0;
			// override and place your code here
		}
		public function getSIEWorldObjects():Array {
			// override and place your code here
			return null;
		}
		public function addedOnScreen():void {
			// override and place your code here
		}
		
		public function set_isVisible(a:Boolean):void {
			// override and place your code here
		}
		
		public function set_textureInfo(textureInfo:ITextureInfo):void {
			// override and place your code here
		}
		
		
		public final function get_textureInfo():ITextureInfo {
			return textureInfo;
		}
		
		/**
		 * прикрепленный спрайт отображающийся поверх всех объектов
		 */
		public function set_interfaceSpriteRef (a:DisplayObject):void {
			throw new ArgumentError('not supported');
			// override and place your code here
		}
		/**
		 * прикрепленный спрайт отображающийся поверх всех объектов
		 */
		public function get_interfaceSpriteRef():DisplayObject {
			throw new ArgumentError('not supported');
			// override and place your code here
		}
		
		
		
		public function set_owner (a:GameWorldObject):void {owner = a;}
		
		
		protected var owner:GameWorldObject;
		
		
		
		protected var textureInfo:ITextureInfo;
		
		//} =^_^= Events
		
		public function addMouseEventListener(eventType:uint, listener:Function):void {
			addRemoveEventLister(eventType, listener, true);
		}
		public function removeMouseEventListener(eventType:uint, listener:Function):void {
			addRemoveEventLister(eventType, listener, !true);
		}
		
		protected function ev_spritePress(e:Event):void {
			//e.stopImmediatePropagation();
			pressedX = e.target.stage.mouseX;
			pressedY = e.target.stage.mouseY;
			mouseDown = true;
		}
		protected function ev_spriteRelease(e:Event):void {
			if (!mouseDown || Math.abs(pressedX- e.target.stage.mouseX) > 5 || Math.abs(pressedY- e.target.stage.mouseY) > 5) {return;}
			if (onPressRef!=null) {onPressRef(GameWorldObject.EVENT_PRESS, owner);}
		}
		protected function ev_spriteOver(e:Event):void {
			if (onOverRef!=null) {onOverRef(GameWorldObject.EVENT_OVER, owner);}
		}
		protected function ev_spriteOut(e:Event):void {
			if (onOutRef!=null) {onOutRef(GameWorldObject.EVENT_OUT, owner);}
		}
		
		public function addRemoveEventLister(eventType:uint, listener:Function, add:Boolean):void {
			// override and place your code here
		}
		
		private var mouseDown:Boolean;
		private var pressedX:Number;
		private var pressedY:Number;
		
		
		protected var onPressRef:Function;
		protected var onOverRef:Function;
		protected var onOutRef:Function;
		
		//} =^_^= END OF Events
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]