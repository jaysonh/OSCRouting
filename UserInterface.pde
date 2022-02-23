
// Handle user interface input
void controlEvent(ControlEvent theEvent) 
{  
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
