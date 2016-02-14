package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class BubbleSortTest extends Sprite
	{
		var _txtInput:TextField;
		var _txtOutput:TextField;
		public function BubbleSortTest()
		{
			init();
		}
		
		private function init():void{
			trace("hello world!");
			_txtInput = this["txt_input"];
			_txtOutput = this["txt_output"];
			_txtInput.text = "";
			_txtOutput.text = "";
			var arrSorted:Array = guessGuessLook([9,5,6,4,2,8,3,1]);
			trace(arrSorted.join());
			this["btn_start"].addEventListener(MouseEvent.CLICK,onClickStart);
		}
		
		private function onClickStart(evt:MouseEvent):void{
			trace(_txtInput.text);
			var temStr:String = _txtInput.text.toString();
			var temArr:Array = temStr.split(",");
//			var temArr:Array = _txtInput.text.split(",");
			for(var i:int=0;i<temArr.length;i++){
//				trace(temArr[i]);
				temArr[i] = parseInt(temArr[i]);
			}
			var arrSorted:Array = guessGuessLook(temArr); //这里传进去的还是一个字符串数组。
			trace(arrSorted.join());
			_txtOutput.text = arrSorted.join();
		}
		
		/**首先，要确保数组是整形或者浮点型的数值数组。不然会有问题。*/
		private function guessGuessLook(arr:Array):Array  {
			var j:int = 1;
			for (var i:int = 0; i < arr.length; i++) { //如果这里传进来的是一个字符串数组，那么如果不
				if (arr[i] > arr[j]) {	////强制转型成整形就会以字符串的形式来比较大小。
					arr[i] += arr[j];
					arr[j] = arr[i] - arr[j];
					arr[i] -= arr[j];
				}          
				if (i == j - 1) {              
					i = -1;
					j++;
					if (j >= arr.length) {
						break;
					}
				}
			}
			return arr;			
		}
		
		
	}
}