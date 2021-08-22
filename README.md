# LoK-Defiance-Autosplitter
Uploaded with TheDuriel's permission for the purpose of updating the link for LiveSplit
## Original README
Autosplitting, start, and reset available. Code by blastedt and memory addresses found by TheDuriel. Feel free to contact either of us in event of failure.

The timer starts when you begin moving in the first level. It splits when you first enter certain maps. It is extremely trivial to add more potential splits. If you'd like your splits to be added, compile a list and message me on Steam or Discord.

## Original explanation file (vchdh.txt)
defiance.exe 

start the run when either of these values change from their defaults while unside unit "shold1a"

defiance.exe+14D4D8 float, current X coords, default: -3621.164551
defiance.exe+14D4DC float, current Y coords, default: -1271.559814

split whenever this address contains one of the following strings

defiance.exe+330BC4 text string lenght 15, contains current unit, case sensitive

	shold1a, unit in which the game starts
	eldergod1a 	- first split 	- underworld start
	cemetery1a 	- second split 	- escape done
	CITADEL10A 	- third split 	- light forge warpgate*
	CITADEL14A 	- fourth split 	- dark forge warpgate*
	SNOW_PILLARS10A - fith split 	- chapter 4 done (cemetary gate)
	pillars9a 	- sixth split 	- kain pillars done
	CIT_EARLY1A 	- seventh split - raz pillars done
	citadel6A 	- eight split 	- final boss start

	*warp101a, raziel forge loadscreen
when entering and leaving CITADEL10A or CITADEL14A we temporarily enter this unit, its a fancy loading screen. 
id like the split to occur only if the previous unit was NOT "warp101a" aka when leaving the area. but this isnt mandatory.


end the run whenever this value reaches zero or negative values while inside citadel6A

boss hp starts at 2750, the game ends at 0

any of these should work

http://i.imgur.com/v9OAEo5.png
 
