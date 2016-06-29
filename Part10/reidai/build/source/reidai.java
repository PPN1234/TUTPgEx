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

public class reidai extends PApplet {



Minim minim;
AudioPlayer player;
float amp = 10.0f;

public void setup() {
  
  minim = new Minim(this);
  player = minim.loadFile("music.wav",width);
  player.play();
}

public void draw(){
  background(0);
  stroke(255);
  fill(255);
  textSize(30);
  text("L",50,100);
  line(0,200,width,200);
  text("R",50,500);
  line(0,600,width,600);
  for(int i=0;i<player.bufferSize();i++){
    drawPoint(i,player.left.get(i),player.right.get(i));
  }
}

public void drawPoint(int i,float left,float right){
    float leftPos = 200+left*50*amp;
    float rightPos = 600+right*50*amp;
    point(i,leftPos);
    point(i,rightPos);
}

public void stop() {
  player.close();
  minim.stop();
  super.stop();
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "reidai" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
