//シリアル通信
import processing.serial.*;
Serial myPort;

int portNumber;

//シリアルポートをオープンする
void serialOpen(int num) {
  if (num>=0) {
    myPort = new Serial(this, Serial.list()[num], 115200);   
    delay(1000);
    myPort.clear();
  }
}

String[] serialString;  
int serialCount = 0;

//シリアルポートをさがす
void searchSerialPort() {
  boolean firstContact = false; 
  String serialCheck;  
  int serialIndex;  
  int unknown;

  unknown=0;
  serialString = Serial.list();  
  for (int i = serialString.length - 1; i > 0; i--) {  
    serialCheck = serialString[i];
  }
  //println(Serial.list());
}

//シリアルポートがオープンなら、クリアしてクローズする
void serialClose() {
  if (myPort!=null) {
    myPort.clear();
    myPort.stop();
  }
}


//データが送られてきたとき
void serialEvent (Serial p) {
  //文字列の改行まで読み取る
  String stringData=p.readStringUntil(10);

  if (stringData!=null) {
    //受け取った文字列にある先頭と末尾の空白を取り除き、データだけにする
    stringData=trim(stringData);
    
    //「,」で区切られたデータ部分を分離してbufferに格納する
    int buffer[] = int(split(stringData, ','));
    
    //bufferのデータをstoreData関数に送る(store_dataタブの関数）
    storeData(buffer);
  }
}


//マウスクリックしたとき
void mousePressed() {
  //シリアルポート選択がまだの場合
  if (!serialPortSelect) {
    //シリアルポートを開く
    serialOpen(selectSerialPortNum);
    //シリアルポート選択した、と記憶する
    serialPortSelect=true;
    //画面を白で消去
    background(255);
  } else {  //シリアルポート選択している場合

    //micro:bitからのデータが空の時
    if (microbitData==null) {
      //間違ったポートを開いたとみなし、いったんポートを閉じる
      serialClose();
      //シリアルポート未選択とする
      serialPortSelect=false;
      //画面を白で消去
      background(255);
    }
  }
}


//シリアルポートを選ぶ画面の表示
void serialPortSelectScene() {
  colorMode(RGB);
  background(0);
  selectSerialPortNum=-1;
  for (int i=0; i<serialString.length; i++) {
    int h = height/serialString.length;
    if (overRect(0, h*i, width, h)) {
      //
      noStroke();
      fill(255, 255, 255);
      selectSerialPortNum=i;
    } else {
      //
      stroke(100, 100, 100);
      noFill();
    }
    rect(0, h*i, width-1, h);

    if (selectSerialPortNum==i) {
      fill(0, 0, 0);
    } else {
      fill(255, 255, 255);
    }
    textAlign(CENTER, CENTER);
    textSize(20);
    text(serialString[i], width/2, h/2+h*i);
  }
}

//マウスが指定したエリア内に入ったかどうか調べる
boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}


boolean serialPortSelect;
int selectSerialPortNum;
boolean debug=false; //true or false

void serialSelect(){
  if (debug) {
    drawMain();
    return;
  }
  //シリアルポートを選んでない場合
  if (!serialPortSelect) {
    //シリアルポート選択画面を表示
    serialPortSelectScene();
    return;
  }

  //micro:bitからのデータが何かあれば、doMain()へ
  if (microbitData!=null) {
    drawMain();
  } else {
    //micro:bitからのデータが何もなければ「クリックして戻る」表示
    background(0);
    fill(255);
    text("No data...\r\n Click and back to select serialport.", width/2, height/2);
  }
}