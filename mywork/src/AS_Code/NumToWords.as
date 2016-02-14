package AS_Code
{
	import flash.display.Sprite;

	/// 一、对于任意一个数字串，一次输出其代表的所有的字母组合。。
	// 二、根据所给的一个单词或句子，输出其代表的手机键盘的数字。
	
	public class NumToWords extends Sprite
	{
		//用于表示老式的手机键盘上的各数字所代表的字母。
		var _allWords:Array = 
			[	[" "],
				[" "],
				["a", "b", "c"],
				["d", "e", "f"],
				["g", "h", "i"],
				["j", "k", "l"],
				["m", "n", "o"],
				["p", "q", "r", "s"],
				["t", "u", "v"],
				["w", "x", "y", "z"]		];
			
		var _total:Array = [0, 0, 3, 3, 3, 3, 3, 4, 3, 4]; //每个数字代表的字母的个数。
		
		var _number:Array = [2, 5, 4, 8, 6, 6, 9, 5];  //电话号码的每一位。表示_allWords数组中的某一行。
		
		var _answer:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];   //表示_allWords数组中的某一列。
		
		var _wordsStr:String = "computer";
		var _wordsStr_2:String = "liuyaoao";
		
		public function NumToWords()
		{
			trace("hello words !!");
//			printWordArrangeForThreeNum();
//			printWordArrangeForNNum(8);
			printWordArrangeByRecursion(_number, _answer, 0, 8);
			printNumberByWords(_wordsStr);
			printNumberByWords(_wordsStr_2);
			
		}
		/**输出所有的字母排列根据3个数字。*/
		private function printWordArrangeForThreeNum():void
		{
			for(_answer[0] = 0; _answer[0]<_total[_number[0]];_answer[0]++)
			{
				for(_answer[1] = 0; _answer[1]<_total[_number[1]];_answer[1]++)
				{
					for(_answer[2] = 0; _answer[2]<_total[_number[2]];_answer[2]++)
					{
						var i:int = 0;
						trace(""+_allWords[_number[i]][_answer[i]]+" "+_allWords[_number[i+1]][_answer[i+1]]+" "+_allWords[_number[i+2]][_answer[i+2]]);
					}
				}
			}
		}
		/**输出所有的字母排列根据N个数字。*/
		private function printWordArrangeForNNum(n:int):void
		{
			while(true){
				var temStr:String = "";
				for(var i:int=0;i<n;i++){
					temStr = temStr + _allWords[_number[i]][_answer[i]];
				}
				trace(temStr);
				var k:int= n-1;
				while(k >= 0){
					if(_answer[k]<_total[_number[k]]-1){
						_answer[k]++;
						break;
					}
					else{
						_answer[k] = 0;
						k--;
					}
				}
				if(k<0){
					break;
				}
			}
		}
		
		/**用递归的方法输出所有的字母排列根据N个数字。不知为何，_number数组中不能有0或1。*/
		private function printWordArrangeByRecursion(number:Array, answer:Array, index:int, n:int):void
		{
			if(index == n){
				var temStr:String = "";
				for(var i:int=0;i < n; i++){
					temStr = temStr + _allWords[number[i]][answer[i]];
				}
				trace(temStr);
				return;
			}
			
			for(answer[index]=0;answer[index]<_total[number[index]];answer[index]++){
				printWordArrangeByRecursion(number, answer, (index+1), n);
			}
//			trace("index:"+index);
		}
		
		/**输入一个英语单词或者一个句子，或者是拼音也行，可以输出在手机键盘上对应的数字。**/
		private function printNumberByWords(wordsStr:String):void
		{
			var temWordsArr:Array  = [];
			var temWordsEachRow:Array = [];
			var temNumStr:String = "";
			
			for(var i:int=0;i<wordsStr.length;i++){
				temWordsArr[i] = wordsStr.charAt(i);
				for(var j:int=0;j<10;j++){
					temWordsEachRow = _allWords[j];
					if(temWordsEachRow.indexOf(temWordsArr[i]) != -1){
						temNumStr = temNumStr + String(j);
						break;
					}
				}
			}
			trace(temNumStr);
		}
		
		
	}
}