import javax.swing.*;
import java.awt.*;


public class Frame extends JFrame{
	public static String title = "Star Wars Tower Defense CSE 2102";
	public static Dimension size = new Dimension(700, 550);
	
	public Frame(){
		setTitle(title);
		setSize(size);
		setResizable(false);
		setLocationRelativeTo(null); //centers the frame on our screen
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE );
		
		init();//calls the init method
	}
	public void init(){
		setLayout(new GridLayout(1, 1, 0, 0));
		
		Window window = new Window();
		add(window);
		
		setVisible(true); //allows us to see jframe
	}
	public static void main(String args[]){
		Frame frame = new Frame(); //creates a new object frame. jumps to Frame() constructor
	}

}
