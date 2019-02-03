
--WiFi LED for Activity Indicator (init.lua, led.lua, espresso.lua)
--DEC 2018
--Nikos Georgousis
ModuleID="AI-9845" --used to identify the LED if there are multiple on the network
print("WiFi LED "..ModuleID.." is starting up")
BroadcastMyIP=1 --Default is set to 1 to broadcast until connection
--###########################################
--Set up WiFi
wifi.sta.config {ssid="Toolz", pwd="Gorillaz"}
--###########################################
tmr.alarm(0, 1000, 1, function() -- check every second if the IP address is set by the DHCP server
myip=wifi.sta.getip()
	if myip ~=nil then
		--set a static IP on your LED. this should be done once the DHCP server to confirm connectivity
		wifi.sta.setip({ip='192.168.128.95',netmask='255.255.255.0',gateway='192.168.128.10'})
		myip=wifi.sta.getip() --required to verify the change if the static IP is set
		tmr.stop(0) --stop checking for IP
		print("IP: "..wifi.sta.getip()) --print it
		if file.exists("led.lua") then --run the second file if exists
			print("Starting led.lua")			
			dofile("led.lua")
		else
			print("File led.lua not found")
		end
			if file.exists("espresso.lua") then --run the third file if exists
			print("Starting espresso.lua")			
			dofile("espresso.lua")
		else
			print("File espresso.lua not found")
		end
	else

		print("Waiting for WiFi connection") --put user on hold while waiting for connection
	end
end)
