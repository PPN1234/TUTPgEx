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

public class StopWatchEx extends PApplet {

int lapBaseTime;
int totalLap;
int lapID;
int baseTime;
int totalTime;
boolean flag;
int [] lapTimes = new int [5];

public void setup() {
  
  textAlign(CENTER,CENTER);
  flag = false;
}

public void draw() {
  background(255);
  int now = millis();
  if(flag == false){
    lapBaseTime = now;
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
  int ltime = totalLap + now - lapBaseTime;
  int lms = ltime%1000;
  int ls = ltime/1000%60;
  int lm = ltime/1000/60;
  textSize(30);
  text(nf(lm,2) + ":" + nf(ls, 2) + "." + nf(lms,3), width/2+80, height/2-150);
  button();
  showLap();
}

public void mousePressed() {
  int now = millis();

  if(mouseX > 40 && mouseX < 190 && mouseY > 150 && mouseY < 200){
    if(flag == false){
      flag = true;
      baseTime = now;
      lapBaseTime = now;
      loop();
    } else {
      flag = false;
      totalTime = totalTime+now - baseTime;
      totalLap = totalLap+now - lapBaseTime;
      button();
      noLoop();
    }
  } else if(mouseX > 220 && mouseX < 370 && mouseY > 150 && mouseY < 200){
    if(flag == false){
      totalTime = 0;
      totalLap = 0;
      lapID = 0;
      loop();
    } else {
      for(int i = 4; i >0; i--){
        lapTimes[i] = lapTimes[i-1];
      }
      lapTimes[0] = totalLap + now - lapBaseTime;

      lapBaseTime = now;
      totalLap = 0;
      lapID ++;

      println("LapID" + lapID);
      println("totalLap" + totalLap);
      println("lapBaseTime" + lapBaseTime);
      println("lapTimes" + lapTimes[0] + "lapTimes" + lapTimes[1] + "lapTimes" + lapTimes[3]);
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
    text("lap", 295, 170);
  }
}

public void showLap(){
  textSize(24);
  fill(0);
  for(int i=0; i<min(5,lapID); i++){
    int lms = lapTimes[i]%1000;
    int ls = (lapTimes[i]/1000)%60;
    int lm = (lapTimes[i]/1000)/60;
    text("lap" + nf(lapID-i,2) + " " + nf(lm,2) + ":" + nf(ls,2) + "." + nf(lms,3), width/2, 240+i*30);
  }
}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "StopWatchEx" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
