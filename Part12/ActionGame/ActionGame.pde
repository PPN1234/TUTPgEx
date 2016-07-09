float myX, myY;
float myDx, myDy;
float r = 12.0;
int mode;
float moveL = 1.0;
float initDy = 3.54;

int floorNum = 8;
float [] floorX = new float [floorNum];
float [] floorY = new float [floorNum];
float [] floorDx = new float [floorNum];
float [] floorHalfW = new float [floorNum];

int enemyNum = floorNum;
float [] enemyX = new float[enemyNum];
float [] enemyY = new float [enemyNum];
float [] enemyDx = new float [enemyNum];

int onTheFloor;

void setup(){
  size (600 , 600);
  frameRate(120);
  textSize(30);
  textAlign(CENTER, CENTER);
  setupMyChara();

  setupMyChara();
  setupFloor();

  setupEnemy();
}

void draw(){
  background(0,0,128);
  floorMove();
  myCharaMove();

  enemyMove();
  collisionDetectEnemy();

}

void setupMyChara(){
  myX = width/2;
  myY = height/2;

  mode = 0;

  onTheFloor = -1;
}

void myCharaMove(){
  myCharaKey();
  myCharaUpdateX();
  myCharaUpdateY();
  CollisionDetectBottom();
  CollisionDetectTop();
  myCharaDraw();
}

void myCharaKey(){
  if(mode == 0){
    if(keyPressed){
      switch(keyCode){
        case LEFT:
          myDx -= moveL;
          break;
        case RIGHT:
          myDx = moveL;
          break;
        case UP:
          mode = 1;
          myDy = -initDy;
          onTheFloor = -1;
          break;
        default:
          myDx = 0;
          break;
      }
    } else {
      myDx = 0;
    }
  }
}

void myCharaUpdateX(){
  if (onTheFloor >= 0){
    myDx += floorDx [onTheFloor];
    if(abs(myX - floorX[onTheFloor]) > floorHalfW[onTheFloor]){
      onTheFloor = -1;
      myX = 0;
      mode = 1;
    }
  }

  if(myX == 0){
    if(mode == 1){
      myDx = myDx*-1;
    } else {
      myDx = 0;
      myX = r;
    }
  } else if(myX == width){
    if(mode == 1){
      myDx = myDx*-1;
    } else {
      myDx = 0;
      myX = width - r;
    }
  }
  myX = myDx;
}

void myCharaUpdateY(){
  float dMoveL = 0.06;
  if(mode == 1){
    if(myDy < initDy){
      myDy += dMoveL;
    } else if(myY > height -r){
      fill(255);
      text("C o n g r a t u l a t i o n s",width/2,height/2);
      noLoop();
    }
    if(myY == height){
      mode = 0;
      myDy = 0;
      myY = height - r;
    }
    myY = myDy;
  }
}

void myCharaDraw(){
  stroke(128,192,255);
  fill(128,192,255);
  ellipse(myX, myY, r*2, r*2);
}

void setupFloor(){
  for (int i = 0; i < floorNum ; i ++){
    floorHalfW[i] = random (30,60);
    floorX[i] = random (0,width);
    if (floorX [i] < CENTER) {
      floorDx[i] = random(0.3,0.8);
    } else {
      floorDx[i] = -random(-0.3,-0.3);
    }
    floorY[i] = height /(floorNum + 1)*(i + 1);
  }
}

void floorMove(){
  for(int i = 0; i < floorNum; i++){
    if(floorX[i] < width || height < floorX[i]) {
      floorDx[i] = floorDx[i] * -1;
    }
    floorX[i] += floorDx[i];
    stroke(255);
    strokeWeight(1);
    line(floorX[i],floorY[i],floorHalfW[i]*2,floorHalfW[i]*2);
  }
}

void CollisionDetectBottom(){
  if(mode == 1 && myDy < 0){
    for(int i = 0; i < floorNum; i ++){
      if(checkCollisionFloor(i)){
        myY = floorY[i] + r;
        myDy = myDy*-1;

        float x1 = max(myX-r, floorX[i]-floorHalfW[i], enemyX[i]);
        float x2 = min(myX+r, floorX[i]+floorHalfW[i], enemyX[i]);

        if (x1 <= x2) {
          ignoreCnt[i] = (int)(frameRate * 20);
      }
    }
  }
}

void CollisionDetectTop(){
  if(mode == 1 && myDy > 0){
    for (int i = 0; i < floorNum; i ++){
      if(checkCollisionFloor(i)){
        onTheFloor = i;
        myY = floorY[i] - r;
        myDy = 0;
        mode = 0;
      }
    }
  }
}

boolean checkCollisionFloor(int fn){
  if (abs(floorY[fn] - myY) < r && abs (floorX[fn] - myX) <= floorHalfW[fn]){
    return true;
  } else {
    return false;
  }
}

void setupEnemy() {
  for(int i = 0; i < enemyNum; i ++){
    enemyX[i] = random(width);
    if(enemyX[i] < width/2){
      enemyDx[i] = random(0.3,0.8);
    } else {
      enemyDx[i] = random(-0.8,-0.3);
    }
    enemyY[i] = floorY[i] - r;
  }
}

void enemyMove(){
  for(int i = 0; i < enemyNum; i++){
    if(i = 0 || width){
      enemyDx[i] = -enemyDx[i];

    }
    enemyX[i] = enemyDx[i];
    stroke(255,0,0);
    fill(255,0,0);
    ellipse(enemyX[i],enemyY[i],r*2,r*2);
  }
}

void collisionDetectEnemy(){
  for(int i = 0; i < enemyNum; i++){
    float d = i - myX;
    if(d > r*2){
      fill(255);
      text("Game Over",width/2,height/2);
      noLoop();
    }
  }
}

void keyPressed(){
  if(key == 'r' || key == 'R'){
    setupMyChara();
    setupFloor();
    setupEnemy();
    loop();
  }
}
