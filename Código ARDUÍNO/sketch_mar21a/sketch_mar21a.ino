int pinoSensor = 7;
int fkSensor1 = 1;
int fkSensor2 = 2;
int fkSensor3 = 3;


void setup() {
  pinMode(pinoSensor, INPUT);
  Serial.begin(9600);
}

void loop() {
  if (digitalRead(pinoSensor) == LOW) {
    Serial.print("1");
    Serial.print(";");
    Serial.println(fkSensor1);

    Serial.print("0");
    Serial.print(";");
    Serial.println(fkSensor2);

  } else {
    Serial.print("0");
    Serial.print(";");
    Serial.println(fkSensor1);
    
    Serial.print("1");
    Serial.print(";");
    Serial.println(fkSensor2);
  }
  delay(1000);
}