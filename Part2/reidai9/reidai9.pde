size(800, 600);
int x;
int y;
int d = 120;

for (int i = 0; i < 5; i++) {
  for(int j = 0; j <3; j++) {
    x = 200 + i * 100;
    y = 150 + j * 100;
    d = 80 + i * 10 + j * 5;
    fill(50+i*50, 50+j*50, 100);
    ellipse(x, y, d, d);
  }
}