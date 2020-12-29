# WiFi  HDD LED
![Logo](https://github.com/limbo666/WiFi_HDD_LED/blob/master/Images/logo.png)

A hardware LED indicator for your HDD/ SSD activity as seen on **Hackaday**:  https://hackaday.com/2019/02/26/blink-an-led-on-the-internet-of-things/
This **ESP8266** based circuit can be used to indicate the disk activity in a similar manner the physical LED on computer tower does. 

This project is combination of software and hardware. On the software side the open source **Activity Indicator**: https://sourceforge.net/projects/activityindicat/ should be used The executable is available only for Windows OS. 

#### LUA VS Arduino
There are two different ways to program the ESP8266 and create your WiFi LED
1. Lua (under nodemcu firmware). For this use contents of the lua folder. 
1. Arduino. For this use the contents of Arduino folder.

In both cases you should change the **Wifi credentials** on the code and check that selected **GPIOs** are the ones you are using on your hardware.
The hardware is the same any case.


#### Step by Step Guide (Lua)
For the hardware side (this project) a step by step guide is available on **Instructables** https://www.instructables.com/id/WiFi-HDD-LED/ 

#### Communication
The communication is based on UDP protocol over WiFi

![Communication](https://github.com/limbo666/WiFi_HDD_LED/blob/master/Images/communication.png)

#### Circuit
The circuit is quite simple.

![Circuit](https://github.com/limbo666/WiFi_HDD_LED/blob/master/Images/diagram.png)

All components can be connected using the "deadbug" method.

![Board](https://github.com/limbo666/WiFi_HDD_LED/blob/master/Images/board.jpg)


Finally a box to hide all electronics should be used

![Board](https://github.com/limbo666/WiFi_HDD_LED/blob/master/Images/box_ready.png)
