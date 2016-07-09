// 自キャラに関するグローバル変数
float myX, myY ;   // 自キャラ中央のx , y 座標
float myDx, myDy ; // 自キャラのx , y 方向の変化量
float r = 12.0;    // 自キャラ・敵キャラの半径
int mode;          // 0 : 通常モード， 1 : ジャンプモード
float moveL = 1.0; // キーボード操作によるx 方向の変化量

// setup()関数
void setup(){
  size(600, 600);  // 600×600 のウィンドウを作成
  frameRate(120);  // フレームレートを120に設定
  textSize(30);    // 文字サイズを30に設定
  textAlign(CENTER, CENTER); // 文字表示位置を水平，垂直とも中央に設定
  setupMyChara();  // 自キャラの初期設定を行うsetupMyChara()の呼び出し
}

// draw()関数
void draw(){
  background (0, 0, 128); // 背景色を(0, 0, 128)に設定　
  myCharaMove();          // 自キャラの移動を行うmyCharaMove()の呼び出し
}

// 自キャラの初期設定を行う関数
void setupMyChara(){
  □;       // 自キャラのx座標myXをウィンドウの中央に設定
  □;       // 自キャラのy座標myYをウィンドウの下端に接する
            // 位置(height - r)に設定
  mode = 0; // modeを通常モード(0)に設定
}

// 自キャラの移動を行う関数
void myCharaMove(){
  myCharaKey();     // 自キャラのキーボードによる操作を行うmyCharaKey()
                    // の呼び出し
  myCharaUpdateX(); // 自キャラのx座標の更新を行うmyCharaUpdateX()の呼び出し
  myCharaDraw();    // 自キャラの表示を行うmyCharaDraw()の呼び出し
}

// 自キャラのキーボードによる操作を行う関数
void myCharaKey(){
  if(mode == 0){ // 通常モード(modeが0)ならば
    if(keyPressed){ // キーが押されていれば
      switch(keyCode) { // keyCodeの値により処理を分岐
      case □: // ← キーならば
        □;    // 自キャラのx方向の変化量myDxを-moveL(左向き)に設定
        break ;
      case □: // → キーならば
        □;    // 自キャラのx方向の変化量myDxを moveL(右向き)に設定
        break ;
      default: // それ以外の特殊キーならば
        □;    // 自キャラのx方向の変化量myDxを0に設定
        break ;
      }
    }else{     // キーが押されていなければ
      □;      // 自キャラのx方向の変化量myDxを0に設定
    }
  }
}

// 自キャラのx座標の更新を行う関数
void myCharaUpdateX(){
  if (□){    // 自キャラがウィンドウの左端に到達したら
    if (□){  // ジャンプモード(modeが1)ならば
      □;     // 自キャラのx方向の変化量myDxの符号を反転
    }else{    // それ以外(通常モード)ならば
      □;     // 自キャラのx方向の変化量myDxを0に設定(移動を停止)
      □;     // 自キャラのx座標myXを左端に接した位置(r)に設定
    }
  } else if(□){ // 自キャラがウィンドウの右端に到達したら
    if (□){  // ジャンプモード(modeが1)ならば
      □;     // 自キャラのx方向の変化量myDxの符号を反転
    }else{    // それ以外(通常モード)ならば　
      □;     // 自キャラのx方向の変化量myDxを0に設定(移動を停止)
      □;     // 自キャラのx座標myXを右端に接した位置(width - r)に設定
    }
  }
  □;         // 自キャラのx座標myXをx方向の変化量myDxだけ更新
}

// 自キャラの表示を行う関数
void myCharaDraw(){
  □; // 自キャラの線の色を(128, 192, 255)に設定
  □; // 自キャラの塗りつぶし色を(128, 192, 255)に設定
  □; // (myX, myY)を中心とする半径r(直径r*2)の円を描画
}