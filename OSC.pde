// Connect via OSC to an address
void connectOSC( String ipAddr ) {
  tabletIPAddr = ipAddr;
  println("Connecting to osc output: " + tabletIPAddr);
  tabletAddress = new NetAddress( tabletIPAddr, OSC_PORT );  
}

// Send a value to an OSC address
void sendOSCValue( String addr, float v ) {
  println("sending: " + addr + "," + v);
  OscMessage myMessage = new OscMessage(addr);
  
  myMessage.add(v); 
  
  oscP5.send(myMessage, tabletAddress); 
  
  oscOutputVal = v;
}


// Handle OSC events received
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}

// Send data depending on user interface selections
void sendOSCData() {
  // send data based on user interface selection
  int particleSpeedSel = (int)particleSpeedList.getValue();
  
  // send the appropriate value
  switch( particleSpeedSel )
  {
     case 0:  // arduino
       sendOSCValue("/OSCInput", arduinoInput);
     break;
     
     case 1: // mouse
       sendOSCValue("/OSCInput",map(mouseX,0,width,0,1) );
     break; 
  }
}
