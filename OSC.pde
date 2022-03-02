
void connectOSC( String ipAddr )
{
  tabletIPAddr = ipAddr;
  println("Connecting to osc output: " + tabletIPAddr);
  myRemoteLocation = new NetAddress( tabletIPAddr, OSC_PORT );  
}

void sendOSCValue( String addr, float v )
{
  println("sending: " + addr + "," + v);
  OscMessage myMessage = new OscMessage(addr);
  
  myMessage.add(v); 
  
  oscP5.send(myMessage, myRemoteLocation); 
  
  outputVal = v;
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
