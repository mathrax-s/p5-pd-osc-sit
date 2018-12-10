class Light {
  float x, y;
  float bright;
  color col;

  Light(float xx, float yy, color c) {
    x=xx;  
    y=yy;
    col=c;
    bright=0;
  }

  void draw() {
    bright*=0.95;
    y=height*bright;
    //colorMode(HSB);
    noStroke();
    fill(col, 255*bright);
    rect(x, y, (width/10), height*bright);
  }

  void on(float xx, float yy, color c) {
    x=xx;
    y=yy;
    col=c;
    bright=1.0;
  }
}