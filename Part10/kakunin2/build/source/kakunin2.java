import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class kakunin2 extends PApplet {



Minim minim;
AudioPlayer player;
float amp = 10.0f;

public void setup(){
  
  minim = new Minim(this);
  player = minim.loadFile("music.wav",width);
  player.play();
}
public void draw(){
  background(0);
  stroke(255);
  int maxL = height/2;
  float angle = 0;
  int centerX = width/2;
  int centerY  = height/2;
  for(int i=0;i<player.bufferSize();i++){
    float lineL = abs(player.left.get(i))*maxL*amp;
    float x = centerX+cos(angle)*lineL;
    float y = centerY+sin(angle)*lineL;
    line(centerX,centerY,x,y);
    angle += TWO_PI/player.bufferSize();
  }
}

public void stop(){
  player.close();
  minim.stop();
  super.stop();
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "kakunin2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
