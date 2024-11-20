package org.jinanoimateydragoncat.works.sige.data {
	
	//{ =^_^= import
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.jinanoimateydragoncat.works.sie.data.WorldData;
	import org.jinanoimateydragoncat.works.sige.utils.PathFinder;
	
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	import org.jinanoimateydragoncat.works.sie.ViewPort;
	//} =^_^= END OF import
	
	
	/**
	 * sie.WorldData controll, collision detection
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 1:51
	 */
	public class WorldMap {
		
		//{ =^_^= CONSTRUCTOR
		
		function WorldMap (width:uint, height:uint, blockWidth:Number, objectMovementStepInterval:Number, stageRef:Stage) {
			this.stageRef = stageRef;
			mapHeight = height - 1;
			mapWidth = width - 1;
			wd = new WorldData(width, height, blockWidth);
			vp = new ViewPort(wd, blockWidth);
			
			//movement
			objMvmntStepInterval = objectMovementStepInterval;
			moveTimer = new Timer(objectMovementStepInterval);
			moveTimer.addEventListener(TimerEvent.TIMER, moveObjects);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		//{ =^_^= general
		
		public function set_movementEngineEnabled(a:Boolean):void {
			trace('set_movementEngineEnabled='+a);
			movementEngineEnabled = a;
		}
		private var movementEngineEnabled:Boolean= true;
		
		public function addObject(object:GameWorldObject):void
		{
			if (objects.indexOf(object) > -1) {return;}
			
			objects.push(object);
			
			for each(var i:WorldObject in object.get_vm().getSIEWorldObjects())
				wd.addObject(i);
			
			if (object is ActorGameWorldObject) 
				addObjectMovementEventListeners(object);
			
			object.get_vm().addedOnScreen();
			rebuildCollisionMap();
		}
		
		public function removeObject(object:GameWorldObject):void
		{
			if (objects.indexOf(object) == -1) {
				//trace('world map> NOT FOUND');
				return;}
			
			//trace('world map> FOUND, deleting objects:');
			for each(var i:WorldObject in object.get_vm().getSIEWorldObjects()) {
				//trace('world map> deleting world object:'+i)
				wd.removeObject(i);
			}
			
			objects.splice(objects.indexOf(object), 1);
			if (object is ActorGameWorldObject) {removeObjectMovementEventListeners(object)}
			
			
		}
		
		public function getObject(x:uint, y:uint):GameWorldObject {
			for each(var i:GameWorldObject in objects) {
				if (i.get_wx()==x && i.get_wy()==y) {
					return i;
				}
			}
			return null;
		}
		
		public function getWidth():uint {return wd.get_countX();}
		public function getHeight():uint {return wd.get_countY();}
		public function get_blockWidth():Number {return wd.get_blockWidth();}
		
		public function get_viewPort():ViewPort {return vp;}
		
		private var stageRef:Stage;
		/**
		 * -1
		 */
		private var mapWidth:uint;
		/**
		 * -1
		 */
		private var mapHeight:uint;
		private var vp:ViewPort;
		private var wd:WorldData;
		
		
		/**
		 * GameWorldObject
		 */
		public function get_objects():Array {return objects;}
		/**
		 * GameWorldObject
		 */
		private var objects:Array = [];
		//} =^_^= END OF general
		
		//{ =^_^= movement
		
		private function moveObjects(e:Event):void {
			if (!movementEngineEnabled) {return;}
			if (movingObjectsList.length == 0) {stopMovementProcess();}
			for each(var i:ActorGameWorldObject in movingObjectsList) {
				// check collision and move
				checkCollisionAndMove(i);
				//if (checkCollisionAndMove(i)) {
					// stop object and exclude it from movement list if collision has been occured
					//if (i.get_movementMode == ActorGameWorldObject.MOVEMENT_MODE_DIRECTIONAL) {
						//i.stop();
						//movingObjectsList.splice(movingObjectsList.indexOf(i), 1);
						//i.collisionHasBeenOccured();
					//}
				//}
			}
			vp.redraw();
		}
		
		/**
		 * @return collison occured
		 */
		private function checkCollisionAndMove(target:ActorGameWorldObject):Boolean {
			var newX:Number;
			var newY:Number;
			var ax:Number;
			var ay:Number;
			
			newX = target.get_wx()+ target.get_movementDirectionVector().x;
			newY = target.get_wy()+ target.get_movementDirectionVector().y;
			
			if (target.get_snapToCellCenter()) {
				newX = target.get_wx()+ target.get_movementDirectionVector().x;
				newY = target.get_wy()+ target.get_movementDirectionVector().y;
				
				target.setPostion(newX, newY);
				
				if (uint(newX)!=target.lastEnteredCell_wx || uint(newY)!= target.lastEnteredCell_wy) 
					ax = calcAX(newX);
					ay = calcAX(newY);
					if (
						target.lastEnteredCell_wx == uint.MAX_VALUE || 
						(
							target.get_movementDirection() == ActorGameWorldObject.ID_MOVEMENT_DIRECTION_FORTH &&
							ax>=.5
						)||
						(
							target.get_movementDirection() == ActorGameWorldObject.ID_MOVEMENT_DIRECTION_BACK &&
							ax<=.5
						)||
						(
							target.get_movementDirection() == ActorGameWorldObject.ID_MOVEMENT_DIRECTION_RIGHT &&
							ay<=.5
						)||
						(
							target.get_movementDirection() == ActorGameWorldObject.ID_MOVEMENT_DIRECTION_LEFT &&
							ay>=.5
						)
					) {
						//trace('target.enteredCell|'+uint(newX), uint(newY),'real='+target.get_wx() ,target.get_wy());
						target.enteredCell(uint(newX), uint(newY));
						return false;
				}
				
				/*if (newX < .5 || newX > mapWidth+ .5 || newY < .5 || newY > mapHeight+ .5) {
					//trace('mapWidth',mapWidth,'mapHeight',mapHeight)
					//trace('target is out of world bounds at:',target.get_wx(),'.',target.get_wy(),'vector:',target.get_movementDirectionVector());
					
					target.setPostion(Math.min(Math.max(.5, newX), mapWidth+ .5), Math.min(Math.max(.5, newY),mapHeight+ .5));
					return true;
				}*/
				
				
				
				return false;
				
			}
			
			
			/*if (newX < 0 || newX > mapWidth || newY < 0 || newY > mapWidth) {
				target.setPostion(Math.max(0, Math.min(newX, mapWidth)), Math.max(0, Math.min(newY, mapHeight)));
				return true;
			}*/
			
			target.setPostion(newX, newY);
			
			
			return false;
		}
		private function calcAX(ax:Number):Number {
			if (ax>=1) {
				return ax%uint(ax);
			} else {
				return ax;
			}
		}
		
		
		
		private function startMovementProcess():void {
			if (!movementProcessIsRunning) {
				movementProcessIsRunning = true;
				if (stageRef) {
					stageRef.addEventListener(Event.ENTER_FRAME, moveObjects);
				} else {
					moveTimer.start();
				}
			}
		}
		
		private function stopMovementProcess():void {
			if (movementProcessIsRunning) {
				movementProcessIsRunning = false;
				if (stageRef) {
					stageRef.removeEventListener(Event.ENTER_FRAME, moveObjects);
				} else {
					moveTimer.stop();
				}
			}
		}
		
		
		private var moveTimer:Timer;
		
		private var movingObjectsList:Vector.<GameWorldObject> = new Vector.<GameWorldObject>();
		private var objMvmntStepInterval:Number;
		private var movementProcessIsRunning:Boolean;
		
		//{ =*^_^*= =*^_^*= CollisionMap
		
		public function isCellWalkable(wx:uint, wy:uint):Boolean {
			return !collisionMapNotWalkable[ny(wy)][nx(wx)];
		}
		
		public function getRandomWalkableCell():Point {
			var list:Array = [];
			for (var ii:uint = 0; ii <= mapHeight; ii++) {
				for (var i:uint = 0; i <= mapWidth; i++) {
					if (!collisionMapNotWalkable[ii][i]) {
						list.push(new Point(i, ii));
					}
				}
			}
			
			if (list.length) {return list[uint(Math.random()*list.length)];}
			
			return null;
		}
		
		
		
		public function clearHighlighting():void {
			for (var ii:uint = 0; ii <= mapHeight; ii++) {
				for (var i:uint = 0; i <= mapWidth; i++) {
					vp.highlightCell(i,ii,0,0);
				}
			}
		}
		
		/**
		 * @param	exclusionList[GameWorldObject] do not process these objects
		 */
		public function invertCollisionMap(exclusionList:Array=null):void {
			for (var ii:uint = 0; ii <= mapHeight; ii++) {
				for (var i:uint = 0; i <= mapWidth; i++) {
					collisionMapNotWalkable[ii][i] = !collisionMapNotWalkable[ii][i];
					vp.highlightCell(i,ii,0,0);
					if (DEBUG_COLLISION_SHOW_COLLISION_MAP && collisionMapNotWalkable[ii][i]) {
						vp.highlightCell(i, ii, 0x0000FF, 1);
					}
				}
			}
			
		}
		
		
		
		/**
		 * @param	exclusionList[GameWorldObject] do not process these objects
		 */
		public function rebuildCollisionMap(exclusionList:Array=null):void {
			buildCollisionMap(objects, exclusionList);
		}
		
		/**
		 * @param	objectsList[GameWorldObject] process these objects only
		 */
		public function buildCollisionMap(objectsList:Array, exclusionList:Array=null):void {
			if (!exclusionList) {exclusionList = [];}
			//var o:Array;
			var u:uint;
			var w_:uint;
			var h_:uint;
			var iw:uint
			var ih:uint;
			
			collisionMapNotWalkable = [];
			collisionMapWallsMatrix = [];
			
			//clear
			for (var ii:uint = 0; ii <= mapHeight; ii++) {
				collisionMapNotWalkable[ii] = [];
				collisionMapWallsMatrix[ii] = [];
				for (var i:uint = 0; i <= mapWidth; i++) {
					collisionMapNotWalkable[ii][i] = false;
					collisionMapWallsMatrix[ii][i] = COLLISION_WALL_NONE;
					vp.highlightCell(i,ii,0,0);
				}
			}
			
			
			//objects
			for each(var io:GameWorldObject in objectsList) {
				if (
				exclusionList.indexOf(io)!=-1//in list
				|| 
				(
					io.get_type() != GameWorldObject.TYPE_STATIC_OBJECT//not static
					&& io.get_type() != GameWorldObject.TYPE_WALL//not wall
				)
				||
				(//out of bounds
				io.get_wx()>mapWidth
				||io.get_wy()>mapHeight
				)
				) {continue;}
				
				if (io.get_type() != GameWorldObject.TYPE_WALL) {
				//not walkable
				if (!io.get_isWalkable()) {
					if (io.get_rotation()>0) {
						w_ = io.get_wh();
						h_ = io.get_ww();
					} else {
						w_ = io.get_ww();
						h_ = io.get_wh();
					}
					
					for (iw= 0; iw < w_; iw++) {
						for (ih = 0; ih < h_; ih++) {
							collisionMapNotWalkable[ny(ih+io.get_wy())][nx(uint(iw+io.get_wx()))] = true;
							if (DEBUG_COLLISION_SHOW_COLLISION_MAP) {
								vp.highlightCell(iw+io.get_wx(), ih+io.get_wy(), 0x0000FF, 1);
							}
							
						}
					}
				}
				}
				
				
				//walls
				if (io.get_type() == GameWorldObject.TYPE_WALL) {
					if (io.get_rotation()==GameWorldObject.ROTATION_LEFT && io.get_wy()>=1) {//|
						u = collisionMapWallsMatrix[uint(io.get_wy())-1][uint(io.get_wx())];
						
						if (u != COLLISION_WALL_NONE) {
							collisionMapWallsMatrix[uint(io.get_wy())-1][uint(io.get_wx())] = COLLISION_WALL_BOTH;
						} else {
							collisionMapWallsMatrix[uint(io.get_wy())-1][uint(io.get_wx())] = COLLISION_WALL_HORISONTAL;
						}
						u = collisionMapWallsMatrix[uint(io.get_wy())-1][uint(io.get_wx())];
						
					} else if (io.get_wx()>=1) {//--
						u = collisionMapWallsMatrix[uint(io.get_wy())][uint(io.get_wx())-1];
						
						if (u != COLLISION_WALL_NONE) {
							collisionMapWallsMatrix[uint(io.get_wy())][uint(io.get_wx())-1] = COLLISION_WALL_BOTH;
						} else {
							collisionMapWallsMatrix[uint(io.get_wy())][uint(io.get_wx())-1] = COLLISION_WALL_VERTICAL;
						}
						
					}
				}
			}
			
		}
		
		private function nx(c:uint):uint {return Math.max(0, Math.min(mapWidth, c));}
		private function ny(c:uint):uint {return Math.max(0, Math.min(mapHeight, c));}
		
		public function get_collisionMapWallsMatrix(a:uint, b:uint):uint {
			if (collisionMapWallsMatrix[a]) {
				return collisionMapWallsMatrix[a][b];
			}
			return 0;
		}
		public function set_collisionMapWallsMatrix(a:uint, b:uint, c:uint):void {
			if (collisionMapWallsMatrix[a]) {
				collisionMapWallsMatrix[a][b] = c;
			}
		}
		
		private var collisionMapNotWalkable:Array = [];
		private var collisionMapWallsMatrix:Array = [];
		
		private static const COLLISION_WALL_NONE:uint = 0;
		private static const COLLISION_WALL_HORISONTAL:uint = 2;
		private static const COLLISION_WALL_VERTICAL:uint = 1;
		private static const COLLISION_WALL_BOTH:uint = 3;
		
		public var DEBUG_COLLISION_SHOW_COLLISION_MAP:Boolean = false;
		//} =*^_^*= =*^_^*= END OF CollisionMap
		

		//{ =*^_^*= pathfinding
		public function findPath(target:GameWorldObject, wx:uint, wy:uint, findAnyway:Boolean=true, ignoreObstacles:Boolean=false):Array {
			var a:Array;
			var b:Array;
			if (!ignoreObstacles) {
				a=collisionMapNotWalkable;
				b=collisionMapWallsMatrix;
			}
			
			return PathFinder.aStar(
				{x:uint(target.get_wx()), y:uint(target.get_wy())}
				,{x:wx, y:wy}
				,mapHeight+1
				,mapWidth+1
				,a
				,true
				,null
				,true
				,b
				,findAnyway
			);
		}
		
		//} =*^_^*= END OF pathfinding
		
		//{ =^_^= =^_^= events
		
		private function objectMovementEventListener(type:uint, target:GameWorldObject):void {
			switch (type) {
			
			case ActorGameWorldObject.EVENT_MOVEMENT_STARTED:
				//trace('EVENT_MOVEMENT_STARTED');
				if (movingObjectsList.indexOf(target) > -1) {return;}
				
				movingObjectsList.push(target);
				startMovementProcess();
				return;
			
			case ActorGameWorldObject.EVENT_MOVEMENT_STOPPED:
				//trace('EVENT_MOVEMENT_STOPPED');
				if (movingObjectsList.indexOf(target) <0) {return;}
				
				movingObjectsList.splice(movingObjectsList.indexOf(target), 1);
				return;
			
			
			}
		}
		
		private function addObjectMovementEventListeners(target:GameWorldObject):void {
			target["addMovementEventListener"](objectMovementEventListener);
		}
		private function removeObjectMovementEventListeners(target:GameWorldObject):void {
			target["removeMovementEventListener"](objectMovementEventListener);
		}
		//} =^_^= =^_^= END OF events
		
		//} =^_^= END OF movement
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]