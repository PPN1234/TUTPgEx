
void setup(){
  size(400,400);
}
void draw(){
  translate(width/2,height/2);
  strokeWeight(6);
  ellipse(0,0,300,300);
  
  strokeWeight(2);
  int i;
  for(i=0; i<=60; i++) {
    line(cos(TWO_PI/60*i)*145,sin(TWO_PI/60*i)*145,cos(TWO_PI/60*i)*150,sin(TWO_PI/60*i)*150);
  }
  strokeWeight(3);
  for(i=0; i<=11; i++) {
    line(cos(TWO_PI/12*i)*140,sin(TWO_PI/12*i)*140,cos(TWO_PI/12*i)*150,sin(TWO_PI/12*i)*150);
  }
  float s = TWO_PI / 60 * second();
  strokeWeight(1);
  line(0,0,cos(s-PI/2)*145,sin(s-PI/2)*145);
  float m = TWO_PI / 60 * minute() + s / 60;
  strokeWeight(3);
  line(0,0,cos(m-PI/2)*130,sin(m-PI/2)*130);
  float h = TWO_PI / 12 * (hour() % 12) + m /12;
  strokeWeight(5);
  line(0,0,cos(h-PI/2)*110,sin(h-PI/2)*110);
}