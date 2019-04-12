#include <SoftwareSerial.h>
#include <Servo.h>
#include<string.h>


Servo ser1;
Servo ser2;
SoftwareSerial bt(12,11);

void setup(){
  Serial.begin(38400);
  bt.begin(9600);
  ser1.attach(10);
  ser1.write(21.25);
  ser2.attach(9);
  ser2.write(170);
}

void loop(){
  
  if(bt.available()>0){
    String ms = bt.readString();

    char c[4]; 
    ms.toCharArray(c, 4);
    Serial.println(ms);
    int pos1 = c[0]-'0';
    Serial.println(pos1);
    ser1.write((pos1)*21.25);

    
    int pos2 = c[1]-'0';
    Serial.println(c[1]);
    Serial.println(pos2);
    ser2.write((8-(pos2))*22.5);
  }
    if(Serial.available()>0){
    bt.println(Serial.read());
  }
  delay(20);
}
