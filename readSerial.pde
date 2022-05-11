// Read the incoming data from the serial connection
void readSerialInput() { 
  // if a serial device is connected then read the data sent
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
}
