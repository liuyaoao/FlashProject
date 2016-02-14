package AS_Code
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class SuDoKuGame extends Sprite
	{
		private static const SIZE:int = 9;
		
		var _numArr:Array = new Array();
		var _txtNumArr:Array = new Array();
		var _coCurrent:Object = {}; 
		var _flagArr:Array = new Array();
		var _txtDiffculty:TextField;
		var _txtFailTimes:TextField;
		var _btnStart:SimpleButton;
		var _failTimes:int;
		/**
		 *数独游戏。。 
		 * @author liuyaoao
		 */		
		public function SuDoKuGame()
		{
			init();
			initComponent();
			initData();
			
		}
		
		private function init():void
		{
			_coCurrent.x = 0;
			_coCurrent.y = 0;
			TextField(this["txtName"]).text = "数独游戏";
			_txtDiffculty = this["txtDiffculty"];
			_txtFailTimes = this["txtFailTimes"];
			_btnStart = this["btnStart"];
			_btnStart.addEventListener(MouseEvent.CLICK,onClickStart);
			trace("Hi,aoliao...haha.."+_coCurrent.x+","+_coCurrent.y);
		}
		
		private function initComponent():void
		{
			for(var i:int=0;i<9;i++)
			{
				_numArr[i] = new Array();
				_flagArr[i] = new Array();
				
				_txtNumArr[i] = new Array();
				for(var j:int=0;j<9;j++)
				{
					_numArr[i][j] = 0;
					_flagArr[i][j] = 0;
					_txtNumArr[i][j] = TextField(this["txtNum_"+i+"_"+j]);
					TextField(_txtNumArr[i][j]).text = "0";
//					if(i>=j)  //给对角线一边的字体更改颜色。
//					{
//						TextField(_txtNumArr[i][j]).textColor = 0xFFFFFF;
//					}
				}
			}
		}
		
		private function onClickStart(e:MouseEvent):void
		{
			_coCurrent.x = 0;
			_coCurrent.y = 0;
			_failTimes = 0;
			for(var i:int=0;i<9;i++)
			{
				for(var j:int=0;j<9;j++)
				{
					_numArr[i][j] = 0;
					TextField(_txtNumArr[i][j]).textColor = 0x0000FF;
				}
			}
			var temDiffculty:int = parseInt(_txtDiffculty.text);
			genarateValidMatrix(_coCurrent);
			getACanPlayShuDu(temDiffculty); //输入是设置难度等级。
			initData();
		}
		
		private function initData():void //显示一个完整的数独。
		{
			_txtFailTimes.text = ""+_failTimes;
			for(var i:int=0;i<9;i++)
			{
				for(var j:int=0;j<9;j++)
				{
					if(_numArr[i][j] == 0)
					{
						TextField(_txtNumArr[i][j]).text = "";
					}
					else
					{
						TextField(_txtNumArr[i][j]).text = _numArr[i][j]+"";
						TextField(_txtNumArr[i][j]).textColor = 0xFFFFFF;
					}
				}
			}
		}
		/**产生一个完整的数独矩阵。*/
		private function genarateValidMatrix(temCurrent:Object):void
		{
			var validArr:Array;
			var coCurrent:Object;
			coCurrent = temCurrent;
		while(true){
			
		
			validArr = getValidValueList(coCurrent);
			if(validArr.length>0 && _flagArr[coCurrent.x][coCurrent.y]<8)//
			{
				var temIndex:int = int(getRandomFromMINToMAX(0,validArr.length-1));
				_numArr[coCurrent.x][coCurrent.y] = validArr[temIndex];  //
				trace("_numArr["+coCurrent.x+"]["+coCurrent.y+"]:"+_numArr[coCurrent.x][coCurrent.y]);
				if(coCurrent.x == SIZE - 1 && coCurrent.y == SIZE - 1)
				{
					break;
				}
				else
				{
					coCurrent = nextCoord(temCurrent);
				}
			}
			else
			{
				if(coCurrent.x == 0 && coCurrent.y == 0)
				{
					break;
				}
				else
				{
					for(var i:int=0;i<=coCurrent.x+1;i++)
					{
						for(var j:int=0;j<=coCurrent.y+1;j++)
						{
							_numArr[i][j]=0;
						}
					}
					coCurrent.x =0;coCurrent.y =0;
					_failTimes++;
				}
			}
		}
		}
		/**得到某个点可放置的有效的全部数字组成的数组。*/
		private function getValidValueList(coCurrent:Object):Array
		{
			var temValueList:Array = [1, 2, 3, 4, 5, 6, 7, 8, 9];
			var temHasNumRow:int = 0;
			for(var i:int=0;i<9;i++)
			{
				if(temValueList.indexOf(_numArr[coCurrent.x][i]) != -1)
				{
					temValueList.splice(temValueList.indexOf(_numArr[coCurrent.x][i]),1);
				}
				if(temValueList.indexOf(_numArr[i][coCurrent.y]) != -1)
				{
					temValueList.splice(temValueList.indexOf(_numArr[i][coCurrent.y]),1);
				}
			}
			trace("Before_coCurrent:"+coCurrent.x+","+coCurrent.y+";validArr:"+temValueList.length);
			temValueList = deleteRepeatNumInSquareNine(temValueList, coCurrent);
			trace("After_coCurrent:"+coCurrent.x+","+coCurrent.y+";validArr:"+temValueList.length);
			return temValueList;
		}
		
		/**删除该点对应的小九宫格里已有的重复的数。*/
		private function deleteRepeatNumInSquareNine(valueList:Array, coCurrent:Object):Array
		{
			var temX:int = int(coCurrent.x/3) * 3;
			var temY:int = int(coCurrent.y/3) * 3;
			var temValueList:Array;
			temValueList = valueList;
			if(temValueList.length == 0)
			{
				return temValueList;
			}
			for(var i:int=0;i<3;i++)
			{
				for(var j:int=0;j<3;j++)
				{
					if(temValueList.indexOf(_numArr[temX+i][temY+j]) != -1)
					{
						temValueList.splice(temValueList.indexOf(_numArr[temX+i][temY+j]),1);
					}
				}
			}
			return temValueList;
		}
		
		/**得到一个从min到max之间的随机数。*/
		private function getRandomFromMINToMAX(min:int ,max:int):int
		{
			var randomNum:int = Math.floor(Math.random()*(max - min + 1)) + min;
			return randomNum;
		}
		
		private function nextCoord(coCurrent:Object):Object
		{
			var temCurrent:Object = coCurrent;
			if(coCurrent.y >= 8)
			{
				if(coCurrent.x >= 8)
				{
					temCurrent = coCurrent;
				}
				else
				{
					temCurrent.x = coCurrent.x + 1;
					temCurrent.y = 0;
				}
			}
			else
			{
				temCurrent.x = coCurrent.x;
				temCurrent.y = coCurrent.y + 1;
			}
			return temCurrent;
		}
		
		private function prevCoord(coCurrent:Object):Object
		{
			var temCurrent:Object = {};
			if(coCurrent.y <= 0)
			{
				temCurrent.x = coCurrent.x - 1;
				temCurrent.y = 8;
			}
			else
			{
				temCurrent.x = coCurrent.x;
				temCurrent.y = coCurrent.y - 1;
			}
			return temCurrent;
		}
		
		/**设置难度等级。*/
		private function getACanPlayShuDu(diffculty:int):void
		{
			if(diffculty>4){
				diffculty = 4;
			}
			var temClearNum:int = diffculty*20;
			var temClearPoint:int;
			for(var i:int=0;i<temClearNum;i++)
			{
				temClearPoint = getRandomFromMINToMAX(0,80);
				_numArr[int(temClearPoint/9)][int(temClearPoint%9)] = 0; 
			}
		}
		
		
	/////////////////////////	
	}
}