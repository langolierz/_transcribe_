#include <usbh_midi.h>
#include <usbhub.h>
#include <SPI.h>
#include <usbmidi.h>
#include "midievents.h"
#include "commands.h"
#include <AltSoftSerial.h>

AltSoftSerial altSerial;
USB Usb;
USBH_MIDI  Midi(&Usb);
uint16_t pid, vid;
char cmd[14] = {};
uint8_t cmdNum;
uint8_t notes[128];
uint8_t cc[128];
uint8_t midiCommand, midiChannel, midiParam1, midiParam2;
bool hasUsbDevice;

uint8_t switchStore[2];

uint8_t twoInputStore[2][5]; // 0=BACK_COLOR_MANUAL:174, 1=EDGE_COLOR_MANUAL:175, 2=COLOR_CORECT:217, 3=CENTER_WIPE:218, 4=SCENE_GRABER:219
uint8_t threeInputStore[3][1]; // 0=CHROMA_SET:214

bool useFlatMidiMap;

bool readInputFromMidiDevice();
bool readInputFromMidiHost();
bool readInputFromMidiSerial();


void setCmd(uint8_t inputCmd);
void setCmdSwitch(uint8_t inputCmd1, uint8_t inputCmd2, uint8_t switchIndex);
void setCmdToggle(uint8_t inputCmd, uint8_t offset, uint8_t switchIndex);
void setCmdToggle(uint8_t inputCmd, uint8_t offset, uint8_t switchIndex);
void setCmdStep(uint8_t inputCmd, uint8_t param, uint8_t offset);
void setCmdParam(uint8_t inputCmd, uint8_t param);
void setCmdTwoParams(uint8_t inputCmd, uint8_t param, uint8_t position, uint8_t storeIndex);
void setCmdThreeParams(uint8_t inputCmd, uint8_t param, uint8_t position, uint8_t storeIndex);
void setPrefix(uint8_t cmdNum);
void setThisPrefix(char prefix[4]);
void removeTrailingUnderscore();

void createMap(){
  for (uint8_t i = 0; i < 128; i++)
  {
    notes[i] = 255;
    cc[i] = 255;
  }

  notes[60] = AVE55::WIPE_SQUARE_CORNER_UL;
  notes[61] = AVE55::WIPE_SQUARE_CORNER_DL;
  notes[62] = AVE55::WIPE_SQUARE_CORNER_DR;
  notes[63] = AVE55::WIPE_SQUARE_CORNER_UR;

  cc[0] = AVE55::A_B_MIX_LEVEL;
  // two&three input controls need to be adjacent in the mapping
  cc[1] = AVE55::CENTER_WIPE; // first is x
  cc[2] = AVE55::CENTER_WIPE; // second is y
  cc[46] = AVE55::WIPE_MIX_BUTTON;

}

uint8_t get_two_param_position(){
  uint8_t position = 1;
  if(useFlatMidiMap && midiChannel > 0 && AVE55::flat_cc_ch_two[midiParam1+1] == cmdNum){position = 0;}
  else if(cc[midiParam1+1] == cmdNum){position = 0;}
  return position;
}

uint8_t get_three_param_position(){
  uint8_t position = 2;
  if(useFlatMidiMap && midiChannel > 0 && AVE55::flat_cc_ch_two[midiParam1+1] == cmdNum && AVE55::flat_cc_ch_two[midiParam1+2] == cmdNum){position = 0;}
  else if(useFlatMidiMap && midiChannel > 0 && AVE55::flat_cc_ch_two[midiParam1+1] == cmdNum){position = 1;}
  else if(cc[midiParam1+1] == cmdNum && cc[midiParam1+2] == cmdNum){position = 0;}
  else if(cc[midiParam1+1] == cmdNum){position = 1;}
  return position;
}

uint8_t get_two_store_index(){
  uint8_t storeIndex = 0;
  if(cmdNum == 175) storeIndex=1;
  else if(cmdNum == 217) storeIndex=2;
  else if(cmdNum == 218) storeIndex=3;
  else if(cmdNum == 219) storeIndex=4;
  return storeIndex;
}

void setMap(){
  // first check the default flatmap for midi channel 2 or 3
  if(useFlatMidiMap && midiChannel == 1){
    if(midiCommand == MIDICOMMAND::NOTEON){     
      cmdNum = AVE55::flat_notes_ch_two[midiParam1];
    }
    else if(midiCommand == MIDICOMMAND::CC){
      cmdNum = AVE55::flat_cc_ch_two[midiParam1];
    }
  }
  else if(useFlatMidiMap && midiChannel == 2){
    if(midiCommand == MIDICOMMAND::NOTEON){     
      cmdNum = AVE55::flat_notes_ch_three[midiParam1];
    }
  }
  // then check the simple custom map
  if(midiChannel == 0){
    if(midiCommand == MIDICOMMAND::NOTEON && notes[midiParam1] != 255){
      cmdNum = notes[midiParam1];
    }
    else if(midiCommand == MIDICOMMAND::CC && cc[midiParam1] != 255){

      cmdNum = cc[midiParam1];
      }
    }
  if(cmdNum != 255){
    if(AVE55::is_one_input(cmdNum)){
      setCmdParam(cmdNum, midiParam2);
    }
    else if(AVE55::is_two_input(cmdNum)){
      uint8_t storeIndex = get_two_store_index();
      uint8_t position = get_two_param_position();
      Serial.print(storeIndex);
      Serial.print("<-- store index");
      setCmdTwoParams(cmdNum, midiParam2, position, storeIndex);
    }
    if(AVE55::is_three_input(cmdNum)){
      uint8_t position = get_three_param_position();
      setCmdThreeParams(cmdNum, midiParam2, position, 0);
    }
    else{
    // no inputs
      if(midiParam2 != 0){
        setCmd(cmdNum);
      }

    }
    return;
  }
  Serial.print(cmdNum);
  Serial.print("<-- the cmdNum");
  // finally check the special custom map
  if(midiCommand == MIDICOMMAND::NOTEON){
    // special note stuff here
  }
  else if(midiCommand == MIDICOMMAND::CC){
    if(midiParam1 == 16){setCmdStep(AVE55::A_BUS_STROBO_OFF, midiParam2, 6);}
    else if(midiParam1 == 17){setCmdStep(AVE55::A_BUS_MOSAIC_OFF, midiParam2, 6);}
    else if(midiParam1 == 18){setCmdStep(AVE55::A_BUS_PAINT_OFF, midiParam2, 6);}

    else if(midiParam1 == 20){setCmdStep(AVE55::B_BUS_STROBO_OFF, midiParam2, 6);}
    else if(midiParam1 == 21){setCmdStep(AVE55::B_BUS_MOSAIC_OFF, midiParam2, 6);}
    else if(midiParam1 == 22){setCmdStep(AVE55::B_BUS_PAINT_OFF, midiParam2, 6);}
    // else if(midiParam1 == 32){setCmdToggle(AVE55::WIPE_SQUARE_CORNER_UL, 8, 1);}
    // else if(midiParam1 == 33){setCmdSwitch(AVE55::A_BUS_SOURCE_1, AVE55::A_BUS_BACK_COLOR, 0);}
    // else if(midiParam1 == 34){setCmdToggle(AVE55::WIPE_SQUARE_CORNER_UL, 8, 1);}
  }
}

void setup()
{
  Serial1.begin(31250);
  Serial.begin(9600);
  altSerial.begin(9600);


  createMap();
  hasUsbDevice = false;
  vid = pid = 0;
  switchStore[2] = {};
  useFlatMidiMap = true;

  if (Usb.Init() == 0){ // means it is successful
    hasUsbDevice = true;
    delay( 200 );
    }
}

void loop()
{
  midiCommand = midiChannel = midiParam1 = midiParam2 = 0;
  cmdNum = 255;
  memset(&cmd[0], 0, sizeof(cmd));
  bool hasMessage = false;

  if(hasUsbDevice){hasMessage = readInputFromMidiDevice();} // check from the usbhost-sheild first if connected
  if(!hasMessage){hasMessage = readInputFromMidiHost();} // if nothing check the usb on the arduino
  if(!hasMessage){hasMessage = readInputFromMidiSerial();} // if still nothing check the serial port  
  if(!hasMessage){return;}

  if(midiCommand == 0){return;}
 
  Serial.print(midiParam1);
  Serial.print("<-note\n");
  Serial.print(midiChannel);
  Serial.print("<-channel\n");
  Serial.print(midiCommand);
  Serial.print("<-command\n"); 
  // midiParam2 = midiParam2 - 64; // weird off by 64 bug ??
  Serial.print(midiParam2);
  Serial.print("<-value\n\n");

  setMap();
  
  removeTrailingUnderscore();

  Serial.print(cmd);
  Serial.print("<-cmd\n");
  if(cmd[0] == 0){return;}

  altSerial.write(2);
  altSerial.write(cmd);
  altSerial.write(3);
}

bool readInputFromMidiDevice(){
    Usb.Task();
    char buf[20];
    uint8_t bufMidi[3];
    uint16_t  rcvd;

  if (Midi.RecvData( &rcvd,  bufMidi) == 0 ) {
    uint8_t first =  bufMidi[1];
    midiCommand = first & 0xF0;
    midiChannel = first & 0xF;
    midiParam1 = bufMidi[2];
    midiParam2 = bufMidi[3];
    return true;
    }
  return false;
}

bool readInputFromMidiHost(){

  USBMIDI.poll();
  if(USBMIDI.available()){
    //Skip to beginning of next message (silently dropping stray data bytes)
    while(!(USBMIDI.peek() & 0x80)) USBMIDI.read();

    uint8_t first = USBMIDI.read();

    midiCommand = first & 0xF0; // command
    midiChannel = first & 0xF; // channel
    midiParam1 = USBMIDI.read(); // param 1 (note)
    midiParam2 = USBMIDI.read(); // param 2 (value)

    Serial1.write(first);
    Serial1.write(midiParam1);
    Serial1.write(midiParam2);

    USBMIDI.flush();
    return true;
  }
  return false;
}

bool readInputFromMidiSerial(){

  if(Serial1.available() < 3){ return false;}
  //Skip to beginning of next message (silently dropping stray data bytes)
  while(!(Serial1.peek() & 0x80)){ Serial1.read(); }
  if(Serial1.available() < 3){ return false;}
  uint8_t first = Serial1.read();

  midiCommand = first & 0xF0; // command
  midiChannel = first & 0xF; // channel
  midiParam1 = Serial1.read(); // param 1
  midiParam2 = Serial1.read(); // param 2

  // Serial1.flush();
  while(Serial1.available()){Serial1.read();}

  return true;
}

void setThisPrefix(char prefix[4]){
  for (uint8_t i = 0; i < 3; i++)
  {
    cmd[i] = prefix[i];
  }
}

void setPrefix(uint8_t cmdNum){

  if(cmdNum >= 0 && cmdNum <= 0) {setThisPrefix("VMX"); }
  else if(cmdNum >= 1 && cmdNum <= 37) {setThisPrefix("VWP"); }
  else if(cmdNum >= 40 && cmdNum <= 41) {setThisPrefix("VWD"); }
  else if(cmdNum >= 42 && cmdNum <= 44) {setThisPrefix("VWB"); }
  else if(cmdNum >= 40 && cmdNum <= 41) {setThisPrefix("VWD"); }
  else if(cmdNum >= 45 && cmdNum <= 52) {setThisPrefix("VWM"); }
  else if(cmdNum >= 53 && cmdNum <= 57) {setThisPrefix("_VW"); }
  else if(cmdNum >= 61 && cmdNum <= 63) {setThisPrefix("VWB"); }
  else if(cmdNum >= 70 && cmdNum <= 117) {setThisPrefix("VDE"); }
  else if(cmdNum >= 120 && cmdNum <= 121) {setThisPrefix("AML"); }
  else if(cmdNum >= 122 && cmdNum <= 125) {setThisPrefix("ALV"); }
  else if(cmdNum >= 126 && cmdNum <= 127) {setThisPrefix("AML"); }
  else if(cmdNum >= 130 && cmdNum <= 138) {setThisPrefix("VFD"); }
  else if(cmdNum >= 140 && cmdNum <= 148) {setThisPrefix("VBC"); }
  else if(cmdNum >= 150 && cmdNum <= 158) {setThisPrefix("VEC"); }
  else if(cmdNum >= 160 && cmdNum <= 164) {setThisPrefix("VBG"); }
  else if(cmdNum >= 174 && cmdNum <= 174) {setThisPrefix("_VB"); }
  else if(cmdNum >= 175 && cmdNum <= 175) {setThisPrefix("_VE"); }
  else if(cmdNum == 179 && cmdNum <= 179) {setThisPrefix("VMM"); }
  else if(cmdNum >= 180 && cmdNum <= 187) {setThisPrefix("_VDE"); }
  else if(cmdNum >= 190 && cmdNum <= 190) {setThisPrefix("_VAS"); }
  else if(cmdNum >= 191 && cmdNum <= 191) {setThisPrefix("_VF"); }
  else if(cmdNum >= 192 && cmdNum <= 192) {setThisPrefix("VMA"); }
  else if(cmdNum >= 197 && cmdNum <= 198) {setThisPrefix("VBC"); }
  else if(cmdNum >= 199 && cmdNum <= 199) {setThisPrefix("ZRS"); }
  else if(cmdNum >= 200 && cmdNum <= 209) {setThisPrefix("VCP"); }
  else if(cmdNum >= 210 && cmdNum <= 213) {setThisPrefix("VMX"); }
  else if(cmdNum >= 210 && cmdNum <= 213) {setThisPrefix("VCS"); }
  else if(cmdNum >= 215 && cmdNum <= 215) {setThisPrefix("ZUD"); }
  else if(cmdNum >= 216 && cmdNum <= 216) {setThisPrefix("ZEN"); }
  else if(cmdNum >= 217 && cmdNum <= 219) {setThisPrefix("VPS"); }
  else{
    Serial.print(cmdNum);
     Serial.print("<-found nothuing\n"); }

}

void setCmd(uint8_t cmdNum){
  setPrefix(cmdNum);

  cmd[3] = ':';
  char hexParam[12] = {};
  sprintf(hexParam, "%03d", cmdNum);

    cmd[4] = hexParam[0];
    cmd[5] = hexParam[1];
    cmd[6] = hexParam[2];
}

void setCmdSwitch(uint8_t inputCmd1, uint8_t inputCmd2, uint8_t switchIndex){
  if(switchStore[switchIndex] == 0){setCmd(inputCmd1); }
  else{ setCmd(inputCmd2); }
  switchStore[switchIndex] = (switchStore[switchIndex] + 1) % 2;
}

void setCmdToggle(uint8_t inputCmd, uint8_t offset, uint8_t switchIndex){
  // inputCmd = (inputCmd + switchStore[switchIndex]) % offset;
  // setCmd(inputCmd);
  // switchStore[switchIndex] = (switchStore[switchIndex] + 1) % offset;
}


void setCmdStep(uint8_t inputCmd, uint8_t param, uint8_t offset){
  // uint16_t max is 65535
  int value = ( (param * offset) / 128 );

  inputCmd = (inputCmd + value);
  setCmd(inputCmd);
}

void setCmdParam(uint8_t inputCmd, uint8_t param){
  setPrefix(inputCmd);

  char hexParam[12] = {};
  sprintf(hexParam, "%03d%02X", inputCmd, param*2);
  Serial.print(hexParam);
  Serial.print("<-hexParam\n");
  cmd[3] = ':';
  cmd[4] = hexParam[0];
  cmd[5] = hexParam[1];
  cmd[6] = hexParam[2];
  cmd[7] = hexParam[3];
  cmd[8] = hexParam[4];
}

void setCmdTwoParams(uint8_t inputCmd, uint8_t param, uint8_t position, uint8_t storeIndex){
  setPrefix(inputCmd);
  uint8_t *pointer = &twoInputStore[storeIndex][position];
  *pointer = param;
  // twoInputStore[storeIndex][position] = *param;

  char hexParam[12] = {};
  sprintf(hexParam, "%03d%02X%02X", inputCmd, twoInputStore[storeIndex][0]*2, twoInputStore[storeIndex][1]*2);
  cmd[3] = ':';
  cmd[4] = hexParam[0];
  cmd[5] = hexParam[1];
  cmd[6] = hexParam[2];
  cmd[7] = hexParam[3];
  cmd[8] = hexParam[4];
  cmd[9] = hexParam[5];
  cmd[10] = hexParam[6];
}

void setCmdThreeParams(uint8_t inputCmd, uint8_t param, uint8_t position, uint8_t storeIndex){
  setPrefix(inputCmd);
  uint8_t *pointer = &threeInputStore[storeIndex][position];
  *pointer = param;
  // threeInputStore[storeIndex][position] = param;

  char hexParam[14] = {};
  sprintf(hexParam, "%03d%02X%02X%02X", inputCmd, threeInputStore[storeIndex][0]*2, threeInputStore[storeIndex][1]*2, threeInputStore[storeIndex][2]*2);
  cmd[3] = ':';
  cmd[4] = hexParam[0];
  cmd[5] = hexParam[1];
  cmd[6] = hexParam[2];
  cmd[7] = hexParam[3];
  cmd[8] = hexParam[4];
  cmd[9] = hexParam[5];
  cmd[10] = hexParam[6];
  cmd[11] = hexParam[5];
  cmd[12] = hexParam[6];
}

void removeTrailingUnderscore(){
  if (cmd[0] == '_'){
    for (uint8_t i = 0; i < 11; i++)
    {
      if (cmd[i+1] != 0x00){
        cmd[i] = cmd[i+1];
      }
      else{
        cmd[i] = 0x00;
      }
    }
  }
}

