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

public class hatten1 extends PApplet {

public void setup(){
  
  noStroke();
}

public void draw(){
  background(0);
  fill(0,255,0);

int  h = hour();
int  m = minute();
int  s = second();


   dD(60,height/2-45,h/10);
   dD(160,height/2-45,h%10);
   ellipse(260,height/2+20,10,10);
   ellipse(260,height/2-20,10,10);
   dD(330,height/2-45,m/10);
   dD(430,height/2-45,m%10);
   ellipse(555,height/2+20,10,10);
   ellipse(555,height/2-20,10,10);
   dD(600,height/2-45,s/10);
   dD(700,height/2-45,s%10);
}



public void dD(int x, int y,int n){
    int[][] digit ={{1,1,1,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,1,1,1},//0
                    {0,0,0,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1},//1
                    {1,1,1,1,
                     0,0,0,1,
                     0,0,0,1,
                     1,1,1,1,
                     1,0,0,0,
                     1,0,0,0,
                     1,1,1,1},//2
                     {1,1,1,1,
                     0,0,0,1,
                     0,0,0,1,
                     1,1,1,1,
                     0,0,0,1,
                     0,0,0,1,
                     1,1,1,1},//3
                     {1,0,0,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,1,1,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1},//4
                     {1,1,1,1,
                     1,0,0,0,
                     1,0,0,0,
                     1,1,1,1,
                     0,0,0,1,
                     0,0,0,1,
                     1,1,1,1},//5
                     {1,1,1,1,
                     1,0,0,0,
                     1,0,0,0,
                     1,1,1,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,1,1,1},//6
                     {1,1,1,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1,
                     0,0,0,1},//7
                     {1,1,1,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,1,1,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,1,1,1},//8
                     {1,1,1,1,
                     1,0,0,1,
                     1,0,0,1,
                     1,1,1,1,
                     0,0,0,1,
                     0,0,0,1,
                     1,1,1,1}};//9

int d = 15;
for(int i = 0; i <28; i++){
  if(digit[n][i] ==1){
ellipse(x+i%4*d,y+i/4*d,10,10);
  }else{
    ellipse(x+i%4*d,y+i/4*d,2,2);

  }
}
}
  public void settings() {  size(800,300); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "hatten1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
