import ddf.minim.*;
boolean isPaused;
Minim minim;
AudioPlayer player;
AudioMetaData meta;
int  r = 200;
float rad = 70;

void setup(){
  size(800, 600);
  minim = new Minim(this);
  player = minim.loadFile("Unicorn.mp3");
  meta = player.getMetaData();
  player.loop();
  background(1);
  colorMode(RGB, 1);
  isPaused = true;
}

void mousePressed() {
  if(isPaused == false){
    player.pause();
    isPaused = true;
  }

  else if(isPaused == true){
    player.play();
    isPaused = false;
  }
}

void draw() {
  visualizer(250, width/2, height/2);
  //visualizer(250, width/2, height/2);
/*
  textSize(30);
  fill(#ffffff,10);
  fill(255, 0, 0, 153);
  rect(700, 400, 800, 200);

  text("Title:" + meta.title(),-600,-400);
  text("Artist:" + meta.author(),-600,-375);
*/
}

void visualizer(int r, int posx, int posy) {
  fill(0);
  noStroke();
  rect(0, 0, width, height);
  translate(posx, posy);
  noFill();

  stroke(1,100);
  int bsize = player.bufferSize();
  for (int i = 0; i < bsize - 1; i+=5)
  {
    float x = (r)*cos(i*2*PI/bsize);
    float y = (r)*sin(i*2*PI/bsize);
    float x2 = (r + player.left.get(i)*50)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*50)*sin(i*2*PI/bsize);
    line(x, y, x2, y2);
  }
  beginShape();
  noFill();
  stroke(1, 70);
  for (int i = 0; i < bsize; i+=30)
  {
    float x2 = (r + player.left.get(i)*10)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*10)*sin(i*2*PI/bsize);
    vertex(x2, y2);
    pushStyle();
    stroke(200);
    strokeWeight(2);
    point(x2, y2);
  }
  endShape();
}
