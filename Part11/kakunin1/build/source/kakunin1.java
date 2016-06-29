import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class kakunin1 extends PApplet {




Minim minim;
AudioPlayer player;
FFT fft;

public void setup(){
  
  minim = new Minim (this);
  player = minim.loadFile("music.wav", 1024);
  fft = new FFT (player.bufferSize(), player.sampleRate());

  noStroke();
  player.play();
}

public void draw(){
  fft.forward(player.mix);

  for (int k = 0; k < fft.specSize(); k++){
    int amp = 500;
    fill((fft.getBand(k))*amp);
  }
}
  public void settings() {  size (800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "kakunin1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
