package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class SingleFirework extends Sprite
	{
		/** 标志动画是否结束	 */
		public var isOver:Boolean = false;
		private var color:int;
		private var speed:int;
		/**
		 * 动画播放的状态，StateRaise：烟花上升，StateExplode：烟花爆炸
		 */
		private var state:int;
		/** 烟花上升过程的飞行高度 */
		private var flyHight:Number;
		/** 烟花爆炸散开的距离 */
		private var explodeDistance:Number;
		/** 烟花上升粒子 */
		private var raiseMovie:DisplayObject;
		/** 烟花的爆炸粒子	 */
		private var explodeMovies:Array = []; 
		
		//要养成使用常量的好习惯
		/** 烟花爆炸粒子的数量 */
		private static const ExplodeNum:int = 18;
		/** 烟花爆炸粒子飞行的距离 */
		private static const MaxExplodeDis:int = 75;
		
		/** 上升状态	 */
		private static const StateRaise:int = 0;
		/** 爆炸状态  */
		private static const StateExplode:int = 1;
		
		public function SingleFirework()
		{
			super();
			//创建粒子对象
			this.raiseMovie = new RaiseMovie();

			for(var i:int=0; i<ExplodeNum; i++)
			{
				this.explodeMovies.push(new ExplodeMovie());
			}
		}
		
		/**
		 * 开始播放动画 
		 * @param speed
		 * @param color
		 * 
		 */
		public function fire(speed:int, color:int):void
		{
			//由于对象是重复使用的，所以要注意要重置所有状态变量
			this.isOver = false;
			this.speed = speed;
			this.color = color;
			initState0();
		}
		
		private function initState0():void
		{
			//由于对象是重复使用的，所以要注意要重置所有状态变量
			this.state = StateRaise;
			this.raiseMovie.alpha = 1;
			this.raiseMovie.y = 0;
			this.flyHight = 200 + Math.random() * 200;
			FireworkMain.setColor(this.raiseMovie, this.color);
			this.addChild(this.raiseMovie);
		}		
		
		public function update():void
		{
			switch(state)
			{
				case StateRaise:
					this.raiseMovie.y -= speed;
					if(this.raiseMovie.y < -flyHight)
					{
						initState1();
					}
					break;
				
				case StateExplode:
					explodeDistance += speed / 2;
					if(explodeDistance > MaxExplodeDis)
					{
						isOver = true;
					}
					else
					{
						for(var i:int=0; i<ExplodeNum; i++)
						{
							var mc:MovieClip = this.explodeMovies[i] as MovieClip;
							var angle:Number = i / ExplodeNum * 2 * Math.PI;
							mc.x = Math.cos(angle) * explodeDistance;
							mc.y = Math.sin(angle) * explodeDistance-flyHight;
							mc.alpha = 1-explodeDistance / MaxExplodeDis;
						}
					}
					break;
			}
		}
		
		private function initState1():void
		{
			//由于对象是重复使用的，所以要注意要重置所有状态变量
			this.state = StateExplode;
			this.removeChild(this.raiseMovie);
			explodeDistance = 0;
			for(var i:int=0; i<ExplodeNum; i++)
			{
				var mc:MovieClip = this.explodeMovies[i] as MovieClip;
				mc.alpha = 1;
				FireworkMain.setColor(mc, this.color);
				mc.x = 0;
				mc.y = -flyHight;
				mc.alpha = 1;
				this.addChild(mc);
			}
		}
		

	}
}