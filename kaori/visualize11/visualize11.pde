import ddf.minim.*; //minimライブラリの読み込み
import ddf.minim.analysis.*; // minim.analysisをインポート
Minim minim; //minim型の変数minimの宣言
AudioPlayer player; // AudioPlayer型の変数playerを宣言
AudioMetaData meta; //AudioMetaData型のmetaを宣言
boolean isPaused; //boolean型のisPausedを宣言
FFT fft; //FFT型の変数fftの宣言

void setup() {
  size (800, 600); //ウインドウサイズを800x600に設定
  minim = new Minim (this); //minim型の変数minimインスタンスの生成
  player = minim.loadFile("Stressed Out.mp3", 1024); //音声ファイルをロード
  meta = player.getMetaData(); //変数metaにメタ情報を格納
  fft = new FFT (player.bufferSize(), player.sampleRate());
                            //FFT型の変数fftインスタンスを生成
                            //解析を行うサンプル点の数をplayer.bufferSize()に設定
                            //解析を行うサンプリング周波数をplayer.sampleRate（）に設定
  player.play(); //再生開始
  isPaused = true; //一時停止の変数をtrueに設定
}

//一時停止を処理する関数
void mousePressed() {
  if (isPaused == false) {
    player.pause();
    isPaused = true;
  } else if (isPaused == true) {
    player.play();
    isPaused = false;
  }
}


void draw() {
  background(0); //背景色を黒に
  stroke(0, random(190, 255), random(190, 255)); //線の色を指定範囲内でランダムに生成
  strokeWeight(3); //線の幅を３に設定

  fft.forward(player.mix); //左右の信号を合わせた信号(player.mix）に対してFFTを実行
  int highest = 0; //int型の変数highestに０を代入

  fill(0); //塗りつぶし色を黒に
  ellipse(width/2, height/2, 388,388); //中央に３３８の円を描画

  for (int k = 0; k < fft.specSize()/2.5; k++) { //fft.specSize()の間だけ繰り返す


    //左側の波線を描画
    fill(0);
    line(k, height/2, k, height/2 + fft.getBand(k));
    line(k, height/2, k, height/2 - fft.getBand(k));

    //右側の波線を描画
    line(width - k, height/2, width - k, height/2 + fft.getBand(k));
    line(width - k, height/2, width - k, height/2 - fft.getBand(k));

    //中央のメタ情報の描画
    fill(255); //文字色を白に
    textSize(30); //フォントサイズ３０
    text("Author: " + meta.author(), width/2 - 160, height/2 - 35); //作者の表示
    text("Title: " + meta.fileName(), width/2 - 160, height/2 + 10); //曲タイトル（ファイル名）の表示
    text(player.position()/1000/60  + ":" + player.position()/1000%60 + "/"
    + meta.length()/1000/60 + ":" + meta.length()/1000%60, width/2 - 90, height/2 + 50); //現在の再生時間と曲の再生時間を表示

    //スペクトルの値が最大となるｋの値を決める
    if (fft.getBand(k) > fft.getBand(highest)) {
      highest = k;
    }
  }
}

//アプリケーション終了時の処理
void stop() {
  player.close(); //再生停止
  minim.stop(); //minimの終了
  super.stop(); //アプリケーションの終了
}
