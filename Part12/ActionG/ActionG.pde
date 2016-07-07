float myX, myY; // 自キャラ中央のx, y座標
float myDx, myDy; // 自キャラのx, y方向の変化量
float r = 12.0;
float initDy = 3.54;// 自キャラ・敵キャラの半径
int mode; // 0 : 通常モード，1 : ジャンプモード
float moveL= 1.0; // キーボード操作によるx方向の変化量
int floorNum= 8; // 床の数
float [] floorX= new float [ floorNum]; // 床のx 座標
float [] floorY= new float [ floorNum]; // 床のy 座標
float [] floorDx= new float [ floorNum]; // 床のx 方向の変化量
float [] floorHalfW= new float [ floorNum];
int enemyNum= floorNum; // 敵の数
float [] enemyX= new float[enemyNum]; // 敵のx座標
float [] enemyY= new float[enemyNum]; // 敵のy座標
float [] enemyDx= new float[enemyNum]; // 敵のx方向の変化量
// 床の幅の半分の長さ
int onTheFloor;
int[] ignoreCnt = new int [enemyNum];
void setup() {
  size(600, 600); // 600×600のウィンドウを作成
  frameRate(120); // フレームレートを120に設定
  textSize(30); // 文字サイズを30に設定
  textAlign(CENTER, CENTER);
  // 文字表示位置を水平，垂直とも中央に設定
  setupMyChara();
  // 自キャラの初期設定を行うsetupMyChara()の呼び出し
  setupFloor();
  setupEnemy();
}

void draw() {
  background(0, 0, 128); // 背景色を(0, 0, 128)に設定
  floorMove();
  myCharaMove(); // 自キャラの移動を行うmyCharaMove()の呼び出し
  enemyMove(); // 敵の移動を行うenemyMove()の呼び出し
  collisionDetectEnemy();
  // 衝突判定を行うcollisionDetectEnemy()の呼び出し
}
// 自キャラの初期設定を行う関数
void setupMyChara() {
  onTheFloor= -1; // onTheFloorを床の上にいない状態(-1)に設定
  myX = width/2; // 自キャラのx座標myXをウィンドウの中央に設定
  myY = height-r ; // 自キャラのy座標myYをウィンドウの下端に接する
  // 位置(height-r)に設定

  mode = 0; // modeを通常モード(0)に設定
}
// 自キャラの移動を行う関数
void myCharaMove() {
  myCharaKey();
  CollisionDetectBottom();
  CollisionDetectTop();
  // 自キャラのキーボードによる操作を行うmyCharaKey()の呼び出し
  myCharaUpdateX();
  myCharaUpdateY();
  // 自キャラのx座標の更新を行うmyCharaUpdateX()の呼び出し
  myCharaDraw(); // 自キャラの表示を行うmyCharaDraw()の呼び出し
}


void myCharaKey() {
  if (mode == 0) { // 通常モード(modeが0)ならば
    if (keyPressed) { // キーが押されていれば
      switch(keyCode) { // keyCodeの値により処理を分岐
      case  LEFT: // ←キーならば
        myDx = -moveL;
        break;
        // 自キャラのx方向の変化量myDxを-moveL(左向き)に設定
      case RIGHT: // →キーならば
        myDx = moveL;
        // 自キャラのx方向の変化量myDxをmoveL(右向き)に設定
        break;
      case UP:
        mode = 1;
        myDy = -initDy;
        onTheFloor = -1;
        break;
      default: // それ以外の特殊キーならば
        myDx = 0; // 自キャラのx方向の変化量myDxを0に設定
        break;
      }
    } else { // キーが押されていなければ
      myDx = 0; // 自キャラのx方向の変化量myDxを0に設定
    }
  }
}


void myCharaUpdateX() {
  if (onTheFloor >= 0) {
    myDx += floorDx[onTheFloor];
    if (abs(myX-floorX[onTheFloor]) >=floorHalfW[onTheFloor] ) {
      // 自キャラが乗っている床から離れたら(自キャラと乗っている床の中心
      // との距離abs(myX-floorX[onTheFloor])がその床の幅の半分の
      // 長さfloorHalfW[onTheFloor]以上になったら)

      onTheFloor= -1;
      // onTheFloorを床の上にいない状態(-1)に設定
      myDy = 0; // 自キャラのy方向の変化量を0に設定
      mode =1; // modeをジャンプモード(1)に設定
    }
  }
  if (myX <= 0) { // 自キャラがウィンドウの左端に到達したら
    if (mode == 1) { // ジャンプモード(modeが1)ならば
      myDx = myDx*-1; // 自キャラのx方向の変化量myDxの符号を反転
    } else { // それ以外(通常モード)ならば
      myDx = 0; // 自キャラのx方向の変化量myDxを0に設定
      // (移動を停止)
      myX = r;
      // 自キャラのx座標myXを左端に接した位置(r)に設定
    }
  } else if (myX == width) { // 自キャラがウィンドウの右端に到達したら
    if ( mode == 1) { // ジャンプモード(modeが1)ならば
      myDx = myDx*-1; // 自キャラのx方向の変化量myDxの符号を反転
    } else { // それ以外(通常モード)ならば
      myDx = 0; // 自キャラのx方向の変化量myDxを0に設定
      // (移動を停止)
      myX = width-r; // 自キャラのx座標myXを右端に接した位置
      // (width-r)に設定
    }
  }


  myX += myDx; // 自キャラのx座標myXをx方向の変化量myDxだけ更新
}

void myCharaUpdateY() {
  float dMoveL = 0.06;
  if (mode == 1) {
    if (myDy<initDy) {
      myDy+=dMoveL;
    }
    if (myY > height-r) {
      mode = 0;
      myDy = 0;
      myY = height-r;
    } else if (myY <0) {
      fill(255);
      text("Congratulations", width/2, height/2);
      noLoop();
    }
    myY += myDy;
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
  if (mode == 1 && myDy> 0) { // ジャンプモード(modeが1)であり，
    // 自キャラのy方向の変化量myDyが正(下降中) ならば
    for (int i= 0; i< floorNum; i++) { // 各床に対して
      if (checkCollisionFloor(i)) { // 床iと自キャラが衝突していたら
        onTheFloor = i; // onTheFloorをiに設定
        myY= floorY[i] -r;
        // 自キャラのy座標myYを床iの上(floorY[i]-r)に設定
        myY =floorY[i]-r;
        mode = 0;
      }
    }
  }
}
boolean checkCollisionFloor(int fn) {
  if (abs(floorY[fn]-myY) < r
    && abs(floorX[fn]-myX) <= floorHalfW[fn]) {
    // 床fnと自キャラのy座標の距離が自キャラの半径r未満
    // かつ床fnと自キャラのx座標の距離が床fnの幅の半分
    // floorHalfW[fn]未満ならば
    return true; // trueを返す
  } else { // それ以外ならば
    return false; // falseを返す
  }
}
// 自キャラのy方向の変化量を0に設定(移動を停止)
void setupFloor() {
  for (int i = 0; i<floorNum; i++) {
    floorHalfW[i] = random(30, 60 );
    // 床iの幅の半分floorHalfW[i]を30～60の範囲でランダムに決定
    floorX[i] = random (0, width);
    // 床iのx座標floorX[i]をウィンドウにおさまる範囲でランダムに決定
    if (floorX[i] <CENTER ) {
      floorDx[i] = random(0.3, 0.8 );
      // 床iのx方向の変化量floorDx[i]を0.3～0.8の範囲で
      // ランダムに決定
    } else { // それ以外の場合は
      floorDx[i] = -random(-0.8, -0.3 );
      // 床iの方向の変化量floorDx[i]を－0.8～－0.3の範囲で
      // ランダムに決定
    }
    floorY[i] = height/(floorNum+1)*(i+1);
    // 床iのy座標floorY[i]をウィンドウの高さを(floorNum+1)
    // 等分した位置に設定
  }
}
void setupEnemy() {
  for (int i= 0; i< enemyNum; i++) { // すべての敵に対して
    enemyX[i]=random(r, width-r); // 敵iのx座標enemyX[i]をウィンドウにおさまる
    // 範囲でランダムに決定
    if (enemyX[i]<width/2) {
      // 敵iのx座標enemyX[i]がウィンドウの中央より左にあれば
      enemyDx[i] =random(0.3, 0.8) ;
      // 敵iのx方向の変化量enemyDx[i]を
      // 0.3～0.8の範囲でランダムに決定
    } else {
      enemyDx[i]=-random(0.3, 0.8);
    }
    enemyY[i] = floorY[i]-r;
    ignoreCnt[i] = 0;
  }
}

void enemyMove() {
  for (int i= 0; i< enemyNum; i++) { // すべての敵に対して
    if ( enemyX[i]<r||enemyX[i] >width-r ) {
      // 敵iが左端または右端に到達したら
      enemyDx[i] = enemyDx[i]*-1; // 敵iのx方向の変化量enemyDx[i]の符号を反転
    }
    enemyX[i]+=enemyDx[i];
    if (ignoreCnt[i]>0) {
      stroke(255, 0, 0);
      noFill();
      ignoreCnt[i]-=1;
    } else {
      stroke(255, 0, 0);
      fill(255, 0, 0);
    }
    ellipse(enemyX[i], enemyY[i],r*2,r*2);
  }
}
void collisionDetectEnemy() {
  for (int i= 0; i< enemyNum; i++) { // すべての敵に対して
    float d = dist(myX, myY, enemyX[i], enemyY[i]); // 敵iと自キャラの距離dを計算
    if (d < r*2 && ignoreCnt[i] == 0) { // 距離dがr*2以下なら
      fill(255);
      text("Game Over", width/2, height/2);
      noLoop(); // 繰り返しを停止
    }
  }
}
void keyPressed() {
  if (key=='r') { // 'r'が押されたら
    setupMyChara();
    // 自キャラの初期設定を行うsetupMyChara()の呼び出し
    setupFloor(); // 床の初期設定を行うsetupFloor()の呼び出し
    setupEnemy(); // 敵の初期設定を行うsetupEnemy()の呼び出し
    loop (); // 繰り返しを再開
  }
}
void floorMove() {
  for (int i= 0; i< floorNum; i++) { // すべての床に対して
    if (floorX[i] <0 || width< floorX[i]) {
      // 床iが左端もしくは右端に到達したら
      floorDx[i] = floorDx[i]*-1;
      // 床iのx方向の変化量floorDx[i]の符号を反転
    }
    floorX[i] += floorDx[i];
    stroke(255); // 線の色を白に設定
    strokeWeight(1); //線の太さを1に設定
    line( floorX[i]-floorHalfW[i], floorY[i], floorX[i]+floorHalfW[i], floorY[i] );
    // (floorX[i], floorY[i])が中心となるような
    // floorHalfW[i]*2の長さの直線を描画
  }
}

// 床iのx座標floorX[i]がウィンドウの中央より左にあれば
// 自キャラの表示を行う関数
void myCharaDraw() {
  stroke(128, 192, 255); // 自キャラの線の色を(128, 192, 255)に設定
  fill(128, 192, 255); // 自キャラの塗りつぶし色を(128, 192, 255)に設定
  ellipse(myX, myY, r*2, r*2); // (myX, myY)を中心とする半径r(直径r*2)の円を描画
}
