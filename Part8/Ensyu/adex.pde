void setup(){
  size(800,300);
  noStroke();
}

void draw(){
  background(255);
  fill(0);
  int h = hour();
  int m = minute();
  int s = second();

  sevenSegment(80,height/2,h/10);
  sevenSegment(180,height/2,h%10);
  ellipse(265,height/2+20,15,15);
  ellipse(265,height/2-20,15,15);
  sevenSegment(350,height/2,m/10);
  sevenSegment(450,height/2,m%10);
  ellipse(535,height/2+20,15,15);
  ellipse(535,height/2-20,15,15);
  sevenSegment(620,height/2,s/10);
  sevenSegment(720,height/2,s%10);
  }

void sevenSegment(int x,int y,int n){
if(n==1||n==2||n==3||n==4||n==7||n==8||n==9||n==0){
    hex(x+30,y-30,1);
}
if(n==1||n==3||n==4||n==5||n==6||n==7||n==8||n==9||n==0){
  hex(x+30,y+30,1);
}
if(n==0||n==2||n==3||n==5||n==6||n==7||n==8||n==9){
  hex(x,y-60,0);
}
if(n==0||n==4||n==5||n==5||n==6||n==8||n==9){
  hex(x-30,y-30,1);
}
if(n==0||n==2||n==6||n==8||n==9){
  hex(x-30,y+30,1);
}
if(n==0||n==2||n==3||n==5||n==6||n==8||n==9){
  hex(x,y+60,0);
}
if(n==4||n==2||n==3||n==5||n==6||n==8||n==9){
  hex(x,y,0);
}

}
void hex(int x,int y,int d){
  if(d==0){
    beginShape();
    vertex(x-28,y);
    vertex(x-20,y-8);
    vertex(x+20,y-8);
    vertex(x+28,y);
    vertex(x+20,y+8);
    vertex(x-20,y+8);
    endShape();
  }else if(d==1){
    beginShape();
    vertex(x,y-28);
    vertex(x+8,y-20);
    vertex(x+8,y+20);
    vertex(x,y+28);
    vertex(x-8,y+20);
    vertex(x-8,y-20);
    endShape();
    }

}
