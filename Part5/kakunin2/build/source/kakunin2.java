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

public class kakunin2 extends PApplet {

float x;
float y;
float i;
public void setup(){
  
  for(i = 0; i < 5; i++) {
    x = 100 + random(width/2 -150, width/2 + 150);
    y += 100;
    drawCar(x, y);
  }
}

public void drawCar(float x, float y){
  fill(0, 255, 255);
  rect(x-25, y-25, 50, 25);
  fill(255, 200, 0);
  rect(x-50, y, 100, 25);
  fill(60);
  ellipse(x-25,y+25,25,25);
  ellipse(x+25,y+25,25,25);
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "kakunin2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}