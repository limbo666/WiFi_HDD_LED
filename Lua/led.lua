
--WiFi LED for Activity Indicator (init.lua, led.lua, espresso.lua)
--DEC 2018
--Nikos Georgousis
--Set the outputs
--gpio.mode(1, gpio.OUTPUT)
--gpio.mode(2, gpio.OUTPUT)
gpio.mode(3, gpio.OUTPUT)
gpio.mode(4, gpio.OUTPUT)
--gpio.mode(5, gpio.OUTPUT)
--gpio.mode(6, gpio.OUTPUT)
--Test leds on power up
--Turn all leds ON
--gpio.write(1, 1)
--gpio.write(2, 1)
gpio.write(3, 1)
gpio.write(4, 1)
--gpio.write(5, 1)

--gpio.write(6, 1)
--Turn all leds off after 1 second
tmr.alarm(0, 1000, 0, function() 
--gpio.write(1, 0)
--gpio.write(2, 0)
gpio.write(3, 0)
gpio.write(4, 0)
--gpio.write(5, 0)
--gpio.write(6, 0)
end )

udpSocket = net.createUDPSocket() --create UDP server
udpSocket:listen(8266)
udpSocket:on("receive", function(s, data, port, ip)
	print(string.format("'%s' from %s:%d", data, ip, port)) -- diagnostic. may be removed
	--s:send(port, ip, "echo: " .. data)
	--print(string.format("local UDP socket address / port: %s:%d", ip, port))
	c=data
	if c=="ON3" then
		 gpio.write(3, 1)
		if BroadcastMyIP==1 then
			confirm()
		end 
	--print("3 is on")
	elseif c=="OFF3" then
		 gpio.write(3, 0)
		if BroadcastMyIP==1 then
			confirm()
		end
	--print("3 is off")
	elseif c=="ON4" then
		 gpio.write(4, 1)
		if BroadcastMyIP==1 then
			confirm()
		end 
	--print("4 is on")
	elseif c=="OFF4" then
		 gpio.write(4, 0)
		if BroadcastMyIP==1 then
			confirm()
		end
	end 
	--print("C is "..c)


	end)

	port, ip = udpSocket:getaddr()
	tmr.alarm(2, 2000, 1, function() --This timer broadcasts every 2 seconds the module info to get detected by Activity Indicator the program
	if BroadcastMyIP==1  then
		udpSocket:send(8266, "255.255.255.255", "WiFi LED "..ModuleID.." - IP address:"..myip ) --Message to report presence on Activity Indicator
		print("Broadcasting info "..tmr.time().." secs after start")
	else

	end 
end )

function confirm() --This fucntion confirm connection back to the program and  
	BroadcastMyIP=0  
	tmr.stop(2)	
	udpSocket:send(8266, "255.255.255.255", "WiFi LED "..ModuleID.." - Connected") --Confirmation message to send back to Activity Indicator
	print("Connected "..tmr.time().." secs after start")
end
print("System is up and running") --Startup complete
