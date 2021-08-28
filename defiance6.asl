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
	
	vars.currentSplit = 0;
	
	vars.start = false;
	vars.waitingForStart = false;

	settings.Add("vorador", false, "Enable Vorador%");
	settings.SetToolTip("vorador", "By default, Any% route is followed (requires 9 splits). Enabling this option will switch to Vorador% (requires 15 splits)");
}

init {
	if (settings["vorador"]) {
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
	}
	else {
		vars.splits = new string[] {
			"eldergod1a",
			"cemetery1A",
			"CITADEL10A",
			"CITADEL14A",
			"SNOW_PILLARS10A",
			"pillars9a",
			"CIT_EARLY1A",
			"citadel6A"
		};
	}
}

update {
	vars.in_start_y = (vars.startY + vars.leniency > current.y) && (vars.startY - vars.leniency < current.y);
	vars.in_start_x = (vars.startX + vars.leniency > current.x) && (vars.startX - vars.leniency < current.x);
	if (timer.CurrentPhase == TimerPhase.NotRunning) {
		vars.currentSplit = 0;
	}
	print(vars.currentSplit.ToString());
}

split {
	if (vars.currentSplit < vars.splits.Length) {
		if ((current.cell == vars.splits[vars.currentSplit]) && (current.cell != old.cell)) {
			vars.currentSplit++;
			return true;
		}
	} else {
		return (current.bossHp == 0) && (current.bossHp != old.bossHp);
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
        vars.waitingForStart = true;
    }
   
    if (vars.waitingForStart == true && current.cell == vars.startZone && !(vars.in_start_y && vars.in_start_x))
    {
        vars.waitingForStart = false;
        return true;
    }
    return false;
}