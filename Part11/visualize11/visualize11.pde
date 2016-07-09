import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioPlayer player;
AudioMetaData meta;
boolean isPaused;
FFT fft;
int r = 250;

void setup(){
  size (800, 600);
  minim = new Minim (this);
  player = minim.loadFile("SpagHeddy.mp3", 1024);
  meta = player.getMetaData();
  fft = new FFT (player.bufferSize(), player.sampleRate());

  player.play();
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

void draw(){
  background(0);
  stroke(0,random(190,255),random(190,255));
  strokeWeight(2);

  fft.forward(player.mix);
  int highest = 0;

  fill(0);
  ellipse(width/2,height/2,270,270);



  for(int k = 0; k < fft.specSize()/2.1; k++){

    line(k,height/2, k, height/2 + fft.getBand(k));
    line(k,height/2, k, height/2 - fft.getBand(k));



    line(width - k,height/2, width - k, height/2 + fft.getBand(k));
    line(width - k,height/2, width - k, height/2 - fft.getBand(k));

    fill(255);
    textSize(20);
    text("Author: " + meta.author(), width/2 - 90, height/2 - 20);
    text("Title: " + meta.fileName(), width/2 - 90, height/2);
    text(player.position()/1000/60  + ":" + player.position()/1000%60 + "/" + meta.length()/1000/60 + ":" + meta.length()/1000%60, width/2 - 90, height/2 + 20);


    if(fft.getBand(k) > fft.getBand(highest)){
      highest = k;
    }
  }
}

void stop(){
  player.close();
  minim.stop();
  super.stop();
}
