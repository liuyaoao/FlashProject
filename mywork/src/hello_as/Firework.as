package
{
	import flash.display.Sprite;
	
	public class Firework extends Sprite
	{
		
		/**
		 * 烟花发射的速度
		 */
		private var _speed:int;
		/**
		 * 烟花的颜色
		 */
		private var _color:int;
		/**
		 * 烟花发射的密度
		 */
		private var _interval:int;
		
		/**
		 * 对象池，节省创建对象的开销
		 */
		private var pool:Array = [];	
		
		/**
		 * 烟花发射间隔的计数器
		 */
		private var fireColddown:int = 0;
		
		/**
		 * 保存飞行中的烟花
		 */
		private var shootingFireworks:Array = [];
		
		public function Firework()
		{
		}
		
		public function update():void
		{
			var single:SingleFirework;
			if(fireColddown <= 0)
			{
				//发射新的烟花
				fireColddown = interval;
				single = getSingleFirework(); //从对象池取出新的烟花		
				this.shootingFireworks.push(single);
				single.x = 50 + Math.random() * (FireworkMain.ScreenWidth - 100);
				single.y = FireworkMain.ScreenHight;
				this.addChild(single);
				single.fire(this.speed, this.color);//开始烟花的播放
			}
			fireColddown--;
			for(var i:int=shootingFireworks.length-1; i>=0; i--)	//更新所有飞行中的烟花
			{
				single = shootingFireworks[i];
				single.update();
				if(single.isOver)	//若烟花动画已经播完则将其移除，并放回对象池里
				{
					shootingFireworks.splice(i,1);
					this.removeChild(single);
					pool.push(single);
				}
			}
		}
		
		private function getSingleFirework():SingleFirework
		{
			if(pool.length > 0)
			{
				return pool.shift() as SingleFirework;
			}
			else
			{
				return new SingleFirework();
			}
		}

		public function get speed():int
		{
			return _speed;
		}

		public function set speed(value:int):void
		{
			_speed = value;
		}

		public function get color():int
		{
			return _color;
		}

		public function set color(value:int):void
		{
			_color = value;
		}

		public function get interval():int
		{
			return _interval;
		}

		public function set interval(value:int):void
		{
			_interval = value;
		}


	}
}