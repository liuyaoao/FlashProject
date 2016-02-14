package hello_as  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.display.Sprite;
	
	
	public class DocHelloworld extends MovieClip
	{
		
		var hello1:rect=new rect();
		public function DocHelloworld()
		{
			addChild(hello1);
			hello1.x=199;
			hello1.y=199;
			var timer:Timer=new Timer(20);
			var rand:uint=0;
			rand=Math.random()*100%4;
			var flag:uint=0;
			timer.addEventListener(TimerEvent.TIMER,startTimer);
			timer.start();
			
			function startTimer(event:TimerEvent)
			{
				if(hello1.x<=0){
					flag=Math.random()*10;
					if(flag>5)
					{rand=2;}
					else rand=0;
				}
				else if(hello1.y<=0)
				{
					flag=Math.random()*10;
					if(flag>5)
					{
						rand=0;
					}
					else rand=3;
				}
				 if(hello1.x>=468)
				{
					flag=Math.random()*10;
					if(flag>5)
					{
						rand=3;
					}
					else rand=1;
				}
				 else if(hello1.y>=354)
				{
					flag=Math.random()*10;
					if(flag>5)
					{
						rand=2;
					}
					else rand=1;
				}
				direct(rand);
			}
		
			function direct(rad:uint)
			{
				
				switch(rad)
				{
					case 0:hello1.x+=5;hello1.y+=5;break;
					case 1:hello1.x-=5;hello1.y-=5;break;
					case 2:hello1.x+=5;hello1.y-=5;break;
					case 3:hello1.x-=5;hello1.y+=5;break;
					default:break;
				}
			}
			
		}
	}
}