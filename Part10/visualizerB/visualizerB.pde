import ddf.minim.*; //ライブラリの読み込み
Minim minim;
boolean isPaused; //一時停止の関数
AudioPlayer player; //オーディオプレイヤーの読み込み
PImage img; //画像用の変数を宣言


void setup(){
  size(800, 600);
  minim = new Minim(this); //変数minimにMinimライブラリをロード
  player = minim.loadFile("Unicorn.mp3"); //音楽データをロードしplayerに代入
  player.loop(); //再生開始
  isPaused = true;
  img = loadImage("homuvis_kiiro.png"); //画像の読み込み
  imageMode(CENTER); //画像を中心から広がるように設定
}

//クリックで一時停止を実装する関数
void mousePressed() {
  if(isPaused == false){
    player.pause();
    isPaused = true;
  }

  else if(isPaused == true){
    player.play();
    isPaused = false;
  }
}

//描画処理
void draw() {
  visualizer(250, width/2, height/2); //関数visualizerの呼び出し(半径150,中心点x,中心点yをvisualizerに渡す)
}

//ビジュアライザー本体
void visualizer(int r, int posx, int posy) {
  translate(posx, posy); //原点を画面の中心に設定


  //曲のバッファーサイズ(今読み込まれている曲データの容量)をbsizeに代入
  int bsize = player.bufferSize();

  //バッファーサイズに合わせて同じ回数ループする
  for (int i = 0; i < bsize; i+=200) {
    background(0); //背景を上書き
    float ir = (r + player.left.get(i)*60); //音の強さを取得して半径を足したものをirに代入
    if (ir > 250){ //半径250以下になった場合ブレないように250で固定
      image(img, 0, 0, ir, ir); //画像の貼り付け
    } else {
      image(img, 0, 0, 250, 250);
    }
  }
}
