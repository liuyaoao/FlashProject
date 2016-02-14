package 
{
	import flash.display.Sprite;

	public class HeartFillSprite extends Sprite
	{
		public function HeartFillSprite()
		{
		}
		
		public function addFillFire(fire:RaiseMovie):void{
			var fillFire:RaiseMovie = new RaiseMovie(fire.fireColor);
			fillFire.rotation=fire.rotation;
//			this.parent.addChild(fillFire);
			this.addChild(fillFire);
			
//			fillFire.x = this.x + FireWorkHelper.getRandRange(1,this.width);
//			fillFire.y = this.y + FireWorkHelper.getRandRange(1,this.height);
			fillFire.x = FireWorkHelper.getRandRange(1,this.width);
			fillFire.y = FireWorkHelper.getRandRange(1,this.height);
			FireWorkHelper.setColor(fillFire,fillFire.fireColor);
			
		}
		
	}
}