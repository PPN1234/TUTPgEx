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

public class kakunin extends PApplet {



Minim minim;
AudioPlayer player;
float amp = 10.0f;

public void setup(){
  
  minim = new Minim(this);
  player = minim.loadFile("leftright.wav",width);
  player.play();
}

public void draw(){
  background(0);
  colorMode(HSB,2.0f,255,255);
  for(int i=0;i<player.bufferSize();i++){
    drawLine(i,player.left.get(i),player.right.get(i));
  }
}

public void drawLine(int i,float left,float right){
  float colorLeft = min(left*amp+1,2.0f);
  float colorRight = min(right*amp+1,2.0f);
  float leftPos = 200+left*50*amp;
  float rightPos = 600+right*50*amp;
  stroke (colorLeft,255,255);
  line(i,leftPos,random(i-50,i+50),random(leftPos-50,leftPos+50));
  line(i,rightPos,random(i-50,i+50),random(rightPos-50,rightPos+50));
}

public void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "kakunin" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
