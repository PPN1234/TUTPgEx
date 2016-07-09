import ddf.minim.*; //minimライブラリの読み込み
import ddf.minim.analysis.*; // minim.analysisをインポート
Minim minim; //minim型の変数minimの宣言
AudioPlayer player; // AudioPlayer型の変数playerを宣言
AudioMetaData meta; //AudioMetaData型のmetaを宣言
boolean isPaused; //boolean型のisPausedを宣言
FFT fft; //FFT型の変数fftの宣言

void setup() {
  size (800, 600); //
  minim = new Minim (this); //
  player = minim.loadFile("Stressed Out.mp3", 1024); //
  meta = player.getMetaData();
  fft = new FFT (player.bufferSize(), player.sampleRate()); //

  player.play(); //
  isPaused = true; //
}

//
void mousePressed() {
  if (isPaused == false) {
    player.pause();
    isPaused = true;
  } else if (isPaused == true) {
    player.play();
    isPaused = false;
  }
}


void draw() {
  background(0);
  stroke(0, random(190, 255), random(190, 255));
  strokeWeight(3);

  fft.forward(player.mix);
  int highest = 0;

  fill(0);
  ellipse(width/2, height/2, 388,388);

  for (int k = 0; k < fft.specSize()/2.5; k++) {

    fill(0);
    line(k, height/2, k, height/2 + fft.getBand(k));
    line(k, height/2, k, height/2 - fft.getBand(k));

    line(width - k, height/2, width - k, height/2 + fft.getBand(k));
    line(width - k, height/2, width - k, height/2 - fft.getBand(k));

    fill(255);
    textSize(30);
    text("Author: " + meta.author(), width/2 - 160, height/2 - 35);
    text("Title: " + meta.fileName(), width/2 - 160, height/2 + 10);
    text(player.position()/1000/60  + ":" + player.position()/1000%60 + "/"
    + meta.length()/1000/60 + ":" + meta.length()/1000%60, width/2 - 90, height/2 + 50);

    if (fft.getBand(k) > fft.getBand(highest)) {
      highest = k;
    }
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
