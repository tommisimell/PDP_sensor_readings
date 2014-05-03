// Graphing sketch
 
 
 // This program takes ASCII-encoded strings
 // from the serial port at 9600 baud and graphs them. It expects values in the
 // range 0 to 1023, followed by a newline, or newline and carriage return
 
 // Created 20 Apr 2005
 // Updated 18 Jan 2008
 // by Tom Igoe
 // This example code is in the public domain.
 
 import processing.serial.*;
 
 Serial myPort;        // The serial port
 int xPos = 30;         // horizontal position of the graph, starts a bit right from the graph numbers
 
 float sensor1Temp = 0.0;
 float sensor2Temp = 0.0;
 float sensor3Temp = 0.0;
 float sensor4Temp = 0.0;
 float sensor5Temp = 0.0;
 float sensor6Temp = 0.0;
 float sensor7Temp = 0.0;
 //int inSensorNumber = 0;
 String inSensorNumber = "";
 
 void setup () {
 // set the window size:
 size(800, 600);        
 
 // List all the available serial ports
 println(Serial.list());

 
 
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 
 // MULLA PORT 14
 myPort = new Serial(this, Serial.list()[0], 115200);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
 // set inital background:
 background(255,255,255);
 }
 void draw () {
   
  fill(255,255,255);
  rect(50,30,700,100); 
   
  fill(0);
  textSize(20);
  text(nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2), 50, 50);
 
 
   //stroke for guiding lines
  //stroke(255,230,230);
  stroke(0);
  //50 Degree line
     fill(255,0,0);
  textSize(15);
  text("50", 10, height -300);
  line(0,height - 294,width, height -294);
  
  //40 Degree line
  fill(255,40,40);
  text("40", 10, height -240);
  line(0,height - 234,width, height -234);
  
  //30 Degree line
    
  fill(255,120,120);
  text("30", 10, height -180);
  line(0,height - 175,width, height -175);
  
  //20 Degree line
    
  fill(150,150,150);
  text("20", 10, height -125);
  line(0,height - 120,width, height - 120); 
  
  //10 Degree line
  fill(100,100,220);
  text("10", 10, height -65);
  line(0,height - 60,width, height -60);
  
  fill(0,0,255);
  textSize(20);
  text("Sensor 1: " + sensor1Temp + "     Sensor 3: " + sensor3Temp + "    Sensor 5: " + sensor5Temp, 200, 50);
  text("Sensor 2: " + sensor2Temp + "     Sensor 4: " + sensor4Temp + "    Sensor 6: " + sensor6Temp, 200, 100);
 }
 
 void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 
 if (inString != null) {
   
   println(inString);

 // trim off any whitespace:
 inString = trim(inString);
 
 
   if (inString.length() > 30){
     
    String[] inStringSplit = split(inString, ':');
    inString = inStringSplit[1];
    
    String inSensor = inStringSplit[0];
     println(inSensor);
    inSensor = split(inSensor, "sensor")[1]; 
    inSensor = split(inSensor, "is")[0];
      inSensorNumber = trim(inSensor);
      println(inSensorNumber);
 //   inSensorNumber = int(inSensor); 
   }


 

 // convert to an int and map to the screen height:
 float inByte = float(inString);

//Removes annoying 100 from beginning
if (inByte > 99.0) {
 inByte = 0.0; 
}

if (inSensorNumber.equals("")) {
 println("jee"); 
}
 else {

       
 if (inSensorNumber.equals("1")) {
   sensor1Temp = inByte;
 }
  if (inSensorNumber.equals("2")) {
   sensor2Temp = inByte;
 }
  if (inSensorNumber.equals("3")) {
   sensor3Temp = inByte;
 }
  if (inSensorNumber.equals("4")) {
   sensor4Temp = inByte;
 }
  if (inSensorNumber.equals("5")) {
   sensor5Temp = inByte;
 }
  if (inSensorNumber.equals("6")) {
   sensor6Temp = inByte;
 }
  if (inSensorNumber.equals("7")) {
   sensor1Temp = inByte; //too lazy to change Arduino code, there are only six sensors
 }
}

/*if (inSensorNumber != 0) {
 

       
 if (inSensorNumber == 1) {
   sensor1Temp = inByte;
 }
  if (inSensorNumber == 2) {
   sensor2Temp = inByte;
 }
  if (inSensorNumber == 3) {
   sensor3Temp = inByte;
 }
  if (inSensorNumber ==4) {
   sensor4Temp = inByte;
 }
  if (inSensorNumber == 5) {
   sensor5Temp = inByte;
 }
  if (inSensorNumber == 6) {
   sensor6Temp = inByte;
 }
  if (inSensorNumber == 7) {
   sensor7Temp = inByte;
 }
}*/

 inByte = map(inByte, 0, 1023, 0, height);
 
 // draw the line:
 stroke(127,34,255);
 line(xPos, height, xPos, height - (inByte * 10));
 
 // at the edge of the screen, go back to the beginning:
 if (xPos >= width) {
 //xPos = 0;
   xPos = 30;
 //This needs to be changed!!
 background(255,255,255);
 }
 else {
 // increment the horizontal position:
 xPos++;
 }
 }
 }
