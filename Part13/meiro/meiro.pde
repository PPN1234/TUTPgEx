int boardX;
int boardY;
int roadW;
int[][] map;
int pieceX;
int pieceY;
boolean isPlaying;
boolean isGoal;
boolean isMousePlaying;
boolean inTouch = false;
float pieceSize;
int playTime;
int[] dirX = {1,0,-1,0};
int[] dirY = {0,1,0,-1};
boolean isSearchLeft;
int pieceDir;

void setup(){
  size(800,600);
  makeBoard(13,9,46);
  initMaze();
}

void draw(){
  if(isSearchLeft){
    searchLeft();
  }
  drawMaze();
  drawPiece();
  if(isPlaying  || isMousePlaying || isGoal ){
    drawInfo();
  }
  checkFinish();
}

void makeBoard(int x,int y,int w){
  boardX = x+4;
  boardY = y+4;
  roadW = w;
  map = new int[boardX][boardY];
}

void initMaze(){
  for(int x = 0; x < boardX;x++){
    for(int y = 0; y < boardY;y++){
      map[x][y] = 1;
    }
  }
  for(int x = 3; x < boardX-3;x++){
    for(int y = 3; y < boardY-3;y++){
      map[x][y] = 0;
    }

    isSearchLeft = false;
    pieceDir = 0;
  }
  map[2][3] = 2;
  map[boardX-3][boardY-4] = 3;
  pieceX = 2;
  pieceY = 3;
  isPlaying = false;
  isGoal = false;
  isMousePlaying = false;
  pieceSize = 0.7*roadW;
  playTime = 0;

}

void drawMaze(){
  noStroke();
  background(100);
  for(int x = 2;x < boardX-2;x++){
    for(int y = 2;y < boardY-2;y++){
      if(map[x][y] == 0){
        fill(100,0,0);
      }else if(map[x][y] == 1){
        fill(0,200,0);
      }else if(map[x][y] == 2){
        fill(200,200,0);
      }else if(map[x][y] == 3){
        fill(200,0,200);
      }
      rect(roadW*x,roadW*y,roadW,roadW);
    }
  }
}

void searchLeft(){

  int dir = 0;
  int x = 0;
  int y = 0;

  if(frameCount%10 == 0){
    for(int i= 0;i < 4; i++){
      dir = (pieceDir+3+i)%4;//進む方向を表すdirを左、前、右、後の順に設定
      x = pieceX + dirX[dir];//dirの方向に1マス移動した位置(x方向)を計算
      y = pieceY + dirY[dir];//dirの方向に1マス移動した位置(y方向)を計算
      if((map[x][y]) == 0 || (map[x][y]) == 3){//(x,y)のマスが道(0)かゴール(3)ならば
        break;//for文から撤退
      }
    }
    pieceDir = dir;//駒の方向をdirに設定
    pieceX = x;//xに設定
    pieceY = y;//yに設定
  }
}

void SearchLeft(){

  int dir = 0;
  int x = 0;
  int y = 0;

  if(frameCount%10 == 0){
    for(int i= 0;i < 4; i++){
      dir = (pieceDir+3+i)%4;//進む方向を表すdirを左、前、右、後の順に設定
      x = dirX[dir];//dirの方向に1マス移動した位置(x方向)を計算
      y = dirY[dir];//dirの方向に1マス移動した位置(y方向)を計算
      if((map[x][y] == 0) || (map[x][y] == 3)){//(x,y)のマスが道(0)かゴール(3)ならば
        break;//for文から撤退
      }
    }
    pieceDir = dir;//駒の方向をdirに設定
    pieceX = x;//xに設定
    pieceY = y;//yに設定
  }
}

void drawPiece(){
  if(isMousePlaying){
    inTouch = false;
    int posX = mouseX % roadW;
    int posY = mouseY % roadW;
    int pX = mouseX / roadW;
    int pY = mouseY / roadW;
    if(pX >= 2 && pX < boardX - 2 && pY < boardY - 2){
      pieceX = pX;
      pieceY = pY;
      if( (map[pieceX][pieceY]==1)
         || (map[pieceX + 1][pieceY] == 1 && posX > roadW - pieceSize/2)
         || (map[pieceX-1][pieceY] == 1&& posX<pieceSize/2 )
         || (map[pieceX][pieceY+1] == 1&& posY>roadW-pieceSize/2 )
         || (map[pieceX][pieceY]== 1 && posY<pieceSize/2)){
         inTouch = true;
         }
    }
  if(inTouch == true){
    fill(255,0,0);
  }else{
    fill(0,200,0);
  }
  ellipse(mouseX,mouseY,pieceSize,pieceSize);
  }
  else{
  fill(0,200,0);
  ellipse((pieceX+0.5)*roadW,(pieceY+0.5)*roadW,pieceSize,pieceSize);
  }
}


void drawInfo(){
  if(isPlaying || isMousePlaying){

    playTime ++ ;
  }
  if(isPlaying){
    playTime += 1;
  }
  if(inTouch == true){
    playTime += 2;
  }
  textSize(30);
  fill(0);
  text("Time=" + playTime,20,30);
}

void mousePressed(){
    int x = mouseX/roadW;
    int y = mouseY/roadW;
  if(map[x][y] ==2){
    isMousePlaying = true;
  }
}

void keyPressed(){
  if(key == 'A'){
    makeBoard(13,9,46);
    drawMaze();
    initMaze();
    drawPiece();
  }
  if(key == 'a'){
    generateMazeUpDown();
  }
  if(key == 'b'){
    makeBoard(23,17,28);
    drawMaze();
    initMaze();
    drawPiece();
  }
  if(key == 'c'){
    makeBoard(75,55,10);
    drawMaze();
    initMaze();
    drawPiece();
  }
  if(key == 'd'){
    makeBoard(155,115,5);
    drawMaze();
    initMaze();
    drawPiece();
  }
  if(key == 'r'){
    for(int x = 2; x < 100; x+=2){
      generateMazeRandom();
    }

  }
  if(key == 'k'){
    isPlaying = true;
  }
  if(key == 'i'){
    initMaze();
  }
  if(isPlaying == true){
    if(keyCode == UP && pieceY > 0){
      pieceY -= 1;
    }
    if(keyCode == RIGHT && pieceX < boardX-1){
      pieceX += 1;
    }
    if(keyCode == DOWN && pieceY < boardY-1){
      pieceY += 1;
    }
    if(keyCode == LEFT && pieceX > 0){
      pieceX -= 1;
    }
  }
  if(key == 's') isSearchLeft = true;
}

void generateMazeRandom(){
  for(int x = 2; x < boardX-2;x+=2){
    for(int y = 2; y < boardY-2;y+=2){
      if(map[x][y] == 1){
        int r = (int)random(4);
        int dx = dirX[r];
        int dy = dirY[r];
        if(map[x+dx*2][y+dy*2] == 0){
          map[x+dx][y+dy] = 1;
          map[x+dx*2][y+dy*2] = 1;
        }
      }
    }
  }
}

void generateMazeUpDown(){
  for(int x = 4; x < boardX -3; x += 4){
    for(int y = 3; y < boardY -4; y++){
      map[x][y] = 1;
    }
  }
  for(int x = 6; x < boardX -3; x += 4){
    for(int y = boardY -4; y > 3; y--){
      map[x][y] = 1;
    }
  }
}

void generateMazeLeftRight(){
  for(int x = 4; x < boardX -3; x += 4){
    for(int y = 3; y < boardY -4; y++){
      map[x][y] = 1;
    }
  }
  for(int x = 6; x < boardX -3; x += 4){
    for(int y = boardY -4; y > 3; y--){
      map[x][y] = 1;
    }
  }
}

void checkFinish(){
  if(map[pieceX][pieceY] == 3){
    isPlaying = false;
    isGoal = true;
    isMousePlaying = false;
    isSearchLeft = false;
  }
  if(isGoal == true){
    noFill();
    strokeWeight(20);
    stroke(255,0,0);
    ellipse(width/2,height/2,200,200);
  }
}
