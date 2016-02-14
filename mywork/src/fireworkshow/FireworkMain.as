package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	public class FireworkMain extends Sprite
	{
		
		/**预设的一组颜色值，烟花的颜色可以从这组颜色中随机选择得出。**/
		private static const COLORS_ARR:Array = [0xff0000,0x00ff00,0x0000ff,0xffff00,0x00ffff,0xff00ff,0xffffff,0xff6633];
		/**
		 * 取颜色的面板元件。
		 */
		private var colorPanel:MovieClip;
		/**
		 * 初始化的颜色值。
		 */
		private var selColor:int = 0xff0000;
		private var txtSpeed:TextField;
		private var txtInterval:TextField;
		/**打开取色面板的一个小的颜色窗口。*/
		private var colorWindow:MovieClip;

		private var firework:Firework;
		
		public function FireworkMain() {
			this.colorPanel = this.getChildByName("mcColor") as MovieClip;
			this.colorPanel.visible = false;
			this.colorPanel.addEventListener(MouseEvent.CLICK, onClickColorPanel);
			this.txtInterval = this.getChildByName("_txtInterval") as TextField;
			this.txtSpeed = this.getChildByName("_txtSpeed") as TextField;
			this.txtInterval.restrict = "0123456789";
			this.txtSpeed.restrict = "0123456789";
			this.colorWindow = this.getChildByName("_colorWindow") as MovieClip;
			this.colorWindow.buttonMode = true;
			FireWorkHelper.setColor(this.colorWindow, this.selColor);
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}

		private function onAddedToStage(evt:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			firework = new Firework();
			MovieClip(this.getChildByName("container")).addChild(firework);
			changeProperty(this.selColor, int(txtSpeed.text), int(txtInterval.text));
			this.addEventListener(Event.ENTER_FRAME, onEnterframe);
		}

		private function onEnterframe(evt:Event):void {
			var index:int = FireWorkHelper.getRandRange(1,8) - 1;
			this.firework.color = COLORS_ARR[index];
			this.firework.update();
		}

		private function onClickColorPanel(evt:MouseEvent):void
		{
			//获取颜色表对象，由于flash中无法为位图元件命名，所以只能通过去面板
			//最上层的孩子这种恶心的方法来取得，切勿随意模仿
			var colorSheet:Bitmap = this.colorPanel.getChildAt(this.colorPanel.numChildren-1) as Bitmap;
//			trace("FireworkMain.onClickColorPanel(evt)", this.colorPanel.mouseX, this.colorPanel.mouseY);
			
			this.selColor = colorSheet.bitmapData.getPixel(this.colorPanel.mouseX, this.colorPanel.mouseY);
			FireWorkHelper.setColor(this.colorWindow, this.selColor);
		}

		private function onClick(evt:MouseEvent):void{
			switch(evt.target.name){
				case "btnApply":
					changeProperty(this.selColor, int(txtSpeed.text), int(txtInterval.text));
					break;
				
				case "_colorWindow":
				case "btnColor":
					this.colorPanel.visible = true;
					return;
			}
			this.colorPanel.visible = false;
		}
		
		/**设置烟花的颜色，速度，和发射的间隔。*/
		private function changeProperty(color:int, speed:int, density:int):void
		{
			this.firework.speed = speed;
			this.firework.color = color;
			this.firework.interval = density;
		}
		
	}
	
}