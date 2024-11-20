// Project BusinessFamily
package org.jinanoimateydragoncat.works.sige.data {
	
	//{ =^_^= import
	import flash.geom.Point;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import org.jinanoimateydragoncat.works.sige.view.ActorObjectVisualModel;
	import org.jinanoimateydragoncat.works.sige.view.IVisualModel;
	
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 11.02.2011 19:32
	 */
	public class ActorGameWorldObject extends GameWorldObject {
		
		//{ =^_^= CONSTRUCTOR
		
		function ActorGameWorldObject (type:uint, vm:ActorObjectVisualModel) {
			super(type, vm);
			v = vm;
			setId(this);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		//{ =^_^= directional movement
		
		public function goForth(speed:Number):void {if (pathMovement) {return;}
			lastEnteredCell_wx = uint.MAX_VALUE;
			lastEnteredCell_wy = uint.MAX_VALUE;
			movementSpeed = speed;
			goForth_(speed);
		}
		private function goForth_(speed:Number):void {
			checkAxisChange(0);
			movementDirection = ID_MOVEMENT_DIRECTION_FORTH;
			v.switchSide(ActorObjectVisualModel.SIDE_FRONT);
			go(new Point(speed, 0));
		}
		public function goBack(speed:Number):void {if (pathMovement) {return;}
			lastEnteredCell_wx = uint.MAX_VALUE;
			lastEnteredCell_wy = uint.MAX_VALUE;
			movementSpeed = speed;
			goBack_(speed);
		}
		private function goBack_(speed:Number):void {
			checkAxisChange(0);
			movementDirection = ID_MOVEMENT_DIRECTION_BACK;
			v.switchSide(ActorObjectVisualModel.SIDE_BACK);
			go(new Point(-speed, 0));
		}
		public function goLeft(speed:Number):void {if (pathMovement) {return;}
			lastEnteredCell_wx = uint.MAX_VALUE;
			lastEnteredCell_wy = uint.MAX_VALUE;
			movementSpeed = speed;
			goLeft_(speed);
		}
		private function goLeft_(speed:Number):void {
			checkAxisChange(1);
			movementDirection = ID_MOVEMENT_DIRECTION_LEFT;
			v.switchSide(ActorObjectVisualModel.SIDE_LEFT);
			go(new Point(0, speed));
		}
		public function goRight(speed:Number):void {if (pathMovement) {return;}
			lastEnteredCell_wx = uint.MAX_VALUE;
			lastEnteredCell_wy = uint.MAX_VALUE;
			movementSpeed = speed;
			goRight_(speed);
		}
		private function goRight_(speed:Number):void {
			checkAxisChange(1);
			movementDirection = ID_MOVEMENT_DIRECTION_RIGHT;
			v.switchSide(ActorObjectVisualModel.SIDE_RIGHT);
			go(new Point(0, -speed));
		}
		
		private function checkAxisChange(newAxis:uint):void {
			if (snapToCellCenter && lastMovingAxis != newAxis) {
				lastMovingAxis = newAxis;
				if (newAxis == 1) {//left right
					//correct x
					set_wx(uint(get_wx())+.5);
				} else {
					set_wy(uint(get_wy())+.5);
				}
			}
		}
		
		public function set_standAnimationFrame(a:Object):void {v.set_standAnimationFrame(a);}
		
		public function stop(gotoStandAnimationFrame:Boolean=false):void {
			if (pathMovement) {
				stopPathMovement(gotoStandAnimationFrame);
			} else {
				stopDirectionalMovement(gotoStandAnimationFrame);
			}
		}
		
		private function stopPathMovement(gotoStandAnimationFrame:Boolean=false):void {
			stopDirectionalMovement(pathMovement_gotoStandAnimationFrame);
		}
		
		private function stopDirectionalMovement(gotoStandAnimationFrame:Boolean=false):void {
			moving = false;
			lastEnteredCell_wx = uint.MAX_VALUE;
			lastEnteredCell_wy = uint.MAX_VALUE;
			if (gotoStandAnimationFrame) {
				v.stop();
			} else {
				v.pause();
			}
			dispatchMovementEvent(EVENT_MOVEMENT_STOPPED);
		}
		
		public function collisionHasBeenOccured():void {
			//trace('collisionHasBeenOccured');
			if (_collisionHasBeenOccuredRef!=null) {
				_collisionHasBeenOccuredRef();
			} else {
				stop();
			}
		}
		//internal var collisionHasBeenOccuredIn:Point;
		
		public function get_movementSpeed():Number {return movementSpeed;}
		public function get_movementDirection():uint {return movementDirection;}
		public function get_snapToCellCenter():Boolean {return snapToCellCenter;}
		public function set_snapToCellCenter(a:Boolean):void {snapToCellCenter = a;}
		
		public function enteredCell(wx:uint, wy:uint):void {
			if (lastEnteredCell_wx!=wx || lastEnteredCell_wy!= wy) {
				lastEnteredCell_wx = wx;
				lastEnteredCell_wy = wy;
				dispatchEnteredCellEvent(wx, wy);
				if (pathMovement) {gotoNextPathNode();}
			}
		}
		
		internal function go(directionVector:Point):void {
			movementDirectionVector = directionVector.clone();
			if (!moving) {
				moving = true;
				v.play();
				dispatchMovementEvent(EVENT_MOVEMENT_STARTED);
			}
		}
		
		public function placeToCell(cell_wx:uint, cell_wy:uint):void {
			lastEnteredCell_wx = cell_wx;
			lastEnteredCell_wy = cell_wy;
			setPostion(cell_wx+.5, cell_wy+.5);
		}
		
		internal function get_movementDirectionVector():Point {return movementDirectionVector;}
		protected var movementDirectionVector:Point = new Point();
		
		//{ =*^_^*= data access
		public function isMoving():Boolean {return moving;}
		//} =*^_^*= END OF data access
		
		//{ =*^_^*= data
		internal var lastEnteredCell_wx:uint;
		internal var lastEnteredCell_wy:uint;
		
		private var lastMovingAxis:uint;
		private var snapToCellCenter:Boolean;
		private var movementDirection:uint;
		private var movementSpeed:Number;
		private var moving:Boolean;
		
		//} =*^_^*= END OF data
		
		
		//{ =^_^= =^_^= events
		
		/**
		 * @param	listener function(type:uint, target:GameWorldObject):void {}
		 */
		public function addMovementEventListener(listener:Function):void {
			if (listener!=null &&  _movementListerRef.indexOf(listener)<0) {
				_movementListerRef.push(listener);
			}
		}
		public function removeMovementEventListener(listener:Function):void {
			if (_movementListerRef.indexOf(listener)) {
				_movementListerRef.splice(_movementListerRef.indexOf(listener, 1), 1);
			}
		}
		
		protected function dispatchMovementEvent(type:uint):void {
			for each(var i:Function in _movementListerRef) {
				i(type, this);
			}
		}
		private var _movementListerRef:Vector.<Function> = new Vector.<Function>();
		
		
		/**
		 * @param	listener function(target:ActorGameWorldObject, wx:uint, wy:uint):void {}
		 */
		public function addEnteredCellEventListener(listener:Function):void {_enteredCellListerRef = listener;}
		public function removeEnteredCellEventListener(listener:Function):void {_enteredCellListerRef = null;}
		
		protected function dispatchEnteredCellEvent(wx:uint, wy:uint):void {
			if (_enteredCellListerRef != null) {
				_enteredCellListerRef(this, wx, wy);
			}
		}
		private var _enteredCellListerRef:Function;
		
		
		/**
		 * @param	listener function(target:GameWorldObject):void {}
		 */
		public function addCollisionHasBeenOccuredEventListener(listener:Function):void {_collisionHasBeenOccuredRef= listener;}
		public function removeCollisionHasBeenOccuredEventListener(listener:Function):void {_collisionHasBeenOccuredRef = null;}
		
		protected function dispatchcollisionHasBeenOccuredEvent():void {
			if (_collisionHasBeenOccuredRef != null) {
				_collisionHasBeenOccuredRef(this);
			}
		}
		private var _collisionHasBeenOccuredRef:Function;
		
		
		public static const EVENT_MOVEMENT_STARTED:uint = 0;		
		public static const EVENT_MOVEMENT_STOPPED:uint = 1;		
		//} =^_^= =^_^= END OF events
		
		
		//{ =^_^= id
		public static const ID_MOVEMENT_DIRECTION_RIGHT:uint = 2;
		public static const ID_MOVEMENT_DIRECTION_LEFT:uint = 3;
		public static const ID_MOVEMENT_DIRECTION_FORTH:uint = 0;
		public static const ID_MOVEMENT_DIRECTION_BACK:uint = 1;
		//} =^_^= END OF id
		
		
		//} =^_^= END OF directional movement
		
		//{ =*^_^*= path movement
		
		/**
		 * @return path found
		 */
		public function goTo(wx:uint, wy:uint, speed:Number, gotoStandAnimationFrame:Boolean=true, findAnyway:Boolean=true, ghostMode:Boolean=false):Boolean {
			pathMovement_gotoStandAnimationFrame = gotoStandAnimationFrame;
			movementSpeed = speed;
			// intercept directional movement controll from user, use it
			pathMovement = true;
			snapToCellCenter = true;
			// get movementPathNodes and store it
			pathNodes = findPathNodes(this, wx, wy, findAnyway, ghostMode);
			if (!pathNodes) {return false;}
			pathNodes.shift();//already there
			var pl:Array = [];
			
			//tr('present=',uint(get_wx()),uint(get_wy()));
			//for each(var i:Object in pathNodes) {
				//pl.push('{'+i.x+','+i.y+'}');
			//}
			//tr('pathNodes:'+pl);
			
			// sequentially, follow nodes
			lastEnteredCell_wx=get_wx();
			lastEnteredCell_wy=get_wy();
			
			gotoNextPathNode();
			return true;
		}
		
		public static function findPathNodes(target:GameWorldObject, wx:uint, wy:uint, findAnyway:Boolean=true, ignoreObstacles:Boolean=false):Array {
			return target.get_container().get_map().findPath(target, wx, wy, findAnyway, ignoreObstacles);
		}
		
		private function gotoNextPathNode():void {
			//tr('gotoNextPathNode');
			if (!pathNodes || pathNodes.length<1) {
				//tr('arrived');
				stop();
				return;
			}
			
			//tr('present=',uint(get_wx()),uint(get_wy()));
			//if (currentPathNode!=null && (uint(get_wx())==currentPathNode.x && uint(get_wy())==currentPathNode.y)) {
				
				var node:Object = pathNodes.shift();
				currentPathNode = new Point(node.x, node.y);
				//tr('destination='+currentPathNode.x, currentPathNode.y);
			//} else {
				//tr('still moving...');
			//}
			
			/*if (currentPathNode.x == lastEnteredCell_wx && currentPathNode.y == lastEnteredCell_wy) {
				gotoNextPathNode();
				return;
			}*/
			//trace('nextPathNode='+currentPathNode);
			
			if (currentPathNode.x>lastEnteredCell_wx) {
				//trace('goForth_');
				goForth_(movementSpeed);
				return;
			}
			if (currentPathNode.x<lastEnteredCell_wx) {
				//trace('goBack_');
				goBack_(movementSpeed);
				return;
			}
			if (currentPathNode.y>lastEnteredCell_wy) {
				//trace('goLeft_');
				goLeft_(movementSpeed);
				return;
			}
			if (currentPathNode.y<lastEnteredCell_wy) {
				//trace('goRight_');
				goRight_(movementSpeed);
				return;
			}
			
		}
		
		private var pathMovement_gotoStandAnimationFrame:Boolean;
		private var currentPathNode:Point = new Point(-1, -1);
		private var pathNodes:Array;
		private var pathMovement:Boolean;
		//} =*^_^*= END OF path movement
		
		/**
		 * directional or pathfinding
		 */
		public function get_movementMode():uint {return movementMode;}
		public function set_movementMode(a:uint):void {movementMode = a;}
		
		private var movementMode:uint = MOVEMENT_MODE_DIRECTIONAL;
		
		private var v:ActorObjectVisualModel;
		
		//{ =*^_^*= id
		public static const MOVEMENT_MODE_DIRECTIONAL:uint = 0;
		public static const MOVEMENT_MODE_PATHFINDING:uint = 1;
		static public const TYPE_OBJECT:int = 100;
		//} =*^_^*= END OF id
		
		//debug:
		private static function setId(a:ActorGameWorldObject):void {
			a.id = lastId;
			lastId+=1;
		}
		private var id:uint;
		private static var lastId:uint=0;
		
		private function tr(...args:Array):void {
			return;
			trace('['+id+']>'+args.join(' '));
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 18.03.2011_[23#36#43]_[5] + gotoStandAnimationFrame
 * > 20.03.2011_[23#32#34]_[7] + path movement
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]