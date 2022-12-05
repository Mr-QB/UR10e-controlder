//Motor_1 Connection
#define ENABLE_1    11
#define MOTOR_1_A   10
#define MOTOR_1_B   9
 
//Motor_2 Connection
#define ENABLE_2    5
#define MOTOR_2_A   4
#define MOTOR_2_B   3
 
//other variables
char serial_data;
int speed_value_m1;
int speed_value_m2;
 
void setup() {
  Serial.begin(9600);
  Serial.println("Motor Init..");
  motor_1_init();
  motor_2_init();
  speed_value_m1 = 0;
  speed_value_m2 = 0;
}
 
void loop() {
  motor_speed_dir_control();
}
 
void motor_1_init()
{
  pinMode(MOTOR_1_A, OUTPUT);
  pinMode(MOTOR_1_B, OUTPUT);
  pinMode(ENABLE_1, OUTPUT);
 
  digitalWrite(MOTOR_1_A, LOW);
  digitalWrite(MOTOR_1_B, LOW);
  analogWrite(ENABLE_1, LOW);
}
 
void motor_2_init()
{
  pinMode(MOTOR_2_A, OUTPUT);
  pinMode(MOTOR_2_B, OUTPUT);
  pinMode(ENABLE_2, OUTPUT);
 
  digitalWrite(MOTOR_2_A, LOW);
  digitalWrite(MOTOR_2_B, LOW);
  analogWrite(ENABLE_2, LOW);
}
void motor_speed_dir_control()
{
while (Serial.available())
{
  serial_data = Serial.read();
     switch (serial_data)
	{
  	case 's':
        	analogWrite(ENABLE_1, 255);
        	Serial.println("Enable Motor_1");
    		break;
  	case 'S':
 	analogWrite(ENABLE_2, 255);
       	Serial.println("Enable Motor_2");
    		break;
 
  	case 'h':
        	analogWrite(ENABLE_1, 0);
        	digitalWrite(MOTOR_1_A, LOW);
        	digitalWrite(MOTOR_1_B, LOW);
        	speed_value_m1 = 0;
    	Serial.println("Stop Motor_1");
    		break;
  	case 'H':
        analogWrite(ENABLE_2, 0);
        digitalWrite(MOTOR_2_A, LOW);
        digitalWrite(MOTOR_2_B, LOW);
        speed_value_m2 = 0;
        Serial.println("Stop Motor_2");
    		break;
 
  	case 'f':
digitalWrite(MOTOR_1_A, HIGH);
digitalWrite(MOTOR_1_B, LOW);
Serial.println("Motor_1 Forward Direction");
    		break;
  	case 'F':
       	 	digitalWrite(MOTOR_2_A, HIGH);
        		digitalWrite(MOTOR_2_B, LOW);
    		Serial.println("Motor_2 Forward Direction");
    		break;
 
  	case 'b':
        	digitalWrite(MOTOR_1_A, LOW);
        	digitalWrite(MOTOR_1_B, HIGH);
        	Serial.println("Motor_1 Backward Direction");
    		break;
  	case 'B':
    	digitalWrite(MOTOR_2_A, LOW);
        	digitalWrite(MOTOR_2_B, HIGH);
        	Serial.println("Motor_2 Backward Direction");
    		break;
 
  	case 'a':
    	for (int i = 0; i < 256; i++)
    	{
          		analogWrite(ENABLE_1, i);
    	}
        		Serial.println("Motor_1 acceleration");
    		break;
  	case 'A':
    	for (int i = 0; i < 256; i++)
    	{
          		analogWrite(ENABLE_2, i);
    	}
        		Serial.println("Motor_2 acceleration");
    		break;
  	case 'd':
        for (int i = 255; i > 1; i--)
    	{
          		analogWrite(ENABLE_1, i);
      		delay(5);
    	}
        		Serial.println("Motor_1 deceleration");
    		break;
  	case 'D':
    	for (int i = 255; i > 1; i--)
    	{
      		analogWrite(ENABLE_2, i);
      		delay(5);
    	}
       		Serial.println("Motor_2 deceleration");
    		break;
  	case 'i':
    	if (speed_value_m1 <= 245)
    	{
          speed_value_m1 += 10;
          analogWrite(ENABLE_1, speed_value_m1);
          Serial.println("Motor_1 increased Speed value: ");
          Serial.print(speed_value_m1);
    	}
    	else
    	{
          Serial.println("Maximum Speed Limit Reached for Motor_1: ");
          Serial.print(speed_value_m1);
    	}
    		break;
  	case 'I':
    	if (speed_value_m2 <= 245)
    	{
          speed_value_m2 += 10;
          analogWrite(ENABLE_2, speed_value_m2);
          Serial.println("Motor_2 increased Speed value: ");
          Serial.print(speed_value_m2);
    	}
    	else
    	{
          Serial.println("Maximum Speed Limit Reached for Motor_2: ");
          Serial.print(speed_value_m2);
    	}
    		break;
 
  	case 'r':
    	if (speed_value_m1 >= 10)
    	{
          speed_value_m1 -= 10;
          analogWrite(ENABLE_1, speed_value_m1);
          Serial.println("Motor_1 reduced Speed value: ");
          Serial.print(speed_value_m1);
    	}
    	else
    	{
          		Serial.println("Minimum Speed Limit Reached for Motor_1: ");
          		Serial.print(speed_value_m1);
    	}
    		break;
  	case 'R':
    	if (speed_value_m2 >= 10)
    	{
          		speed_value_m2 -= 10;
          		analogWrite(ENABLE_2, speed_value_m2);
      		Serial.println("Motor_2 reduced Speed value: ");
          		Serial.print(speed_value_m2);
    	}
    	else
    	{
          		Serial.println("Minimum Speed Limit Reached for Motor_2: ");
          		Serial.print(speed_value_m2);
    	}
    	break;
 
  	case 'X':
        	digitalWrite(MOTOR_1_A, HIGH);
       	 digitalWrite(MOTOR_1_B, LOW);
       	 digitalWrite(MOTOR_2_A, HIGH);
        	digitalWrite(MOTOR_2_B, LOW);
        	analogWrite(ENABLE_1, 255);
        	analogWrite(ENABLE_2, 255);
    	Serial.println("Motor_1 and Motor_2 Forward Direction");
    		break;
    	
  	case 'Y':
        	digitalWrite(MOTOR_1_A, LOW);
        	digitalWrite(MOTOR_1_B, HIGH);
        	digitalWrite(MOTOR_2_A, LOW);
        	digitalWrite(MOTOR_2_B, HIGH);
        	analogWrite(ENABLE_1, 255);
        	analogWrite(ENABLE_2, 255);
        	Serial.println("Motor_1 and Motor_2 Backward Direction");
        	break;
    	
  	case 'Z':
        	digitalWrite(MOTOR_1_A, LOW);
        	digitalWrite(MOTOR_1_B, LOW);
        	digitalWrite(MOTOR_2_A, LOW);
        	digitalWrite(MOTOR_2_B, LOW);
        	analogWrite(ENABLE_1, 0);
        	      	analogWrite(ENABLE_2, 0);
       	      	Serial.println("Motor_1 and Motor_2 Stop");
    	      	break;
  	default:
    		break;
	}
     }
}