package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	
	public class Firework extends Sprite
	{
		/**烟花发射的速度*/
		private var _speed:int;
		/**烟花的颜色*/
		private var _color:int;
		/** 烟花发射的密度，烟花发射间隔的计数器*/
		private var _interval:int;
		private var _intervalCur:int;
		/** 烟花发射的个数。*/
		private var fireArray:Array=[];

		private var rand_y_Array:Array=[];
		private var fire:RaiseMovie=null;
		
		public function Firework() {
		}
		
		public function update():void{	
			
			if(_intervalCur<=0){
				fire=new RaiseMovie(this.color);
//				rand=Math.random()*1000%550;
//				rand2=Math.random()*100%360;
				this.rand_y_Array.push(FireWorkHelper.getRandRange(20,350));
				fire.x=FireWorkHelper.getRandRange(10,580);
				fire.y=589;
				this.fireArray.push(fire);
				this.addChild(fire);
				_intervalCur = _interval;
			}
			_intervalCur--; 
			FireWorkHelper.setColor(fire,this.color);
			//烟花上升移动。
			for(var i:int=0;i<this.fireArray.length;i++){
				fireArray[i].y -= this.speed;
				if(fireArray[i].visible && fireArray[i].y <= rand_y_Array[i]){
					new FireExplodeMovie(this, fireArray[i]).createAndPlayExplode();
					new FireExplodeMovie(this, fireArray[i]).createAndPlayExplode(14,15);
					new FireExplodeMovie(this, fireArray[i]).createAndPlayExplode(18);
				}else if(fireArray[i].visible == false){
					fireArray.splice(i,1);
					rand_y_Array.splice(i,1);
				}
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