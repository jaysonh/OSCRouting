/**
 *
 * OSCRouting
 * Routes messsages sent via serial from an Arduino or ESP32 board to a phone or tablet running Unity3D via OSC. 
 * Can also generate test data to send via OSC for debugging conenections.
 *
 * todo: implement some better design patterns, proper javadoc comments
 */
 
 // imports
import oscP5.*;
import netP5.*;
import processing.serial.*;
import controlP5.*;

// global consts (replace with a singleton later)
final int OSC_PORT = 12000;

// user interface objects
ControlP5    userInterface;
DropdownList particleSpeedList;
DropdownList serialDevList;
Textlabel    arduinoValLabel;
Button       connectBtn;
Textfield    ipAddrText;

// Variables for data sent/received
float oscOutputVal = 0.0;
float arduinoInput = 0.0;

// Serial
String [] serialDevices; // list of serial objects available 
Serial    serialPort;    // selected serial object

// Network 
OscP5      oscP5;
NetAddress tabletAddress;                  // connection to tablet/phone which is running the Unity ap
String     tabletIPAddr = "192.168.1.212"; // this is the ip adresss of the phone/tablet running the ar face mask app "192.168.1.243"
boolean    serialConnected = false;

void setup() {  
  size(400,400);
  
  createUI( this );
  frameRate(25); // set the framerate to reduce frequencey at which messages are sent
  
  // start oscP5, listening for incoming messages at port 12000 
  oscP5 = new OscP5( this, OSC_PORT );
  
  // Connect to the tablet/phone running unity
  connectOSC( tabletIPAddr);  
}


void draw() {
  background(0);  
  
  // draw the 
  drawUI();
  
  sendOSCData();
  
  // if a serial device is connected the nread the incoming value
  readSerialInput();
  
}
