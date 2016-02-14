package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	public class ChangeMousePanel extends Sprite{
		private var _mc:Sprite;
		private var _newMouseIcon:NewMouseIcon;
		
		public function ChangeMousePanel(){
			init();
		}
		
		private function init():void{
			_newMouseIcon = new NewMouseIcon();
			_mc = this["mc"];
			_mc.mouseEnabled = true;
			_mc.mouseChildren = true;
			_mc.buttonMode = true;
			_mc.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			_mc.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
//			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onMouseOver(evt:MouseEvent):void{
			var x:int = stage.mouseX;
			var y:int = stage.mouseY;
			if(!stage.hasOwnProperty(_newMouseIcon)){
				stage.addChild(_newMouseIcon);
				_newMouseIcon.x = x;
				_newMouseIcon.y = y;
				Mouse.hide();
			}
		}
		
		private function onMouseOut(evt:MouseEvent):void{
			if(stage.hasOwnProperty(_newMouseIcon)){
				Mouse.show();	
				stage.removeChild(_newMouseIcon);
			}
		}
		
		
		
		
		
		
//		private function onMouseMove(evt:MouseEvent):void{
//			if(stage.hasOwnProperty(_newMouseIcon)){
//				var x:int = stage.mouseX;
//				var y:int = stage.mouseY;
//				_newMouseIcon.x = x;
//				_newMouseIcon.y = y;
//			}
//		}
		
		
	}
}