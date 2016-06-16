int baseTime;
boolean flag;

void setup() {
  size(400, 400);
  textAlign(CENTER,CENTER);
  flag = false;

}

void draw() {
  background(255);
  int now = millis();

  if(flag == false){
    baseTime = now;
    noLoop();
  }
  int time = now - baseTime;
  int ms = now % 1000;
  int s = now / 1000 % 60;
  int m = now / 1000 / 60;

  textSize(60);
  fill(0);
  text(nf(m,2) + ":" + nf(s,2) + "." + nf(ms,3), width/2, height/2-100);

  button();
}

void mousePressed() {
  int now = millis();

  if(mouseX > 40 && mouseX < 190 && mouseY > 150 && mouseY < 200){
    if(flag == false){
      flag = true;
      baseTime = now;
      loop();
    } else {
      flag = false;
      button();
      noLoop();
    }
  }
}

void button() {
  fill(0);
  rect(40, 150, 150, 50);
  textSize(30);
  fill(255);
  if(flag == false){
    text("start", 115, 170);
  } else {
    text("stop", 115, 170);
  }

}
