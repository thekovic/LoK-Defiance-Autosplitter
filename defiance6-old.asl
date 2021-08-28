state("defiance") {
	float x : 			0x14d4d8;
	float y : 			0x14d4dc;
	string15 cell : 	0x330bc4;
	int bossHp : 		0x20182c, 	0x194;
}

startup {
	vars.startZone = "shold1a";
	vars.startX = -3621.2f; //default position for shold1a
	vars.startY = -1271.6f; //default position for shold1a
	vars.leniency = 0.5f;
	vars.splits = new string[] {
		"eldergod1a", //split 00
		"cemetery1A", //split 01
		"CITADEL10A", //split 02
		"CITADEL14A", //split 03
		"SNOW_PILLARS10A", //split 04
		"pillars9a", //split 05
		"CITADEL11A",
		"CIT_EARLY1A", //split 07
		"CIT_EARLY12A",
		"vorador1A",
		"CITADEL12A",
		"vorador21A",
		"cit_early1A",		
		"citadel6A" //split 13
	};
	vars.currentSplit = 0;

	vars.start = false;
	vars.waitingForStart = false;

	settings.Add("split0", true, "CH1 done");
	settings.Add("split1", true, "Escape done");
	settings.Add("split2", true, "Light forge");
	settings.Add("split3", true, "Dark forge");
	settings.Add("split4", true, "CH4 4 done");
	settings.Add("split5", true, "CH5 done");
	settings.Add("split6", true, "V% Fire forge");
	settings.Add("split7", true, "CH6 done");
	settings.Add("split8", true, "V% Reaver");
	settings.Add("split9", true, "V% CH7 done");
	settings.Add("split10", true, "V% Water forge");
	settings.Add("split11", true, "V% Crypt done");
	settings.Add("split12", true, "V% CH8 done");
	settings.Add("split13", true, "EG start");
	settings.Add("bossdead", true, "EG dead");
}

update {
	vars.in_start_y = (vars.startY + vars.leniency > current.y) && (vars.startY - vars.leniency < current.y);
	vars.in_start_x = (vars.startX + vars.leniency > current.x) && (vars.startX - vars.leniency < current.x);
	if (timer.CurrentPhase == TimerPhase.NotRunning) {
		vars.currentSplit = 0;
	}
}

split {
	if (vars.currentSplit < vars.splits.Length) {
		if ((current.cell == vars.splits[vars.currentSplit]) &&
				(current.cell != old.cell)) {
			return settings["split"+(vars.currentSplit++)];
		}
	} else {
		return (current.bossHp == 0) && (current.bossHp != old.bossHp) && settings["bossdead"];
	}
}

reset {
	if (current.cell == vars.startZone && vars.in_start_y && vars.in_start_x) {
		vars.currentSplit = 0;
		vars.waitingForStart = true;
		return true;
	}
	return false;
}

start {
    if (current.cell == vars.startZone && vars.in_start_y && vars.in_start_x) {
        vars.waitingForStart =true;
    }
   
    if(vars.waitingForStart==true && current.cell == vars.startZone && !(vars.in_start_y && vars.in_start_x))
    {
        vars.waitingForStart=false;
        return true;
    }
    return false;
}