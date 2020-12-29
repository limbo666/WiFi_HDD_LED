//Created by Nikos Georgousis
// This isan arduino port of the lua code whish is presenetd on: https://www.instructables.com/WiFi-HDD-LED/
// This skeτch should be used this WiFi HDD Led Option of Activity Indicator. Downlaod here: https://sourceforge.net/projects/activityindicat/
//
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
const char* ssid     = "YOURSSID";
const char* pw = "YOURPASS";

String ModuleID = "AI-9855"; //used to identify the LED if there are multiple on the network
char data[200] = {};
int packetsize = 0;
String receiveddata = "";
int UDPServerPort = 8266;
int BroadcastMyIP = 1 ;

WiFiUDP Server;

void setup() {
  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);       // sets the digital pin 13 on
  Serial.begin(115200);
  Serial.println();
  Serial.printf("Connecting to %s ", ssid);
  Serial.println();

  WiFi.begin(ssid, pw);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.println("WiFi connected");
  Server.begin(UDPServerPort);
  Serial.print("WiFi LED UDP port: " );
  Serial.print(  UDPServerPort);
  Serial.println();

  digitalWrite(13, LOW);        // sets the digital pin 13 off

}

void loop() {
  if (BroadcastMyIP == 1) {
    //udpSocket:send(8266, "255.255.255.255", "WiFi LED "..ModuleID.." - IP address:"..myip ) --Message to report presence on Activity Indicator
    //   print("Broadcasting info "..tmr.time().." secs after start")
    IPAddress broadcastIp = WiFi.localIP();
    broadcastIp[3] = 255;
    String LocalIP = String() + WiFi.localIP()[0] + "." + WiFi.localIP()[1] + "." + WiFi.localIP()[2] + "." + WiFi.localIP()[3];
    Serial.print("Broadcasting ID to ");
    Serial.println(broadcastIp);
    Server.beginPacket(broadcastIp, UDPServerPort);
    Server.print("Wifi LED "+ ModuleID +" - " + LocalIP);
    Server.endPacket();
    delay (200);
  }


  char message = Server.parsePacket();
  packetsize = Server.available();
  if (message)
  {

    Server.read(data, packetsize);
    delay(100);
    IPAddress remoteip = Server.remoteIP();
    //   delay(100);
    //   Serial.println(Server.beginPacket(remoteip, 81));
    //   Serial.println(remoteip);
    //   Serial.println(Server.remotePort());
    //   Serial.println(data);
    //   Server.write(data);
    Server.endPacket();
  }

  if (packetsize) {
    Serial.print("characters received: ");
    Serial.println(packetsize);
    for (int i = 0; packetsize > i ; i++)
    {
      receiveddata += (char)data[i];
    }
    Serial.println(receiveddata);
    //  Serial.println();
    if (receiveddata == "ON2")
    {
      digitalWrite(13, HIGH);       // sets the digital pin 13 on
      delay(10);                  // waits for a second
      BroadcastMyIP = 0;
    }
    else if (receiveddata == "OFF2")
    {
      digitalWrite(13, LOW);        // sets the digital pin 13 off
      delay(10);                  // waits for a second
      BroadcastMyIP = 0;
    }
    receiveddata = "";
  }
  delay(10);

  if (WiFi.status() == !WL_CONNECTED)
  {
    Serial.print(".");
    delay(200);
  }
}
