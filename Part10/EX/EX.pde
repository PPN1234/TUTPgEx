import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;

void setup()
{
  size(640, 480);
  smooth();
  
  minim = new Minim(this);
  
 player = minim.loadFile("JKtekoki.mp3",width);  
  player.play();  
  background(0);
}

void draw()
{
  fill(0, 16);
  
  noStroke();
  rect(0, 0, width, height);
  
  stroke(155);
  noFill();
  
  float r = 0;
  for (int i = 0; i < in.bufferSize(); i++) {
    r += abs(in.mix.get(i))*20;
  }
  
  ellipse(width/4, height/4, r, r);
}

// stops player when user closes program
void stop()
{
 player.close();
  minim.stop();
  super.stop();
}