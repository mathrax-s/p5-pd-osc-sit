// Visual Synth Demo
// Serial
// 2018.12.17

float mX;
float mY;
float mZ;
int maxNum=100;
float[] bright = new float[maxNum];
int[] keys = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';'};
int[] chord5 = {2, 4, 7, 9, 11};
int[] notes = new int[keys.length];

Light[] lt=new Light[maxNum];
int lt_count;

float osc_rcv_value;
int octave=4;


void setup() {
  size(800, 600);
  //fullScreen();

  //OSC通信はじめる
  oscOpen();

  //シリアルポートを探す
  searchSerialPort();

  for (int i=0; i<maxNum; i++) {
    bright[i] = 0;
    lt[i] = new Light(0, 0, color(0));
  }
  for ( int i=0; i<keys.length; i++) {
    notes[i] = chord5[i%5] + (int)(i/5)*12;
  }
  noStroke();
}

void draw() {
  serialSelect();
}

void drawMain() {
  colorMode(RGB);
  background(230, 235, 220);
  //background(0);
  osc_rcv_value*=0.99;
  strokeWeight(10);
  stroke(255, 200, 255, osc_rcv_value*255);
  noFill();
  rect(0, 0, width, height);

  for (int i=0; i<maxNum; i++) {
    lt[i].draw();
  }

  fill(0);
  textAlign(CENTER, CENTER);
  text(octave, width/2, height-20);

  int x =(int) map(microbitData[0], 0, 100, 0, keys.length-1);
  int y =(int) map(microbitData[1], 0, 100, 0, keys.length-1);
  int z =(int) map(microbitData[2], 0, 100, 0, 100);

  if (z>50) {

    bright[x] = 1.0;
    lt_count++;
    if (lt_count>=100)lt_count=0;
    lt[lt_count].on((width/10)*x, height*bright[x], color(x*20, 150, octave*30, 255));
    octave = y;
    sendOscPureData(notes[x]+octave*12);
    
    microbitData[0]=0;
    microbitData[1]=0;
    microbitData[2]=0;
  }
}



//Key Simulation
void keyPressed() {
  for (int i=0; i<10; i++) {
    if (key == keys[i]) {
      bright[i] = 1.0;
      lt_count++;
      if (lt_count>=100)lt_count=0;
      lt[lt_count].on((width/10)*i, height*bright[i], color(i*20, 150, octave*30, 255));
      
      sendOscPureData(notes[i]+octave*12);
    }
  }
  if (keyCode==LEFT) {
    octave--;
    if (octave<1)octave=1;
  } else if (keyCode==RIGHT) {
    octave++;
    if (octave>8)octave=8;
  }
}