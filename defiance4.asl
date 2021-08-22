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
	vars.leniency = 0.1f;
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
	vars.currentSplit = 0;

	vars.start = false;

	settings.Add("split0", true, "Enter the Underworld");
	settings.Add("split1", true, "Escape done");
	settings.Add("split2", true, "Light forge warpgate");
	settings.Add("split3", true, "Dark forge warpgate");
	settings.Add("split4", true, "Chapter 4 done");
	settings.Add("split5", true, "Kain pillars done");
	settings.Add("split6", true, "Raz pillars done");
	settings.Add("split7", true, "Final boss start");
	settings.Add("bossdead", true, "Final boss dead");
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
		return true;
	}
	return false;
}

start {
	bool in_start_y = (vars.startY + vars.leniency < current.y) || (vars.startY - vars.leniency > current.y);
	bool in_start_x = (vars.startX + vars.leniency < current.x) || (vars.startX - vars.leniency > current.x);
	return current.cell == vars.startZone && !(vars.in_start_y && vars.in_start_x);
}