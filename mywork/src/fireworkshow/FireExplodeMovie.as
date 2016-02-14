package 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class FireExplodeMovie{
		/**预设的一组颜色值，烟花的颜色可以从这组颜色中随机选择得出。**/
		private static const COLORS_ARR:Array = [0xff0000,0x00ff00,0x0000ff,0xffff00,0x00ffff,0xff00ff,0xffffff,0xff6633,0x009966,0x996633];
		
		public var _container:Sprite;
		public var _raiseFire:RaiseMovie;
		public var _fillFire:FillFireSprite;
		public var _heartFill:HeartFillSprite;
		public var helloWorldFill:HelloWorldFillSprite;
		
		private var timer:Timer =new Timer(80,10);
		private var explodeArray:Array=[];
		private var explode_x:int=0;
		private var explode_y:int=0;
		private var explodeSpeed:int; //爆炸的花瓣炸开的速度。
		private var _rotationOffset:int;//旋转角度的偏移。
		
		public function FireExplodeMovie(container:Sprite,raiseFire:RaiseMovie){
			_container = container;
			_raiseFire = raiseFire;
			//加一个填充图像。
//			_fillFire = new FillFireSprite();
//			_container.addChild(_fillFire);
//			_fillFire.x = 300;
//			_fillFire.y = 5;
			//加一个心形填充图像。
			_heartFill = new HeartFillSprite();
			_container.addChild(_heartFill);
			_heartFill.x = 200;
			_heartFill.y = 60;
//			加一个其他填充图片。
//			helloWorldFill = new HelloWorldFillSprite();
//			_container.addChild(helloWorldFill);
//			helloWorldFill.x = -10;
//			helloWorldFill.y = 40;
		}
		
		public function dispose():void{
			
		}
		
		/**创建烟花的花瓣并播放每一片花瓣。*/
		public function createAndPlayExplode(speed:int = 9,rotationOffset:int = 0):void{
			_rotationOffset = rotationOffset;
			explode_x = _raiseFire.x;
			explode_y = _raiseFire.y;
			_raiseFire.visible = false;
			///生成爆炸烟花。
			for(var i:int=0;i<12;i++) {
				this.explodeArray[i]=new RaiseMovie(_raiseFire.fireColor);
				this.explodeArray[i].rotation=i*(30+_rotationOffset);
				this.explodeArray[i].x=explode_x;
				this.explodeArray[i].y=explode_y;
				
				var index:int = FireWorkHelper.getRandRange(1,10) - 1;
				var curColor:int = COLORS_ARR[index];
				FireWorkHelper.setColor(this.explodeArray[i],curColor);
//				FireWorkHelper.setColor(this.explodeArray[i],(explodeArray[i] as RaiseMovie).fireColor);
				_container.addChild(this.explodeArray[i]);	
				explodeSpeed = speed;
			}
			timer.start();
			timer.addEventListener(TimerEvent.TIMER,onEachDelayCall);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);	
		}
		
		private function onTimerComplete(event:TimerEvent):void
		{
			for(var i:int=0;i<12;i++)
			{
				_container.removeChild(explodeArray[i]);
				explodeArray[i]=null;
			}
			_raiseFire = null;
		}
		
		private function onEachDelayCall(evt:TimerEvent):void {
			for(var i:int=0;i<12;i++) {
				explodeArray[i].x += explodeSpeed * Math.sin(i*(30 + _rotationOffset)*Math.PI/180);//使烟花的每一片都四周移动。
				explodeArray[i].y -= explodeSpeed * Math.cos(i*(30 + _rotationOffset)*Math.PI/180);
//				if(_fillFire.hitTestObject(explodeArray[i] as Sprite) && (explodeArray[i] as Sprite).visible){
//					_fillFire.addFillFire(explodeArray[i]);
//					(explodeArray[i] as Sprite).visible = false;
//				}
				///填充烟花碎片到心形里。
				if(_heartFill.hitTestObject(explodeArray[i] as Sprite) && (explodeArray[i] as Sprite).visible){
					_heartFill.addFillFire(explodeArray[i]);
					(explodeArray[i] as Sprite).visible = false;
				}
				///填充烟花碎片到Hello World的图形里。
//				if(helloWorldFill.hitTestObject(explodeArray[i] as Sprite) && (explodeArray[i] as Sprite).visible){
//					helloWorldFill.addFillFire(explodeArray[i]);
//					(explodeArray[i] as Sprite).visible = false;
//				}
				
			}
		}
		
		
		
	}
}