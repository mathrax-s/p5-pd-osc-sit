class Light {
  float x, y;
  float bright;
  color col;
  float s;
  float r;
  float rd;

  Light(float xx, float yy, color c) {
    x=xx;  
    y=yy;
    col=c;
    bright=0;
    s = 0;
    r = random(360);
    rd = random(-2, 2);
  }

  void draw() {
    bright*=0.95;
    y=height*bright;
    colorMode(HSB);
    s+=0.1;
    r+=rd;
    if (bright>0.01) {
      pushMatrix();
      
      translate(x, y);
      scale(s);
      rotate(radians(r+rd));
      noStroke();
      fill(col, 255*bright);
      rect(0, 0, (width/10), height*bright);
      
      popMatrix();
    }
  }

  void on(float xx, float yy, color c) {
    x=xx;
    y=yy;
    
    col=c;
    bright=1.0;
    s=0;
    r = random(360);
    rd = random(-2, 2);
  }
}