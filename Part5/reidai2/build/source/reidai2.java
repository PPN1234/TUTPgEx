import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class reidai2 extends PApplet {

public void setup(){
  
}

public void draw(){
}

public void mousePressed(){
  if(mouseButton == LEFT){
    drawRecCir();
  }
}

public void drawRecCir(){
  fill(0, 0, 255);
  rect(mouseX - 30, mouseY + 18, 60, 62);
  ellipse(mouseX,mouseY,50,50);
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "reidai2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
