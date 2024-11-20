// Project BusinessFamily
package org.jinanoimateydragoncat.works.sige.view {
	
	//{ =*^_^*= import
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sige.data.GameWorldObject;
	//} =*^_^*= END OF import
	
	
	/**
	 * package code library
	 * keywords:
	 * addRemoveEventLister GameWorldObject.EVENT_PRESS
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 22.07.2011 3:33
	 */
	public class CL_L4OGILSBUA {
		
		//{ =^_^= Events
		public static function addRemoveEventLister(eventType:uint, listener:Function, add:Boolean, wo:WorldObject, ev_spritePress:Function, ev_spriteOver:Function, ev_spriteOut:Function, ev_spriteRelease:Function):void {
			wo.get_sprite()["useHandCursor"] = add;
			wo.get_sprite()["buttonMode"] = add;
			wo.get_sprite()["mouseChildren"] = !add;
			
			switch (eventType) {
			
			case GameWorldObject.EVENT_PRESS:
				if (add) {
					wo.get_sprite().addEventListener(MouseEvent.MOUSE_DOWN, ev_spritePress);
					if (wo.get_sprite().stage) {
						wo.get_sprite().stage.addEventListener(MouseEvent.MOUSE_UP, ev_spriteRelease);
					} else {
						wo.get_sprite().addEventListener(Event.ADDED_TO_STAGE
							,function (e:Event):void {
								e.target.stage.addEventListener(MouseEvent.MOUSE_UP, ev_spriteRelease);
							}
						);
					}
					return;
				}
				wo.get_sprite().removeEventListener(MouseEvent.MOUSE_DOWN, ev_spritePress);
				break;
			
			case GameWorldObject.EVENT_OVER:
				if (add) {
					wo.get_sprite().addEventListener(MouseEvent.MOUSE_OVER, ev_spriteOver);
					return;
				}
				wo.get_sprite().removeEventListener(MouseEvent.MOUSE_OVER, ev_spriteOver);
				break;
			
			case GameWorldObject.EVENT_OUT:
				if (add) {
					wo.get_sprite().addEventListener(MouseEvent.MOUSE_OUT, ev_spriteOut);
					return;
				}
				wo.get_sprite().removeEventListener(MouseEvent.MOUSE_OUT, ev_spriteOut);
				break;
			}
		}
		//} =^_^= END OF Events
		
	}
}

//{ =*^_^*= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =*^_^*= END OF History

// template last modified:11.03.2011_[18#51#40]_[5]