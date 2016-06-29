import ddf.minim.*;

Minim minim;
AudioPlayer player;
float amp = 10.0;

void setup(){
  size(800, 800);
  minim = new Minim(this);
  player = minim.loadFile("leftright.wav",width);
  player.play();
}

void draw(){
  background(0);
  colorMode(HSB,2.0,255,255);
  for(int i=0;i<player.bufferSize();i++){
    drawLine(i,player.left.get(i),player.right.get(i));
  }
}

void drawLine(int i,float left,float right){
  float colorLeft = min(left*amp+1,2.0);
  float colorRight = min(right*amp+1,2.0);
  float leftPos = 200+left*50*amp;
  float rightPos = 600+right*50*amp;
  stroke (colorLeft,255,255);
  line(i,leftPos,random(i-50,i+50),random(leftPos-50,leftPos+50));
  line(i,rightPos,random(i-50,i+50),random(rightPos-50,rightPos+50));
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
