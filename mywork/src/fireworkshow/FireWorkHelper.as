package 
{
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;

	public class FireWorkHelper
	{
		public function FireWorkHelper()
		{
		}
		
		/**得到（min, max）范围之类的某一个值。*/
		public static function getRandRange(min:Number, max:Number):Number { 
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min; 
			return randomNum; 
		} 

		/***设置某一显示对象的颜色值。*/
		public static function setColor(target:DisplayObject, color:int):void
		{
			var r:int = (color >> 16);
			var g:int = ((color >> 8) % 0x100);
			var b:int = (color % 0x100);
			
			target.transform.colorTransform = new ColorTransform(0,0,0,1,r,g, b);
		}
		
		
		
		
	}
}