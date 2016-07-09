// 自キャラに関するグローバル変数
float myX, myY ;   // 自キャラ中央のx , y 座標
float myDx, myDy ; // 自キャラのx , y 方向の変化量
float r = 12.0;    // 自キャラ・敵キャラの半径
int mode;          // 0 : 通常モード， 1 : ジャンプモード
float moveL = 1.0; // キーボード操作によるx 方向の変化量
float initDy = 3.54;
int floorNum = 8;
float [] floorX = new float[floorNum];
float [] floorY = new float[floorNum];
float [] floorDx = new float[floorNum];
float [] floorHalfW = new float[floorNum];
int onTheFloor;
int enemyNum = floorNum;
float [] enemyX = new float[enemyNum];
float [] enemyY = new float[enemyNum];
float [] enemyDx = new float[enemyNum];
int [] ignoreCnt = new int[enemyNum];


// setup()関数
void setup() {
  size(600, 600);  // 600×600 のウィンドウを作成
  frameRate(120);  // フレームレートを120に設定
  textSize(30);    // 文字サイズを30に設定
  textAlign(CENTER, CENTER); // 文字表示位置を水平，垂直とも中央に設定
  setupMyChara();  // 自キャラの初期設定を行うsetupMyChara()の呼び出し
  setupFloor();
  setupEnemy();
}

// draw()関数
void draw() {
  background (0, 0, 128); // 背景色を(0, 0, 128)に設定　
  floorMove();
  myCharaMove();          // 自キャラの移動を行うmyCharaMove()の呼び出し
  enemyMove();
  CllisionDetectEnemy();
}

// 自キャラの初期設定を行う関数
void setupMyChara() {
  myX = width/2;       // 自キャラのx座標myXをウィンドウの中央に設定
  myY = height-r;       // 自キャラのy座標myYをウィンドウの下端に接する
  // 位置(height - r)に設定
  mode = 0; // modeを通常モード(0)に設定
  onTheFloor = -1;
}

// 自キャラの移動を行う関数
void myCharaMove() {
  myCharaKey();     // 自キャラのキーボードによる操作を行うmyCharaKey()
  // の呼び出し
  myCharaUpdateX(); // 自キャラのx座標の更新を行うmyCharaUpdateX()の呼び出し
  myCharaUpdateY();
  CollisionDetectBottom();
  CollisionDetectTop();
  myCharaDraw();    // 自キャラの表示を行うmyCharaDraw()の呼び出し
}

// 自キャラのキーボードによる操作を行う関数
void myCharaKey() {
  if (mode == 0) { // 通常モード(modeが0)ならば
    if (keyPressed) { // キーが押されていれば
      switch(keyCode) { // keyCodeの値により処理を分岐
      case LEFT: // ← キーならば
        myDx = -moveL;    // 自キャラのx方向の変化量myDxを-moveL(左向き)に設定
        break ;
      case RIGHT: // → キーならば
        myDx = moveL;    // 自キャラのx方向の変化量myDxを moveL(右向き)に設定
        break ;
      case UP:
        mode = 1;
        myDy = -initDy;
        onTheFloor = -1;
        break;
      default: // それ以外の特殊キーならば
        myDx = 0;    // 自キャラのx方向の変化量myDxを0に設定
        break ;
      }
    } else {     // キーが押されていなければ
      myDx = 0;      // 自キャラのx方向の変化量myDxを0に設定
    }
  }
}

// 自キャラのx座標の更新を行う関数
void myCharaUpdateX() {
  if (onTheFloor >= 0) {
    myDx += floorDx[onTheFloor];
    if (abs(myX - floorX[onTheFloor]) > floorHalfW[onTheFloor]) {
      onTheFloor = -1;
      myY = 0;
      mode = 1;
    }
  }
  if (myX == 0) {    // 自キャラがウィンドウの左端に到達したら
    if (mode == 1) {  // ジャンプモード(modeが1)ならば
      myDx *= -1;     // 自キャラのx方向の変化量myDxの符号を反転
    } else {    // それ以外(通常モード)ならば
      myDx = 0;     // 自キャラのx方向の変化量myDxを0に設定(移動を停止)
      myX = r;     // 自キャラのx座標myXを左端に接した位置(r)に設定
    }
  } else if (myX == width) { // 自キャラがウィンドウの右端に到達したら
    if (mode == 1) {  // ジャンプモード(modeが1)ならば
      myDx *= -1;     // 自キャラのx方向の変化量myDxの符号を反転
    } else {    // それ以外(通常モード)ならば　
      myDx = 0;     // 自キャラのx方向の変化量myDxを0に設定(移動を停止)
      myX = width - r;     // 自キャラのx座標myXを右端に接した位置(width - r)に設定
    }
  }
  myX += myDx;         // 自キャラのx座標myXをx方向の変化量myDxだけ更新
}
void  myCharaUpdateY() {
  float dMoveL = 0.06;
  if (mode == 1) {
    if (myDy < initDy) {
      myDy += dMoveL;
    }
    if (myY >= height) {
      mode = 0;
      myDy = 0;
      myY = height - r;
    } else if (myY == 0) {
      fill(255);
      text("Congratulations", width/2, height/2);
      noLoop();
    }
    myY += myDy;
  }
}

// 自キャラの表示を行う関数
void myCharaDraw() {
  stroke(128, 192, 255); // 自キャラの線の色を(128, 192, 255)に設定
  fill(128, 192, 255); // 自キャラの塗りつぶし色を(128, 192, 255)に設定
  ellipse(myX, myY, r * 2, r * 2); // (myX, myY)を中心とする半径r(直径r*2)の円を描画
}

void setupFloor() {
  for (int i = 0; i < floorNum; i++) {
    floorHalfW[i] = random(30, 60);
    floorX[i] = random(0, width);
    if (floorX[i] < width/2) {
      floorDx[i] = random(0.3, 0.8);
    } else {
      floorDx[i] = -random(0.3, 0.8);
    }
    floorY[i] = height/(floorNum+1)*(i+1);
  }
}

void floorMove() {
  for (int i = 0; i < floorNum; i++) {
    if (floorX[i] < 0 || width < floorX[i]) {
      floorDx[i] *= -1;
    }
    floorX[i] += floorDx[i];
    stroke(255);
    strokeWeight(1);
    line(floorX[i]-floorHalfW[i], floorY[i], floorX[i]+floorHalfW[i], floorY[i]);
  }
}

void CollisionDetectBottom() {
  if (mode == 1 && myDy< 0) { // ジャンプモード(modeが1)であり，
    // 自キャラのy方向の変化量myDyが負(上昇中)ならば
    for (int i= 0; i< floorNum; i++) { // 各床に対して
      if (checkCollisionFloor(i)) { // 床iと自キャラが衝突していたら
        myY= floorY[i] + r;
        // 自キャラのy座標myYを床iの下(floorY[i]+r)に設定
        myDy = myDy*-1; // 自キャラのy方向の変化量myDyの符号を反転
        float x1 = max(myX-r, floorX[i]-floorHalfW[i], enemyX[i]);
        float x2 = min(myX+r, floorX[i]+floorHalfW[i], enemyX[i]);

        if (x1 <= x2) {
          ignoreCnt[i] = (int)(frameRate * 20);
        }
      }
    }
  }
}

void CollisionDetectTop() {
  if (mode == 1 && myDy > 0) {
    for (int i = 0; i < floorNum; i++) {
      if (checkCollisionFloor(i)) {
        onTheFloor = i;
        myY = floorY[i] - r;
        mode = 0;
      }
    }
  }
}

boolean checkCollisionFloor(int fn) {
  if (abs(floorY[fn] - myY) < r && abs (floorX[fn]-myX) <= floorHalfW[fn]) {
    return true;
  } else {
    return false;
  }
}

void setupEnemy() {
  for (int i = 0; i < enemyNum; i++) {
    enemyX[i] = random(r, width-r);
    if (enemyX[i] < width/2) {
      enemyDx[i] = random(0.3, 0.8);
    } else {
      enemyDx[i] = -random(0.3, 0.8);
    }
    enemyY[i] = floorY[i]-r;
  }
}

void enemyMove() {
  for (int i = 0; i < enemyNum; i++) {
    if (enemyX[i] < r || enemyX[i] > width) {
      enemyDx[i] *= -1;
    }
    enemyX[i] += enemyDx[i];
    stroke(255, 0, 0);
    fill(255, 0, 0);
    ellipse(enemyX[i], enemyY[i], r * 2, r * 2);
  }
}

void CllisionDetectEnemy(){
  for(int i = 0; i < enemyNum; i++){
    float d = dist(enemyX[i],enemyY[i],myX,myY);
    if(d <= r * 2){
      stroke(255);
      text("Game Over",width/2,height/2);
      noLoop();
    }
  }
}

void keyPressed(){
  if(key == 'r'){
    setupMyChara();
    setupFloor();
    setupEnemy();
    loop();
  }
}
