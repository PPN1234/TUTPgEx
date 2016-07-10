import ddf.minim.*; //minimライブラリの読み込み
boolean isPaused; //boolean型のisPausedを宣言
Minim minim; //minim型の変数minimの宣言
AudioPlayer player; // AudioPlayer型の変数playerを宣言
PImage img; //画像用の変数を宣言


void setup(){
  size(800, 600); //ウインドウサイズを800x600に設定
  minim = new Minim(this); //minim型の変数minimインスタンスの生成
  player = minim.loadFile("../data/Twenty.mp3"); //音声ファイルをロード
  player.loop(); //再生開始
  isPaused = false; //一時停止の変数をfalseに設定
  img = loadImage("../data/homuvis_kiiro.png"); //画像の読み込み
  imageMode(CENTER); //画像を中心から広がるように設定
}

//一時停止を処理する関数
void mousePressed() { //もしマウスがクリックされたら
  if(isPaused == false){ //もしisPausedがfalseなら
    player.pause(); //再生を一時停止
    isPaused = true; //isPausedをtrueに
  }

  else if(isPaused == true){ //もしisPausedがtrueなら
    player.play(); //再生を再開
    isPaused = false; //isPausedをfalseに
  }
}

void draw(){
  //ビジュアライザを描画する
  visualizer(250, width/2, height/2);
}

//ビジュアライザを描画する関数
void visualizer(int r, int posx, int posy) {

  translate(posx, posy); //原点を指定された位置へ
  int bsize = player.bufferSize(); //バッファーサイズをbsizeに代入

  //音声信号に合わせて動く画像を描画
  for (int i = 0; i < bsize; i+=200) { //bsizeを200ずつループ
    background(0); //背景を上書き
    float ir = (r + player.left.get(i)*125); //音の強さを取得して半径を足したものをirに代入
    if (ir > 250){ //半径250以下になった場合ブレないように250で固定
      image(img, 0, 0, ir, ir); //画像の貼り付け
    } else {
      image(img, 0, 0, 250, 250);
    }
  }

  //音声信号に合わせて動く波線を描画
  for (int i = 0; i < bsize; i+=13) { //bsizeを13ずつループ
    float x = (r - 35)*cos(i*2*PI/bsize); //円の周りの波線の始点のX座標を計算
    float y = (r - 35)*sin(i*2*PI/bsize); //円の周りの波線の始点のY座標を計算
    float x2 = (r - 35 + player.left.get(i)*20)*cos(i*2*PI/bsize); //始点から音声信号に合わせて動く線の終点のX座標を計算
    float y2 = (r - 35 + player.left.get(i)*20)*sin(i*2*PI/bsize); //始点から音声信号に合わせて動く線の終点のY座標を計算

    //計算した値を描画する
    stroke(150); //線の色を150に指定
    strokeWeight(10); //線の太さを10指定
    //線を円の外側のみ表示させる
    if(x < 0){
      if(x > x2){
        line(x, y, x2, y2);
      } else {
        line(x, y, x, y);
      }
    } else {
      if(x < x2){
        line(x, y, x2, y2);
      } else {
        line(x, y, x, y);
      }
    }
  }
}
