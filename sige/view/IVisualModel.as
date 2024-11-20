package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.ITextureInfo;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 2:03
	 */
	public interface IVisualModel {
		
		function setPosition(wx:Number, wy:Number):void;
		function set_rotation(angle:uint):void;
		function get_rotation():uint;
		function addedOnScreen():void;
		/**
		 * @return Array[sie.data.WorldObject]
		 */
		function getSIEWorldObjects():Array;
		function set_owner (a:GameWorldObject):void;
		/**
		 * @param	eventType ex:GameWorldObject.EVENT_PRESS
		 * @param	listener (eventType:uint, target:GameWorldObject)
		 */
		function addMouseEventListener(eventType:uint, listener:Function):void;
		function removeMouseEventListener(eventType:uint, listener:Function):void;
		
		function set_textureInfo(textureInfo:ITextureInfo):void;
		function get_textureInfo():ITextureInfo;
		
				
		//{ =*^_^*= access
		function call__Sprites(methodName:String, args:Array):*;
		function set__Sprites(propertieName:String, value:Object):void;
		function get__Sprites(propertieName:String):*;
		/**
		 * @return [DisplayObject]
		 */
		function getSprites():Array;
		//} =*^_^*= END OF access
		
		
		/**
		 * прикрепленный спрайт отображающийся поверх всех объектов
		 */
		function set_interfaceSpriteRef (a:DisplayObject):void;
		/**
		 * прикрепленный спрайт отображающийся поверх всех объектов
		 */
		function get_interfaceSpriteRef():DisplayObject;
		
		function set_isVisible(a:Boolean):void;
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]