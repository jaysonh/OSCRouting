
// Handle user interface input
void controlEvent(ControlEvent theEvent) {  
 if( theEvent.getController() == connectBtn)
 {
   connectOSC( ipAddrText.getText());
 }
 if( theEvent.getController() == serialDevList)
 {
     int selection = (int) theEvent.getController().getValue();
     println("Connecting to: " + serialDevices[ selection]);
     serialPort = new Serial(this, serialDevices[ selection], 115200 );   
     serialConnected = true;
 }  
}

void drawUI() { 
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
    
  arduinoValLabel.setValue("OSC Output: " + oscOutputVal );   
  
  // Keep the drop down list open
  particleSpeedList.setOpen(true);
}

// Setup the user interface using controlP5
void createUI(PApplet app) { 
  
  // create user interface
  userInterface = new ControlP5( app );
  
  // create a drop down list to select which paramter to control particle speed
  particleSpeedList = userInterface.addDropdownList("particleSpeed").setPosition(10, 25);
  particleSpeedList.setBackgroundColor(color(190));
  particleSpeedList.setItemHeight(20);
  particleSpeedList.setBarHeight(15);
  particleSpeedList.getCaptionLabel().set("particleSpeed");
  particleSpeedList.addItem("arduino",    0);
  particleSpeedList.addItem("mouse",  1);
  particleSpeedList.setValue(0);
  
  // create a drop down list with all the available serial devices
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
    
  // create a label displaying info about the arduino connnection  
  arduinoValLabel = userInterface.addTextlabel("Arduino Value")
                    .setText("Arduino Val: Not Connected")
                    .setPosition(width-150,110)
                    .setColorValue(0xffffffff)
                    .setFont(createFont("Arial",12))
                    ;                   
  
  // create a label displaying ip address of the tablet    
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
}
