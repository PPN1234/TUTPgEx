int baseTime;
int totalTime;
boolean flag;

void setup() {
  size(400, 400);
  textAlign(CENTER,CENTER);
  flag = false;

}

void draw() {
  int now = millis();
  background(255);

  if(flag == false){
    baseTime = now;
    noLoop();
  }
  int time = totalTime + now - baseTime;
  int ms = time % 1000;
  int s = time / 1000 % 60;
  int m = time / 1000 / 60;

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
      totalTime = now - baseTime;
      button();
      noLoop();
    }
  } else if(mouseX > 220 && mouseX < 370 && mouseY > 150 && mouseY < 200){
    if(flag == false){
      totalTime = 0;
      loop();
    }
  }
}

void button() {
  fill(0);
  rect(40, 150, 150, 50);
  rect(220, 150, 150, 50);
  textSize(30);
  fill(255);
  if(flag == false){
    text("start", 115, 170);
    text("reset", 295, 170);
  } else {
    text("stop", 115, 170);
  }

}
