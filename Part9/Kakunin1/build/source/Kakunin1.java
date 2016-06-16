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

public class Kakunin1 extends PApplet {

int baseTime;
boolean flag;

public void setup(){
  
  textAlign(CENTER,CENTER);
  flag = false;
  }

public void draw(){
  int now = millis();
  if(flag == false){
    baseTime = now;
    noLoop();
  }
  background(255);
  int time = now - baseTime;
  int ms = time%1000;
  int s = (time/1000)%60;
  int m = (time/1000)/60;
  textSize(60);
  fill(0);
  text(nf(m,2) + ":" + nf(s,2) + ". "+nf(ms,3),width/2,height/2-100);
  button();
}

public void mousePressed(){
  int now = millis();
  if(mouseX>=40 && mouseX<=190 && mouseY>=150 && mouseY<=200){
    if(flag == false){
      flag = true;
      baseTime = now;
      loop();
    }else{
      flag = false;
      button();
      noLoop();
      }
    }
  }
  public void button(){
    fill(0);
    rect(40,150,150,50);
    textSize(30);
    fill(255);
    if(flag == false) {
      //textAlign(115,170);
      text("start",115,170);
    }else{
      text("stop",115,170);
      //textAlign(115,170);
      //println("stop");
    }
  }
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Kakunin1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
