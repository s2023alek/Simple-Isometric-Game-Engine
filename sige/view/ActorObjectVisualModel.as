package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.ITextureInfo;
	
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.ActorMultiSpriteObjectTextureInfo;
	//} =^_^= END OF import
	
	
	/**
	 * determines object's appearance on screen
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 2:35
	 */
	public class ActorObjectVisualModel extends AbstractSingleSpriteVisualModel implements IVisualModel {
		
		//{ =^_^= CONSTRUCTOR
		
		function ActorObjectVisualModel(textureInfo:ActorMultiSpriteObjectTextureInfo) {
			super(textureInfo);
			topLevelContainer.addChild(sideContainer);
			topLevelContainer.addChild(interfaceLayerContainer);
			
			wo = new WorldObject(0, 0, topLevelContainer);
			
			currentSideID = SIDE_FRONT;
			set_textureInfo(textureInfo);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
		//{ =^_^= general
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
		
		
		public function set_standAnimationFrame(a:Object):void {standAnimationFrame = a;}
		
		private var standAnimationFrame:Object=1;
		//} =^_^= END OF general

		
		
		//{ =^_^= side sprites
		
		public function play():void {
			//trace('play')
			playing = true;
			if (currentSide) {currentSide.play();}
		}
		
		public function stop():void {
			//trace('stop')
			playing = false;
			if (currentSide) {currentSide.gotoAndStop(standAnimationFrame);}
		}
		
		public function pause():void {
			//trace('pause')
			playing = false;
			if (currentSide) {currentSide.stop();}
		}
		
		public function switchSide(side:uint):void {
			//if (currentSideID == side) {return;}
			currentSideID = side;
			
			if (currentSide) {
				currentSide.stop();
				sideContainer.removeChild(currentSide);
				currentFrame = currentSide.currentFrame;
			}
			
			switch (side) {
			
			case SIDE_BACK:
				if (backSide) {
					currentSide = backSide;
					currentSide.scaleX = Math.abs(currentSide.scaleX);
					break;
				}
				currentSide = rightSide;	
				currentSide.scaleX = Math.abs(currentSide.scaleX)*-1;
				break;
			
			case SIDE_FRONT:
				if (frontSide) {
					currentSide = frontSide;
					currentSide.scaleX = Math.abs(currentSide.scaleX);
					break;
				}
				currentSide = leftSide;	
				currentSide.scaleX = Math.abs(currentSide.scaleX)*-1;
				break;
			
			case SIDE_LEFT:
				if (leftSide) {
					currentSide = leftSide;
					currentSide.scaleX = Math.abs(currentSide.scaleX);
					break;
				}
				currentSide = frontSide;	
				currentSide.scaleX = Math.abs(currentSide.scaleX)*-1;
				break;
			
			case SIDE_RIGHT:
				if (rightSide) {
					currentSide = rightSide;
					currentSide.scaleX = Math.abs(currentSide.scaleX);
					break;
				}
				currentSide = backSide;
				currentSide.scaleX = Math.abs(currentSide.scaleX)*-1;
				break;
			
			
			}
			
			//currentSide.graphics.beginFill(0xFF0000);
			//currentSide.graphics.drawRect(-10,-10,20,20)
			
			if (currentSide /*&& !sideContainer.contains(currentSide) //? can cause problems*/) {//sprite changed
				sideContainer.addChild(currentSide);
				
				//sync ani if present
				if (textureInfo.getAnimation()) {//has ani
					textureInfo.getAnimation().changeTarget(currentSide);
				}
				
				if (!textureInfo.getAnimation() || !textureInfo.getAnimation().isPlaying()) {
					//can controll animation
					if (playing) {
						currentSide.gotoAndPlay(currentFrame);
					} else {
						currentSide.gotoAndStop(currentFrame);
					}
				}
				
			}
			
		}
		
		public override function set_rotation(angle:uint):void {
			//operation is impossible (cannot set 2 sides simultaneously 
		}
		
		/**
		 * @deprecated
		 * contains user interface, indicators, etc
		 */
		public function get_interfaceLayerContainer():Sprite {return interfaceLayerContainer;}
		public function get_sideContainer():Sprite {return sideContainer;}
		
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
		
		protected var frontSide:MovieClip;
		protected var backSide:MovieClip;
		protected var leftSide:MovieClip;
		protected var rightSide:MovieClip;
		
		private var topLevelContainer:Sprite = new Sprite();
		private var interfaceLayerContainer:Sprite = new Sprite();
		private var sideContainer:Sprite = new Sprite();
		private var currentSide:MovieClip;
		private var playing:Boolean;
		private var currentFrame:uint;
		
		//data
		public static const SIDE_FRONT:uint = 0;
		public static const SIDE_BACK:uint = 1;
		public static const SIDE_LEFT:uint = 2;
		public static const SIDE_RIGHT:uint = 3;
		private static const SIDE_NONE:uint = uint.MAX_VALUE;
		
		private var currentSideID:uint = SIDE_NONE;
		
		
		//} =^_^= END OF side sprites
		
		
		//{ =*^_^*= textures
		public override function set_textureInfo(ti:ITextureInfo):void {
			if (textureInfo.getAnimation() && textureInfo.getAnimation().isPlaying()) {
				textureInfo.getAnimation().stop(false);
			}
			textureInfo = ti;
			frontSide = get_ti().get_frontSide();
			leftSide = get_ti().get_leftSide();
			rightSide = get_ti().get_rightSide();
			backSide = get_ti().get_backSide();
			
			//reinit
			var side:uint = currentSideID;
			currentSideID = SIDE_NONE;
			switchSide(side);
			
		}
		
		//} =*^_^*= END OF textures
		
		private function get_ti():ActorMultiSpriteObjectTextureInfo {
			return textureInfo as ActorMultiSpriteObjectTextureInfo;
		}
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 12.07.2011_04#55#06 + textures, set_textureInfo
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]