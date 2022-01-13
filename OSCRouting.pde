/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
import processing.serial.*;

boolean FAKE_DATA = true;

Serial serialPort;
  int lf = 10;
OscP5 oscP5;
NetAddress myRemoteLocation;
float t= 0.0;
int portNum = 12000;
String phoneAddress = "192.168.0.100"; // this is the ip adresss of the phone running the ar face mask app "192.168.1.243"

ArrayList <String> displayValues = new ArrayList<String>();
final int maxDisplay = 30;

void setup() {
  size(400,400);
  
  if(!FAKE_DATA)
  {
    printArray(Serial.list());
    serialPort = new Serial(this, "COM12", 115200 );
  }
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5( this, portNum );
  
  myRemoteLocation = new NetAddress( phoneAddress, 12000 );
}


void draw() {
  background(0);  
  
  if(!FAKE_DATA)
  {
      while (serialPort.available() > 0) 
      {
        String myString = serialPort.readStringUntil(lf);
        if (myString != null) 
        {
          print(myString);  // Prints String
          float num=float(myString);  // Converts and prints float
          sendVal(num);
          displayValues.add( myString );
          //println(num);
        }
      }
      serialPort.clear();
  }
  
  if(FAKE_DATA)
  {
       //float num = noise( t );
       //t+= 0.05;
       float num = map( mouseX, 0, width, 0.0, 1.0 );
       sendVal(num);
       displayValues.add( "value: " + num );
  }
  
  while( displayValues.size() > maxDisplay )
  {
     displayValues.remove(0); 
  }
  
  pushMatrix();
  fill( 255);
  for( String s : displayValues )
  {
     text( s, 10, 10);
     translate( 0, 10);
  }
  popMatrix();
  
}

void sendVal( float v )
{
  OscMessage myMessage = new OscMessage("/test");
  
  myMessage.add(v); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
