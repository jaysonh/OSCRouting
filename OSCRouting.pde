/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
import processing.serial.*;
import controlP5.*;

int OSC_PORT = 12000;

ControlP5 userInterface;

DropdownList particleSpeedList;

DropdownList serialDevList;
Textlabel    arduinoValLabel;
Button        connectBtn;
Textfield ipAddrText;

float outputVal = 0.0;

float arduinoInput = 0.0;
String []serialDevices;
Serial serialPort;
OscP5 oscP5;
NetAddress myRemoteLocation;

String tabletIPAddr = "192.168.1.212"; // this is the ip adresss of the phone/tablet running the ar face mask app "192.168.1.243"
boolean serialConnected = false;

void setup() {
  size(400,400);
  
  userInterface = new ControlP5(this);
  
  particleSpeedList = userInterface.addDropdownList("particleSpeed").setPosition(10, 25);
  particleSpeedList.setBackgroundColor(color(190));
  particleSpeedList.setItemHeight(20);
  particleSpeedList.setBarHeight(15);
  particleSpeedList.getCaptionLabel().set("particleSpeed");
  particleSpeedList.addItem("arduino",    0);
  particleSpeedList.addItem("mouse",  1);
  particleSpeedList.setValue(0);
  
  
  serialDevices = Serial.list();
  serialDevList = userInterface.addDropdownList("Serial Devices").setPosition(width-150, 220);
  serialDevList.setBackgroundColor(color(190));
  serialDevList.setItemHeight(20);
  serialDevList.setBarHeight(15);
  serialDevList.getCaptionLabel().set("Serial Devices");  
  for(int i =0; i < serialDevices.length;i++)
  {
    serialDevList.addItem(serialDevices[i],  i);    
  }
  serialDevList.setOpen(false);
    
  arduinoValLabel = userInterface.addTextlabel("Arduino Value")
                    .setText("Arduino Val: Not Connected")
                    .setPosition(width-150,110)
                    .setColorValue(0xffffffff)
                    .setFont(createFont("Arial",12))
                    ;                   
  
      
  ipAddrText = userInterface.addTextfield("tabletIPAddr")
     .setPosition(width-150,30)
     .setSize(100,20)
     .setFocus(true)
     .setValue(tabletIPAddr)
     .setColor(color(255,255,255))
     ;
   
  connectBtn = userInterface.addButton("conn")
     .setValue(100)
     .setPosition(width-40,30)
     .setSize(35,25)
     ;
         
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5( this, OSC_PORT );
  
  connectOSC( tabletIPAddr);
  
}


void draw() {
  background(0);  
  
  fill(255);
  stroke(255);
  text("OSC OUTPUT", 10,15);
  line( 0,20, 200, 20);
  
  
  fill(255);
  stroke(255);
  text("TABLET CONNECTION", width-150,15);
  line( width ,20, width-150, 20);
  
  fill(255);
  stroke(255);
  text("OSC Output", width-150,85);
  line( width, 90, width-150, 90);
    
  text("SERIAL DEVICES", width-150,200);
  line( width-150,205, width, 205);
    
  arduinoValLabel.setValue("OSC Output: " + outputVal);
  
  // send data based on user interface selection
  int particleSpeedSel = (int)particleSpeedList.getValue();
  switch( particleSpeedSel )
  {
     case 0: // mouse
       sendOSCValue("/OSCInput", arduinoInput);
     break;
     
     case 1: // arduino
       sendOSCValue("/OSCInput",map(mouseX,0,width,0,1) );
     break; 
  }
  
  if(serialConnected)
  {
      while (serialPort.available() > 0) 
      {
        int lf = 10; // line feed end
        String myString = serialPort.readStringUntil(lf);
        if (myString != null) 
        {
          arduinoInput = float(myString);          
        }
      }
      serialPort.clear();
  }
  
  // Keep the drop down list open
  particleSpeedList.setOpen(true);
}
