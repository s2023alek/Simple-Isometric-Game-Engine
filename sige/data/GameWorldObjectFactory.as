// NOT SIGE PROJEECT!!! DELETE THA FUCK OUTTA HERE
package org.jinanoimateydragoncat.works.sige.data {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.sige.data.texture_info.ActorMultiSpriteObjectTextureInfo;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.ITextureInfo;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.StaticMultiSpriteObjectTextureInfo;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.StaticSingleSpriteObjectTextureInfo;
	import org.jinanoimateydragoncat.works.sige.view.ActorObjectVisualModel;
	import org.jinanoimateydragoncat.works.sige.view.FloorVisualModel;
	import org.jinanoimateydragoncat.works.sige.view.StaticSingleSpriteObjectVisualModel;
	import org.jinanoimateydragoncat.works.sige.view.StaticMultiSpriteObjectVisualModel;
	import org.jinanoimateydragoncat.works.sige.view.IVisualModel;
	import org.jinanoimateydragoncat.works.sige.view.WallVisualModel;
	
	import org.jinanoimateydragoncat.works.sige.data.texture_info.FloorTextureInfo;
	import org.jinanoimateydragoncat.works.sige.data.texture_info.WallTextureInfo;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 03.02.2011 5:09
	 */
	public class GameWorldObjectFactory {
		
		//{ =^_^= CONSTRUCTOR
		
		function GameWorldObjectFactory () {
			throw new ArgumentError('static container only');
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public static function createFloorGameWorldObject(textureInfo:FloorTextureInfo):GameWorldObject {
			var vm:FloorVisualModel = new FloorVisualModel(textureInfo);
			return new GameWorldObject(GameWorldObject.TYPE_FLOOR, vm);
		}
		
		public static function createWallGameWorldObject(textureInfo:WallTextureInfo):GameWorldObject {
			var vm:WallVisualModel = new WallVisualModel(textureInfo);
			return new GameWorldObject(GameWorldObject.TYPE_WALL, vm);
		}
		
		public static function createTrashGameWorldObject(textureInfo:WallTextureInfo):GameWorldObject {
			var vm:WallVisualModel = new WallVisualModel(textureInfo);
			return new GameWorldObject(GameWorldObject.TYPE_OBJECT, vm);
		}
		
		public static function createActorGameWorldObject(textureInfo:ITextureInfo):ActorGameWorldObject {
			var vm:ActorObjectVisualModel = new ActorObjectVisualModel(textureInfo as ActorMultiSpriteObjectTextureInfo);
			return new ActorGameWorldObject(ActorGameWorldObject.TYPE_OBJECT, vm);
		}
		
		/**
		 * @param	textureInfo StaticSingleSpriteObjectTextureInfo or StaticMultiSpriteObjectTextureInfo
		 */
		public static function createSimpleStaticGameWorldObject(textureInfo:ITextureInfo):GameWorldObject {
			if (!(textureInfo is StaticSingleSpriteObjectTextureInfo) && !(textureInfo is StaticMultiSpriteObjectTextureInfo)) {
				throw new ArgumentError('only StaticSingleSpriteObjectTextureInfo and StaticMultiSpriteObjectTextureInfo are supported');
			}
			
			var vm:IVisualModel;
			if (textureInfo is StaticSingleSpriteObjectTextureInfo) {
				vm = new StaticSingleSpriteObjectVisualModel(textureInfo as StaticSingleSpriteObjectTextureInfo);
			} else {
				vm = new StaticMultiSpriteObjectVisualModel(textureInfo as StaticMultiSpriteObjectTextureInfo);
			}
			
			return new GameWorldObject(GameWorldObject.TYPE_STATIC_OBJECT, vm);
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:15.01.2011_[00#08#13]_[6]