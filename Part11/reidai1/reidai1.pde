import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioPlayer player;
FFT fft;

void setup(){
  size (513, 200);
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

  for(int k = 0; k < fft.specSize(); k++){
    line(k,height, k, height - fft.getBand(k));

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
