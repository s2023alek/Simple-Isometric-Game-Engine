// Project BusinessFamily
package org.jinanoimateydragoncat.works.sige.ani {
	
	//{ =*^_^*= import
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	//} =*^_^*= END OF import
	
	
	/**
	 * воспроизводит выбранный сегмент клипа, в любом направлении с возможностью повтора
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.06.2011 22:15
	 */
	public class SideAnimation {
		
		//{ =*^_^*= CONSTRUCTOR
		
		/**
		 * @param	listener function(target:SideAnimation, eventType:String):void;
		 */
		function SideAnimation (targetMC:MovieClip=null, listener:Function=null, loop:Boolean=false) {
			set_loop(loop);
			prepareTimer();
			changeTarget(targetMC);
			this.listener = listener;
		}
		//} =*^_^*= END OF CONSTRUCTOR
		
		public function gotoAndStopFrame(frame:int):void {
			currentFrame = frame;
			if (!mc) {return;}
			mc.gotoAndStop(frame);
		}
		
		public function stop(dispatchEvent:Boolean=true):void {
			timer.stop();
			if (!dispatchEvent) {return;}
			listen(E_ANI_STOP);
		}
		
		public function gotoAndPlayFrame(startFrame:int=1, forward:Boolean=true, endFrame:int=-1):void {
			gotoAndStopFrame(startFrame);
			play(forward, endFrame);
		}
		
		public function play(forward:Boolean=true, endFrame:int=-1):void {
			if (endFrame==startFrame) {return;}//zero length ani
			
			if (!forward&&endFrame==-1) {endFrame=1;}
			
			this.forward = forward;
			
			if (forward) {
				if (endFrame!=-1) {
					this.endFrame = Math.max(endFrame, currentFrame);
					startFrame = Math.min(endFrame, currentFrame);
				} else {
					this.endFrame=endFrame;
					startFrame=currentFrame;
				}
			} else {
				this.endFrame = Math.min(endFrame, currentFrame);
				startFrame = Math.max(endFrame, currentFrame);
			}
			
			timer.reset();
			timer.start();
			listen(E_ANI_START);
			
		}
		
		
		//{ =*^_^*= data process
		public function syncState(a:SideAnimation):void {
			a.loop = this.loop;
			a.listener = this.listener;
			a.forward = this.forward;
			a.endFrame = this.endFrame;
			a.startFrame = this.startFrame;
			if (isPlaying()) {
				if (!a.timer) {a.prepareTimer();}
				a.timer.start();
			}
		}
		//} =*^_^*= END OF data process
		
		//{ =*^_^*= data access
		public function isPlaying():Boolean {
			return timer.running;
		}
		
		public function get_loop():Boolean {return loop;}
		public function set_loop(a:Boolean):void {loop = a;}
		//} =*^_^*= END OF data access
		
		//{ =*^_^*= data
		private var loop:Boolean=true;
		private var mc:MovieClip;
		private var listener:Function;
		private var forward:Boolean;
		private var endFrame:int;
		private var startFrame:int;
		private var currentFrame:int=1;
		//} =*^_^*= END OF data		
		
		//{ =*^_^*= id events
		public static const E_ANI_STOP:String='E_ANI_STOP';
		public static const E_ANI_START:String='E_ANI_START';
		public static const E_ANI_LOOP:String='E_ANI_LOOP';
		//} =*^_^*= END OF id events
		
		//{ =*^_^*= events
		private function listen(a:String):void {
			if (listener==null) {return;}
			listener(this, a);
		}
		//} =*^_^*= END OF events
		
		//{ =*^_^*= engineering deck
		public function changeTarget(mc:MovieClip):void {
			if (mc) {mc.stop();}
			this.mc = mc;
			if (mc) {mc.stop();}
		}
		
		private function prepareTimer():void {
			timer.addEventListener(TimerEvent.TIMER, el_timer);
		}
		
		private function el_timer(e:TimerEvent):void {
			if (!mc) {return;}
			
			if (currentFrame==endFrame) {
				en_endOfAni();
				return;
			}
			
			mc.gotoAndStop(currentFrame);
			
			if (forward) {
				
				if (currentFrame<mc.totalFrames) {
					currentFrame+=1;
				} else {
					en_endOfAni();
				}
				
			} else {
				
				if (currentFrame>1) {
					currentFrame-=1;
				} else {
					en_endOfAni();
				}
				
			}
		}
		
		private function en_endOfAni():void {
			if (!mc) {return;}
			
			if (loop) {
				//reset
				currentFrame = startFrame;
				listen(E_ANI_LOOP);
			} else {
				timer.stop();
				listen(E_ANI_STOP);
			}
		}
		
		private var timer:Timer=new Timer(1);
		//} =*^_^*= END OF engineering deck
	
	}
}

//{ =*^_^*= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =*^_^*= END OF History

// template last modified:11.03.2011_[18#51#40]_[5]