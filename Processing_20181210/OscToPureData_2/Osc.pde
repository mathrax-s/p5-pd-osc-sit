import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void oscOpen() {
  oscP5 = new OscP5(this, 9999);
  myRemoteLocation = new NetAddress("localhost", 4559);
}

void sendOscPureData(int a) {
  OscMessage myMessage = new OscMessage("/note");
  myMessage.add(a); 
  oscP5.send(myMessage, myRemoteLocation);
}

//OSC受信する
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/sync")==true) {

    if (theOscMessage.checkTypetag("f")) {
      osc_rcv_value = theOscMessage.get(0).floatValue();
      //println(osc_rcv_value);
    }
  }
}

/*
##| SonicPi Code
 live_loop :p5 do
 use_real_time
 a = sync "/osc/note"
 synth :beep, note: a,  release: 0.25
 end
 
 */