import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioPlayer player;
FFT fft;

void setup(){
  size (800, 200);
  minim = new Minim (this);
  player = minim.loadFile("../sounddata/music.wav", 1024);
  fft = new FFT (player.bufferSize(), player.sampleRate());

  player.play();
}

void draw(){
  background(255);
  stroke(0);

  fft.forward(player.mix);
  int highest = 0;

  for(int k = 0; k < fft.specSize() +200; k+=21){
    stroke(random(255),random(255),random(255));
    strokeWeight(20);
    if(fft.getBand(k)*10 > 1){
      line(k,height, k, height - fft.getBand(k)*10);
    }
    println(fft.getBand(k)*10);

    if(fft.getBand(k) > fft.getBand(highest)){
      highest = k;
    }
  }
  text(highest*player.sampleRate()/player.bufferSize(),100, 20);
}

void stop(){
  player.close();
  minim.stop();
  super.stop();
}
