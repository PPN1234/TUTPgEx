import ddf.minim.*;
boolean isPaused;
Minim minim;
AudioPlayer player;
PImage img, img2;
int r;
float ix = 150;
float rad = 10;

void setup(){
  size(800, 600);
  minim = new Minim(this);
  player = minim.loadFile("Unicorn.mp3");
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
  //visualizer(250, width/2, height/2);
  visualizer(150, width/2, height/2);

}

void visualizer(int r, int posx, int posy) {
  fill(0);
  noStroke();
  rect(0, 0, width, height);
  translate(posx, posy);
  noFill();
  img = loadImage("homuvis.png");
  imageMode(CENTER);
  //img2 = loadImage("homutaroooo.png");

  stroke(1,100);
  int bsize = player.bufferSize();

  for (int i = 0; i < bsize; i++)
  {
    /*
    float x = (r)*cos(i*2*PI/bsize);
    float y = (r)*sin(i*2*PI/bsize);
    float x2 = (r + player.left.get(i)*60)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*60)*sin(i*2*PI/bsize);
    if(x < 0){
      if(x > x2){
        line(x, y, x2, y2);
      } else {
        line(x, y, x, y);
      }
    } else {
      if(x < x2){
        line(x, y, x2, y2);
      } else {
        line(x, y, x, y);
      }
    }
    */
    if(i % 60 == 0){
      background(0);
      float ix = (r + 160 + player.left.get(i)*60);
      if (ix > 250){
        image(img, 0, 0, ix, ix);
      } else {
        image(img, 0, 0, 250, 250);
      }
    }

  }

}
