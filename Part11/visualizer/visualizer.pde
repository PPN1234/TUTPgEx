import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioPlayer player;
FFT fft;

void setup(){
  size (800, 800);
  minim = new Minim (this);
  player = minim.loadFile("music.wav", 1024);
  fft = new FFT (player.bufferSize(), player.sampleRate());

  noStroke();
  player.play();
}

void draw(){
  fft.forward(player.mix);


  for(int k = 0; k < fft.specSize(); k++){
    int amp = 1000;
    fill((fft.getBand(k))*amp);
    ellipse(width/2,height/2,fft.specSize()-k,fft.specSize()-k);
  }
}

void stop(){
  player.close();
  minim.stop();
  super.stop();
}
