import ddf.minim.*;

Minim minim;
AudioPlayer player;
float amp = 10.0;

void setup() {
  size(800, 800);
  minim = new Minim(this);
  player = minim.loadFile("music.wav",width);
  player.play();
}

void draw(){
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

void drawPoint(int i,float left,float right){
    float leftPos = 200+left*50*amp;
    float rightPos = 600+right*50*amp;
    point(i,leftPos);
    point(i,rightPos);
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
