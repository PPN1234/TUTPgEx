import ddf.minim.*;
boolean isPaused;
Minim minim;
AudioPlayer player;
int r;
float ix = 150;
float rad = 10;
PImage img; //画像用の変数を宣言


void setup(){
  size(800, 600);
  minim = new Minim(this);
  player = minim.loadFile("Twenty.mp3");
  player.loop();
  background(1);
  colorMode(RGB, 255);
  isPaused = true;
  img = loadImage("homuvis_kiiro.png"); //画像の読み込み
  imageMode(CENTER); //画像を中心から広がるように設定
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
  visualizer(250, width/2, height/2);
  

}

void visualizer(int r, int posx, int posy) {
  fill(0);
  noStroke();
  rect(0, 0, width, height);
  translate(posx, posy);
  noFill();

  stroke(1,100);
  int bsize = player.bufferSize();

  for (int i = 0; i < bsize; i+=200) {
    background(0); //背景を上書き
    float ir = (r + player.left.get(i)*125); //音の強さを取得して半径を足したものをirに代入
    if (ir > 250){ //半径250以下になった場合ブレないように250で固定
      image(img, 0, 0, ir, ir); //画像の貼り付け
    } else {
      image(img, 0, 0, 250, 250);
    }
  }

  for (int i = 0; i < bsize; i+=13) {
    float x = (r - 35)*cos(i*2*PI/bsize);
    float y = (r - 35)*sin(i*2*PI/bsize);
    float x2 = (r - 35 + player.left.get(i)*20)*cos(i*2*PI/bsize);
    float y2 = (r - 35 + player.left.get(i)*20)*sin(i*2*PI/bsize);
    if(x < 0){
      if(x > x2){
        stroke(150);
        strokeWeight(10);
        line(x, y, x2, y2);
      } else {
        stroke(100);
        strokeWeight(10);
        line(x, y, x, y);
      }
    } else {
      if(x < x2){
        stroke(150);
        strokeWeight(10);
        line(x, y, x2, y2);
      } else {
        stroke(100);
        strokeWeight(10);
        line(x, y, x, y);
      }
    }
  }

    beginShape();
    noFill();
    stroke(1, 70);
    for (int i = 0; i < bsize; i+=30){
      float x2 = (r + player.left.get(i)*60)*cos(i*2*PI/bsize);
      float y2 = (r + player.left.get(i)*60)*sin(i*2*PI/bsize);
      vertex(x2, y2);
      pushStyle();
      stroke(4);
      strokeWeight(2);
      point(x2, y2);
    }
    
    endShape();
}