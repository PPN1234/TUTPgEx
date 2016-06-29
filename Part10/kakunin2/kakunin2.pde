import ddf.minim.*;

Minim minim;
AudioPlayer player;
float amp = 10.0;

void setup(){
  size(800, 800);
  minim = new Minim(this);
  player = minim.loadFile("music.wav",width);
  player.play();
}
void draw(){
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

void stop(){
  player.close();
  minim.stop();
  super.stop();
}
