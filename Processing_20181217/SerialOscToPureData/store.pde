//microbitからのデータを格納する
int[] microbitData = new int[3];

void storeData(int[] buff) {
  //bufferのデータが3個揃ったなら、
  if (buff.length>=3) {
    //microbitDataに格納する
    microbitData[0] = buff[0];
    microbitData[1] = buff[1];
    microbitData[2] = buff[2];
  }
}