import java.awt.*;

public class Block extends Rectangle {
	public int groundID;
	public int airID;
	
	public Block(int x, int y, int width, int height, int groundID, int airID){
		setBounds(x, y, width, height);
		this.groundID = groundID; //set id number to public id thingy above
		this.airID = airID;
	}
	
	public void draw(Graphics g) {
		g.drawImage(Window.tileset_ground[groundID], x, y, width, height, null);
		
		if(airID != Value.airAir);
	}
}
