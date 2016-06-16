void setup(){
  size(320,150);
  textSize(60);
  textAlign(CENTER,CENTER);
}

void draw(){
  int h = hour();
  int m = minute();
  int s = second();
  
  background(255);
  fill(0);
  text(nf(h,2) + ":" + nf(m,2) + ":" + nf(s,2), width/2,height/2);
  
}

  
