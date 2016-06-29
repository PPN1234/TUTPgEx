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

public class StopWatch extends PApplet {

int baseTime;
int totalTime;
boolean flag;

public void setup() {
  
  textAlign(CENTER,CENTER);
  flag = false;

}

public void draw() {
  int now = millis();
  background(255);

  if(flag == false){
    baseTime = now;
    noLoop();
  }
  int time = totalTime + now - baseTime;
  int ms = time % 1000;
  int s = time / 1000 % 60;
  int m = time / 1000 / 60;

  textSize(60);
  fill(0);
  text(nf(m,2) + ":" + nf(s,2) + "." + nf(ms,3), width/2, height/2-100);

  button();
}

public void mousePressed() {
  int now = millis();

  if(mouseX > 40 && mouseX < 190 && mouseY > 150 && mouseY < 200){
    if(flag == false){
      flag = true;
      baseTime = now;
      loop();
    } else {
      flag = false;
      totalTime = now - baseTime;
      button();
      noLoop();
    }
  } else if(mouseX > 220 && mouseX < 370 && mouseY > 150 && mouseY < 200){
    if(flag == false){
      totalTime = 0;
      loop();
    }
  }
}

public void button() {
  fill(0);
  rect(40, 150, 150, 50);
  rect(220, 150, 150, 50);
  textSize(30);
  fill(255);
  if(flag == false){
    text("start", 115, 170);
    text("reset", 295, 170);
  } else {
    text("stop", 115, 170);
  }

}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "StopWatch" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
