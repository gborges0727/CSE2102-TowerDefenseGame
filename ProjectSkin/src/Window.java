import java.awt.*;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;

import javax.swing.*;

import javax.swing.*;

public class Window  extends JPanel implements Runnable{
	public Thread thread = new Thread(this);
	
	public static Image[] tileset_ground = new Image[100];
	public static Image[] tileset_air = new Image[100];
	
	public static int myWidth, myHeight;
	public static boolean isFirst = true;
	
	public static Room room;
	
	public Window(){
		thread.start();

	}
	
	public void define(){
		room = new Room();
		
		for(int i=0;i<tileset_ground.length;i++){
			tileset_ground[i] = new ImageIcon("Stuff/Grass.png").getImage();//gets the images for the ground
			tileset_ground[i] =createImage(new FilteredImageSource(tileset_ground[i].getSource(), new CropImageFilter(0, 26*i, 26, 26)));
		}
		for(int i=0;i<tileset_air.length;i++){
			tileset_air[i] = new ImageIcon("Stuff/Grass.png").getImage();//gets the images for the air
			tileset_air[i] =createImage(new FilteredImageSource(tileset_air[i].getSource(), new CropImageFilter(0, 26*i, 26, 26)));
		}
		
	}
	
	public void paintComponent(Graphics g) {//this is where we can draw things
		if(isFirst){
			myWidth = getWidth();
			myHeight = getHeight();
			define();
			
			isFirst = false;
		}
		g.clearRect(0,  0,  getWidth(), getHeight());
		
		room.draw(g); //drawing the room
	}
	
	public void run() {//from where the program runs
		while(true) {//game loop
			if(!isFirst){
				room.physic();
			}
			repaint();
			
			try{
				Thread.sleep(1);
			} catch(Exception e){}

		}
	}
}
