package org.jinanoimateydragoncat.works.sige.utils
{
	/**
	 * ...
	 * @author Nadim Jahangir
	 * @author Jinanoimatey Dragoncat
	 */
	public class PathFinder 
	{
		/**
		 * 
		 * @param	startNode {x:uint, y:uint}
		 * @param	endNode {x:uint, y:uint}
		 * @parem height
		 * @param	width
		 * @param	obstacles 2D Boolean array that tells whether a cell is an obstacle
		 * @param avoidCorners if true
		 * @param	if true the path along the corners of two adjacent obstacles are avoided. WALLS ARE IGNORED (not supported yet) IF THIS OPTION IS DISABLED
		 * @param cost additional cost matrix
		 * @param fourWayMode 4 way movement mode
		 * @param walls 1-vertical 2-horisontal 3=both
		 * @return [{x:uint, y:uint}]
		 */
		public static function aStar(	
										startNode:Object, endNode:Object,	// starting and ending node,
																			// node is an object, representing a cell in a grid,
																			// that contains two properties y, x 
										height:int, width:int,			// total number of rows and columns in the grid
										obstacles:Array, 					// 2D Boolean array that tells whether a cell is an obstacle
										avoidCorners:Boolean = true,		// if true, the path along the corners of two adjacent obstacles are avoided. WALLS ARE NOT SUPPORTED YET IF THIS OPTION IS DISABLED
										cost:Array = null,					// additional cost matrix
										fourWayMode:Boolean=false, //4 way movement mode
										walls:Array=null// 0-no wall, 1-vertical, 2-horisontal, 3=both
										,findAnyWay:Boolean = false//returns closest path
										):Array 
		{
			var i:int;
			var j:int;
			if (!walls || !avoidCorners) {
				walls = [];
				for (i = 0; i < height+1; i++){
					walls[i] = [];
					for (j = 0; j < width+1; j++){
						walls[i][j] = 0;
					}
				}
			}
			
			if (!obstacles) {
				obstacles = [];
				for (i = 0; i < height+1; i++){
					obstacles[i] = [];
					for (j = 0; j < width+1; j++){
						obstacles[i][j] = 0;
					}
				}
			}
				
			
			
			var openedList:Array = new Array();
			var closedList:Array = new Array();
			
			startNode._g = 0;	// path cost
			startNode._h = cityBlockDist(startNode, endNode);	// heuristic
			
			openedList.push(startNode);
			
			var pathFound:Boolean = false;
			
			while (openedList.length > 0) 
			{
				// picks the node with minimum cost from openedList
				var minI:int;
				var minCost:Number = Number.MAX_VALUE;
				for (i = 0; i < openedList.length; i++)
				{
					var n:Object = openedList[i];
					var curCost:Number = n._g + n._h + (cost == null ? 0 : cost[n.y][n.x]);
					if (minCost > curCost)
					{
						minI = i;
						minCost = curCost;
					}
				}
				
				// moves the node with minimum cost from openedList to closedList
				var curNode:Object = openedList[minI];
				openedList.splice(minI, 1);
				closedList.push(curNode);
				
				// if finished
				if (sameNodes(endNode, curNode))
				{
					endNode._cameFrom = curNode._cameFrom;
					pathFound = true;
					break;
				}
				
				// checks the neighbourhood
				for (i = -1; i < 2; i++)//y
				{
					for (j = -1; j < 2; j++)//x
					{
						if (i == 0 && j == 0) continue;
						
						var row:int = curNode.y + i;
						var col:int = curNode.x + j;
						
						
						// off boundary conditions
						if (row < 0 || col < 0 || row >= height || col >= width) continue;
						
						if (fourWayMode && curNode.y != row && curNode.x != col) {continue;}
						
						// walls conditions
						if (j<0 && i==0 && (walls[row][col] == 1 || walls[row][col] == 3)) continue;//left
						if (j>0 && i==0 && (walls[curNode.y][curNode.x] == 1||walls[curNode.y][curNode.x] == 3)) continue;//right
						if (i<0 && j==0 && (walls[row][col] == 2||walls[row][col] == 3)) continue;//up
						if (i>0 && j==0 && (walls[curNode.y][curNode.x] == 2||walls[curNode.y][curNode.x] == 3)) continue;//down
						
						if (i>0 && j>0 &&(walls[curNode.y][curNode.x]>0)) continue;//down right
						
						if (avoidCorners) {
							if (i>0 && j<0 &&(walls[curNode.y][curNode.x]>1||(walls[row][col]==1||walls[row][col]==3))) continue;//down left
						
							if (i<0 && j>0 &&(walls[curNode.y][curNode.x]==1||walls[curNode.y][curNode.x]==3||(walls[curNode.y-1][curNode.x+1]==2||walls[curNode.y-1][curNode.x+1]==3))) continue;//up right
						
							if (i<0 && j<0 && walls[row][col]>0) continue;//up left
						} else {
							
							if (i>0 && j<0 &&
								(
									(walls[curNode.y][curNode.x]>1
									&&
									(walls[curNode.y][curNode.x-1]==1|| // |_
									walls[curNode.y][curNode.x-1]==3)
									)
									||
									(walls[curNode.y][curNode.x]>1&&// -- 
									walls[curNode.y][curNode.x-1]>1)
									||
									(
										(walls[curNode.y][curNode.x-1]==1||
										walls[curNode.y][curNode.x-1]==3)
										&&// |
										(walls[curNode.y+1][curNode.x-1]==1||
										walls[curNode.y+1][curNode.x-1]==3)
									)
								)
							) continue;//down left
						
							if (i<0 && j>0 &&(walls[curNode.y][curNode.x]==1||walls[curNode.y][curNode.x]==3||(walls[curNode.y-1][curNode.x+1]==2||walls[curNode.y-1][curNode.x+1]==3))) continue;//up right
						
						}
						
						// obstacle condition
						if (obstacles[row][col]) continue;
						
						if (avoidCorners)
						{
							// obstacles corner conditions
							// T = Target
							// X = Obstacle
							// _ = Don't care
							/*
							 * 	TX_
							 * 	XC_
							 * 	___
							 * 
							 * */
							//up left
							if (
								(i == -1 && j == -1) && 
								(obstacles[curNode.y][curNode.x - 1] || obstacles[curNode.y - 1][curNode.x] || 
								(walls[curNode.y][curNode.x - 1]==1||
								walls[curNode.y][curNode.x - 1]==3)
								||
								walls[curNode.y - 1][curNode.x]>1)
							) continue;
							
							/*
							 * 	_XT
							 * 	_CX
							 * 	___
							 * 
							 * */
							//up right
							if (
								(i == -1 && j == 1) && (obstacles[curNode.y][curNode.x + 1] || obstacles[curNode.y - 1][curNode.x]
								|| walls[curNode.y - 1][curNode.x]>0)
							) continue;
							
							/*
							 * 	___
							 * 	XC_
							 * 	TX_
							 * 
							 * */
							//down left
							if (
								(i == 1 && j == -1) && (obstacles[curNode.y][curNode.x - 1] || obstacles[curNode.y + 1][curNode.x]||
								walls[curNode.y][curNode.x-1]>0)
							) continue;
							
							/*
							 * 	___
							 * 	_CX
							 * 	_XT
							 * 
							 * */
							//down right
							if (
								(i == 1 && j == 1) && (obstacles[curNode.y][curNode.x + 1] || obstacles[curNode.y + 1][curNode.x]||
								(walls[curNode.y+1][curNode.x]==1||
								walls[curNode.y+1][curNode.x]==3)||
								walls[curNode.y][curNode.x + 1]>1
								)
							) continue;
						} else {
							//check walls
							
							//up left
							if (
								(i == -1 && j == -1) && 
								((walls[curNode.y][curNode.x - 1]==1||
								walls[curNode.y][curNode.x - 1]==3)
								&&
								walls[curNode.y - 1][curNode.x]>1)
							) continue;
							//down right
							if (
								(i == 1 && j == 1) && (
								(walls[curNode.y+1][curNode.x]==1||
								walls[curNode.y+1][curNode.x]==3)&&
								walls[curNode.y][curNode.x + 1]>1
								)
							) continue;
						}
						
						var node2check:Object = { y:row, x:col };
						
						// if already checked
						if (containsNode(openedList, node2check) || containsNode(closedList, node2check)) continue;
						
						// calculates cost
						node2check._g = curNode._g + cityBlockDist(node2check, curNode);
						node2check._h = cityBlockDist(node2check, endNode);
						
						// keeps track of path
						node2check._cameFrom = curNode;
						
						openedList.push(node2check);
					}
				}
			}
			if (!pathFound) {
				if (findAnyWay) {
					var cmc:uint=uint.MAX_VALUE;
					var cp:uint = uint.MAX_VALUE;
					for (var cni:String in closedList) {
						if (closedList[cni]._h<cmc) {
							cp = int(cni);
							cmc = closedList[cni]._h;
						}
					}
					if (cp == uint.MAX_VALUE) {
						return null;
					} else {
						endNode = closedList[cp];
					}
				} else {
					return null;
				}
			}
			
			
			// nodes array for shortest  path
			var path:Array = new Array();

			// construct path
			path.push({y:endNode.y, x:endNode.x});
			
			var pNode:Object = endNode;
			while (!sameNodes(startNode, pNode))
			{
				pNode = pNode._cameFrom;
				path.push( { y:pNode.y, x:pNode.x } );
			}
			
			return path.reverse();
		}
		
		// city block distance between node1 and node2
		private static function cityBlockDist(node1:Object, node2:Object):Number 
		{
			return Math.abs(node1.y - node2.y) + Math.abs(node1.x - node2.x);
		}
		
		// checks if node1 and node2 belongs to same grid-cell
		private static function sameNodes(node1:Object, node2:Object):Boolean
		{
			return ((node1.y == node2.y) && (node1.x == node2.x));
		}
		
		// checks if the given node array contains the given node
		private static function containsNode(nodeArray:Array, node:Object):Boolean 
		{
			var containsIt:Boolean = false;
			for (var i:int = 0; i < nodeArray.length; i++)
			{
				if (sameNodes(nodeArray[i], node))
				{
					containsIt = true;
					break;
				}
			}
			
			return containsIt;
		}
	}
	
}