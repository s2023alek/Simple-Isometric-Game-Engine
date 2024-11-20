package org.jinanoimateydragoncat.works.sige.data {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import org.jinanoimateydragoncat.works.contract.business_family.parsers.data.CommonDataUnit;
	import org.jinanoimateydragoncat.works.contract.business_family.parsers.data.UnitEvent;
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sige.view.IVisualModel;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 02.02.2011 22:06
	 */
	public class GameWorldObject {
		
		//{ =^_^= CONSTRUCTOR
		
		function GameWorldObject (type:uint, vm:IVisualModel) {
			ww = 0;
			wh = 0;
			set_type(type);
			this.vm = vm;
			vm.set_owner(this);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		//{ =^_^= data
		
		public function set_rotation(angle:uint):void {
			vm.set_rotation(angle);
		}
		public function get_rotation():uint {
			return vm.get_rotation();
		}
		
		public function addDisplayObject(object:DisplayObject):void 
		{

			DisplayObjectContainer(getLoadedTexture()).addChild(object);
		}
		
		public function set_frameNumber(frame:uint):void {
			var texture:DisplayObject = getLoadedTexture() as DisplayObject;
			if (texture is MovieClip)
				MovieClip(texture).gotoAndStop(frame);
		}
		
		private function getLoadedTexture():DisplayObject 
		{
			var firstSprite:DisplayObjectContainer = vm.getSprites()[0];
			return DisplayObjectContainer(DisplayObjectContainer(firstSprite.getChildAt(0)).getChildAt(0)).getChildAt(0);
		}
		
		public function get_wx():Number {return wx;}
		public function get_wy():Number {return wy;}
		public function get_ww():Number {return ww;}
		public function get_wh():Number { return wh; }
		
		public function set_wx(a:Number):void { 
			// BUG не всегда корректное положение персонажа в начале игры
			if (a > 100) a = 0;
			//
			
			wx = a; 
			vm.setPosition(wx, wy); 
		}
		
		public function set_wy(a:Number):void { 
			// BUG не всегда корректное положение персонажа в начале игры
			if (a > 100) a = 0;
			//
			
			wy = a; 
			vm.setPosition(wx, wy); 
		}
		
		public function setPostion(x:Number, y:Number):void { 
			// BUG не всегда корректное положение персонажа в начале игры
			if (x > 100) x = 0;
			if (y > 100) y = 0;
			//
			
			wx = x; 
			wy = y; 
			vm.setPosition(wx, wy); 
		}
		
		public function set_ww(a:Number):void {
			ww = a;
			if (vm) {vm.set_owner(this);}
		}
		public function set_wh(a:Number):void {
			wh = a;
			if (vm) {vm.set_owner(this);}
		}
		public function get_type():uint {return type;}
		public function get_vm():IVisualModel {return vm;}
		public function get_isWallAttachable():Boolean {return isWallAttachable;}
		public function set_isWallAttachable (a:Boolean):void {
			isWalkable = a;
			isWallAttachable = a;}
		public function set_container(a:GameWorld):void {container = a;}
		public function get_container():GameWorld {return container;}
		public function get_isWalkable():Boolean {return isWalkable;}
		public function set_isWalkable(a:Boolean):void {isWalkable = a;}
		
		public function set_isVisible(a:Boolean):void {
			isVisible = true;
			vm.set_isVisible(a);
		}
		public function get_isVisible():Boolean {
			return isVisible;
		}
		
		public function set_type(a:uint):void {
			type = a;
			if (type == TYPE_WALL || type == TYPE_FLOOR) {isWalkable = true;}
		}
		
		private var container:GameWorld;
		
		private var vm:IVisualModel;
		
		private var type:uint;
		private var isWallAttachable:Boolean;
		private var isWalkable:Boolean;
		private var isVisible:Boolean = true;
		
		private var wx:Number = 0;
		private var wy:Number = 0;
		private var ww:Number = 0;
		private var wh:Number = 0;
		private var _dataUnit:CommonDataUnit;
		
		public static const TYPE_FLOOR:uint = 0;
		public static const TYPE_OBJECT:uint = 1;
		public static const TYPE_WALL:uint = 2;
		public static const TYPE_STATIC_OBJECT:uint = 3;
		
		public static const ROTATION_LEFT:uint = 0;
		public static const ROTATION_RIGHT:uint = 1;
		
		
		//} =^_^= END OF data
		
		//{ =*^_^*= interfaces
		/**
		 * прикрепленный спрайт отображающийся поверх объекта
		 */
		public function set_interfaceSpriteRef (a:DisplayObject):void {
			vm.set_interfaceSpriteRef(a);
		}
		/**
		 * прикрепленный спрайт отображающийся поверх объекта
		 */
		public function get_interfaceSpriteRef():DisplayObjectContainer {
			return vm.get_interfaceSpriteRef() as DisplayObjectContainer;
		}
		//} =*^_^*= END OF interfaces
		
		
		
		//{ =^_^= Events
		
		/**
		 * @type see Events section
		 * @param	listener function(type:uint, target:GameWorldObject):void {}
		 */
		public function addMouseEventListener(eventType:uint, listener:Function):void {
			vm.addMouseEventListener(eventType, listener);
		}
		/**
		 * @type see Events section
		 * @param	listener function(type:uint, target:GameWorldObject):void {}
		 */
		public function removeMouseEventListener(eventType:uint, listener:Function):void {
			vm.removeMouseEventListener(eventType, listener);
		}
		
		public static const EVENT_PRESS:uint = 0;
		public static const EVENT_OVER:uint = 1;
		public static const EVENT_OUT:uint = 2;
		
		//} =^_^= END OF Events
		
		
		//{ =^_^= Misc
		public function toString():String {
			var s:String = '{';
			for each(var i:String in ['wx', 'wy', 'ww', 'wh', 'type']) {
				s+= i+'='+this[i]+',';
			}
			return s;
		}
		//} =^_^= END OF Misc
		
		public function setDataUnit(dataUnit:CommonDataUnit):void 
		{
			if (!dataUnit || _dataUnit == dataUnit) return;
			
			_dataUnit = dataUnit;
			
			if (_dataUnit.get_typeName() == "plants")
			{
				if (_dataUnit)
					(_dataUnit as EventDispatcher).removeEventListener(UnitEvent.PLANT_DATA_CHANGED, updatePlantView);
				
				(_dataUnit as EventDispatcher).addEventListener(UnitEvent.PLANT_DATA_CHANGED, updatePlantView);
				updatePlantView();
			}
		}
		
		public function getDataUnit():CommonDataUnit 
		{
			return _dataUnit;
		}
		
		private function updatePlantView(e:UnitEvent = null):void 
		{
			set_frameNumber(_dataUnit.get_stage());
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]