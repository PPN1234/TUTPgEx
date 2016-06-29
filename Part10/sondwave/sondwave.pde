// 処 理 1 ( ラ イ ブ ラ リ の イ ン ポ ー ト )
import ddf . minim .*; // m i n i m ラ イ ブ ラ リ の イ ン ポ ー ト
// 処 理 2 ( グ ロ ー バ ル 変 数 の 設 定 )
Minim minim ; // M i n i m型の変数m i n i mの宣言
AudioPlayer player ; // A u d i o I n p u t 型 の 変 数 p l a y e r の 宣 言
float amp = 10.0; // 信 号 の 増 幅 率 ( 1 . 0 ～ 2 0 . 0 く ら い の 範 囲 で 波 形 が
  // 見 や す く な る よ う に 値 を 設 定 す る )

  void setup (){
    // 処 理 3 ( ウ イ ン ド ウ の 作 成 )
    size (800 , 800); // 800×800 の ウ イ ン ド ウ を 作 成
    // 処 理 4 ( M i n i m 型 の 変 数 m i n i m の イ ン ス タ ン ス の 生 成 )
    minim = new Minim ( this ); // M i n i m 型 の 変 数 m i n i m の イ ン ス タ ン ス を 生 成
    // 処 理 5 ( 音 デ ー タ 入 力 を 行 う た め の 設 定 , バ ッ フ ァ サ イ ズ を width ( 8 0 0 ) に 設 定 )
    player = minim . loadFile ( " ../ sounddata / music . wav " , width );
    player . play (); // 再 生 開 始
  }

  void draw (){
    // 処 理 6 ( 色 の 設 定 )
    background (0); // 背 景 を 黒 に 設 定
    stroke (255); // 線 の 色 を 白 に 設 定
    fill (0); // 文 字 の 色 を 白 に 設 定
    // 処 理 7 ( 基 準 と な る 線 な ど の 描 画 )
    textSize (30); // 文 字 の サ イ ズ を3 0 に 設 定
    text ( " L " , 50 , 100); // ( 5 0 , 1 0 0 ) の 位 置 に 「 L 」 を 表 示
    line (0 , 200 , width , 200); // y=200 の 直 線 を 描 画
    text ( " R " , 50 , 500); // ( 5 0 , 5 0 0 ) の 位 置 に 「 R 」 を 表 示 　
    line (0 , 600 , width , 600); // y=600 の 直 線 を 描 画
    // 処 理 8 ( f o r 文 に よ る 音 デ ー タ の 処 理 )
    for ( int i = 0; i < player . bufferSize (); i ++){ // p l a y e r . b u f f e r S i z e ( ) 回 繰 り 返 す
      drawPoint (i , player . left . get ( i ) , player . right . get ( i ));
    }
  }
  // 処 理 9 ( 波 形 の 描 画 )
  void drawPoint ( int i , float left , float right ){ // l e f t と r i g h t の 値 を 描 画
    float leftPos = 200+ left *50* amp ;
    float rightPos = 600+ right *50* amp ;
    point (i , leftPos ); // 左 側 の i 番 目 の 信 号 の 大 き さ を 点 で 描 画
    point (i , rightPos ); // 右 側 の i 番 目 の 信 号 の 大 き さ を 点 で 描 画
  }
  void stop (){ // プ ロ グ ラ ム が 終 了 さ れ る と き に 呼 び 出 さ れ る 関 数
    // 処 理 10 ( プ ロ グ ラ ム 終 了 時 の 処 理 )
    player . close (); // 音 声 入 力 用 の 変 数 p l a y e r を 閉 じ る
    minim . stop (); // mi nimを終了
    super . stop (); // プ ロ グ ラ ム の 終 了 処 理
  }
