//**********************************
//global variables
//**********************************

import zlib.ash;
stat primestat = my_primestat();
class myclass = my_class();
boolean skipStatNCs = my_path() == "BIG!" || my_path() == "Class Act II: A Class For Pigs";

int internalQuestStatus(string prop)
{
	string status = get_property(prop);
	if(status == "unstarted")
	{
		return -1;
	}
	if(status == "started")
	{
		return 0;
	}
	if(status == "finished")
	{
		//Does not handle quests with over 9998 steps. That\'s the Gnome letter quest, yes?
		return 9999;
	}
	matcher my_element = create_matcher("step(\\d+)", status);
	if(my_element.find())
	{
		return to_int(my_element.group(1));
	}
	return -1;
}



int equipmentAmount(item equipment)
{
	if(equipment == $item[none])
	{
		return 0;
	}
    int amount = item_amount(equipment) + equipped_amount(equipment);

	return amount;
}

boolean possessEquipment(item equipment)
{
	return equipmentAmount(equipment) > 0;
}

boolean autoadv (location loc) {
if (my_adventures() > 0 )
{
    adv1(loc, -1, "");
    return true;
} else 
{
    abort();
    return false;
}
 

}

//**********************************
//stolen from newlife
//**********************************



void set_choice(string adventure, string choice, string purpose) {
	if(get_property(adventure) != choice) {
		if(purpose != "")
			vprint(purpose, "olive", 3);
		set_property(adventure, choice);
	}
}
void set_choice(string adventure, int choice, string purpose) {
	set_choice(adventure, to_string(choice), purpose);
}
void set_choice(int adventure, int choice, string purpose) {
	set_choice("choiceAdventure" + to_string(adventure), to_string(choice), purpose);
}


void set_choice_adventures() {
	if ( get_property("newlifecomplete").to_string() == true ) {
		return;
	}
	// These choices are sometimes changed during an ascension, so make certain that they are changed back.
	// No need for comments on each line because the last parameter explains what each choice adventure does.
	set_choice(502, 2, "Spooky Forest: Get the mosquito");
	set_choice(505, 1, "");
	set_choice(882, 1, "");
	set_choice(507, 1, "");
	set_choice(112, 2, "Harold's Hammer is suboptimal");
	set_choice(4, 3, "No poultrygeist is needed");
	set_choice(25, 3, "Dungeon of Doom: Don't buy a mimic");
	set_choice(875, 1, "Billiards Room: Play Pool");
	set_choice(888, 4, "Library, Rise of the House of Spookyraven: Ignore");
	set_choice(889, 4, "Library, Fall of the House of Spookyraven: Ignore");
	set_choice(877, 1, "Bedroom, Mahogany Nightstand: old coin purse");
	if(in_hardcore() && my_path() == "Nuclear Autumn") // Cannot cook a wine bomb, so spectacles are useless
		set_choice(878, 3, "Bedroom, Ornate Nightstand: Get disposable instant camera");
	else
		set_choice(878, 4, "Bedroom, Ornate Nightstand: Get spectacles");
	if(my_path() == "Bees Hate You")
		set_choice(879, 3, "Bedroom, Rustic Nightstand: Fight Mistress for Antique Mirror");
	else if(primestat == $stat[Moxie] || my_path() == "The Source")
		set_choice(879, 1, "Bedroom, Rustic Nightstand: Get Moxie Stats");
	else
		set_choice(879, 2, "Bedroom, Rustic Nightstand: Get grouchy restless spirit");
	set_choice(880, 1, "Bedroom, Elegant Nightstand: Get Lady Spookyraven's finest gown");
	set_choice(106, 2, "Ballroom song: Non-combat");
	set_choice(89, 6, "Haunted Gallery: Ignore 'Out in the Garden'");
	set_choice("louvreDesiredGoal", 7, "Haunted Gallery: Get Lady Spookyraven's dancing shoes");
	set_choice("lightsOutAutomation", 1, "Lights Out at Spookyraven Manor: Free adventures FTW!");
	set_choice(451, 3, "Greater-than Sign: Get plus sign");
	set_choice(523, 4, "Defiled Cranny: Fight swarm of ghoul whelps");
	set_choice(22, 4, "Pirate's Cove: Complete the Outfit (eyepatch or pants)");
	set_choice(23, 4, "Pirate's Cove: Complete the Outfit (eyepatch or parrot)");
	set_choice(24, 4, "Pirate's Cove: Complete the Outfit (parrot or pants)");
	set_choice(556, 1, "Itznotyerzitz Mine: Complete the Outfit");
	set_choice(15, 4, "eXtreme Slope: Complete the Outfit (mittens or scarf)");
	set_choice(16, 4, "eXtreme Slope: Complete the Outfit (scarf or pants)");
	set_choice(17, 4, "eXtreme Slope: Complete the Outfit (mittens or pants)");
	#set_choice(575, 2, "eXtreme Slope, Duffel on the Double: Frostigkraut");
	set_choice(182, 4, "Fantasy Airship: Get the model airship");
	set_choice(134, 1, "Wheel in the Pyramid: Put wheel on spoke and turn it");
	set_choice(135, 1, "Wheel in the Pyramid: Turn Wheel");
	set_choice(139, 3, "Hippies on the Verge of War, Bait and Switch: Fight a cadet");
	set_choice(140, 3, "Hippies on the Verge of War, Thin Tie-Dyed Line: Fight a drill sergeant");
	set_choice(142, 3, "Hippies on the Verge of War, Blockin' Out the Scenery (Frat Boy Ensemble): Start the War!");
	set_choice(143, 3, "Frats on the Verge of War, Catching Some Zetas: Fight a pledge");
	set_choice(144, 3, "Frats on the Verge of War, One Less Room Than In That Movie: Fight a drill sergeant");
	set_choice(146, 3, "Frats on the Verge of War, Fratacombs (War Hippy Fatigues): Start the War!");
	set_choice(136, 4, "Hippy Camp: Complete the Outfit");
	set_choice(137, 4, "Hippy Camp: Complete the Outfit");
	set_choice(138, 4, "Frat House: Complete the Outfit");
	// Giant's Castle, there are a lot of items that can change optimality. Few are ALWAYS correct so reset others to manual
	set_choice(669, 0, "Furry Giant's Room: Manual");
	set_choice(670, 0, "Fitness Giant's Room: Manual");
	set_choice(671, 0, "Neckbeard Giant's Room: Manual");
	set_choice(672, 3, "Possibility Giant's Room: skip adventure");
	set_choice(673, 1, "Procrastination Giant's Room: very overdue library book");
	set_choice(674, 3, "Renaissance Giant's Room: skip adventure");
	set_choice(675, 0, "Goth Giant's Room: Manual");
	set_choice(676, 0, "Raver Giant's Room: Manual");
	set_choice(677, 0, "Steam Punk Giant's Room: Manual");
	set_choice(678, 0, "Punk Rock Giant's Room: Manual");
	if(my_path() == "Actually Ed the Undying")
		set_choice(679, 2, "Ed Spins That Wheel, Giants Get Real");
	else
		set_choice(679, 1, "Spin That Wheel, Giants Get Real");
	// Hidden City!
	set_choice(781, 1, "An Overgrown Shrine (Northwest)");
	set_choice(783, 1, "An Overgrown Shrine (Southwest)");
	set_choice(785, 1, "An Overgrown Shrine (Northeast)");
	set_choice(787, 1, "An Overgrown Shrine (Southeast)");
	// For NS'15
	if(my_path() == "Actually Ed the Undying") { // Ed Doesn't work the NS Tower
		set_choice(923, 1, "Black Forest, Head to the Blackberry patch");
		set_choice(924, 1, "Black Forest, Head to the Blackberry patch");
		set_choice(1026, 3, "Ed has no need for an electric boning knife");
	} else {
		set_choice(923, 1, "Black Forest, Head to the Blackberry patch");
		set_choice(924, 3, "Black Forest, Get beehive");
		set_choice(1018, 1, "Black Forest, Get beehive");
		set_choice(1019, 1, "Black Forest, Get beehive");
		set_choice(1026, 2, "Giant's Castle, Get electric boning knife");
	}
	if(be_good($item[munchies pill]))
		set_choice("violetFogGoal", 8, "Violet Fog is great place to get the munchies.");
	else
		set_choice("violetFogGoal", 0, "Violet Fog is too out of date to care about.");
	
	// Ghost Dog
	if(my_path() == "License to Adventure")
		set_choice(1106, 2, 'Ghost Dog says, "Wooof! Wooooooof!": Get buff since you don\'t need dog food or stats.'); // 1 is stats, 2 is buff, 3 is Ghost Dog food
	set_choice(1107, 1, "Play Fetch with your Ghost Dog: Get 1 tennis ball");
	set_choice(1108, my_ascensions() % 2 + 1, "Your Dog Found Something Again: Get food or booze"); // 1 is food, 2 is booze - Alternate
	
	// Path specific choices
	if(my_path() == "Way of the Surprising Fist")
		set_choice(297, 1, "Haiku Dungeon: Gaffle some mushrooms");
	else
		set_choice(297, 3, "Haiku Dungeon: Skip adventure to keep looking for the Bugbear Disguise");
	if(my_path() == "Way of the Surprising Fist" && in_hardcore()) {
		set_choice(153, 2, "Defiled Alcove: get meat");
		set_choice(155, 3, "Defiled Nook: get meat");
		set_choice(157, 2, "Defiled Niche: get meat");
	} else {
		set_choice(153, 4, "Defiled Alcove: skip adventure");
		set_choice(157, 4, "Defiled Niche: skip adventure");
		if(my_path() == "Zombie Slayer" && !have_familiar($familiar[Hovering Skull]) && storage_amount($item[talkative skull]) == 0)
			set_choice(155, 1, "Defiled Nook: get talkative skull familiar");
		else
			set_choice(155, 4, "Defiled Nook: skip adventure");
	}
	if($strings[Way of the Surprising Fist, Avatar of Boris] contains my_path()) {
		// Can't use the outfit, so get some meat
		set_choice(18, 3, "Itznotyerzitz Mine: Get some meat");
		set_choice(19, 3, "Itznotyerzitz Mine: Get some meat");
		set_choice(20, 3, "Itznotyerzitz Mine: Get some meat");
	} else {
		set_choice(18, 4, "Itznotyerzitz Mine: Complete the Outfit (mattock or pants)");
		set_choice(19, 4, "Itznotyerzitz Mine: Complete the Outfit (helmet or pants)");
		set_choice(20, 4, "Itznotyerzitz Mine: Complete the Outfit (helmet or mattock)");
	}
	// If this is a Bad Bee run and you go to McMillicancuddy's Farm, then this is optimal (no chaos Butterfly)
	if(my_path() == "Bees Hate You") {
		set_choice(147, 1, "McMillicancuddy's Farm: Granary");
		set_choice(148, 2, "McMillicancuddy's Farm: Family Plot");
		set_choice(149, 1, "McMillicancuddy's Farm: Shady Thicket");
	} else {
		set_choice(147, 3, "McMillicancuddy's Farm: Pond");
		set_choice(148, 1, "McMillicancuddy's Farm: Back 40");
		set_choice(149, 2, "McMillicancuddy's Farm: The Other Back 40");
	}
	// In BIG! There is no need for leveling up
	if(skipStatNCs) {
		set_choice("oceanDestination", "ignore", "At the Poop Deck: Skip the wheel");
	} else {
		set_choice("oceanDestination", to_lower_case(primestat), "At the Poop Deck: take the Wheel and Sail to "+primestat+" stats");
	}
	
	// Prime Stat specific choices
	vprint("Setting choice adventures for "+ primestat +" class.", 3);
	switch(primestat) {
	case $stat[muscle]:
		set_choice(73, 1, "Whitey's Grove: Get Muscle stats");
		set_choice(74, 2, "Whitey's Grove: Get boxes of wine");
		set_choice(75, 2, "Whitey's Grove: Get white lightning");
		set_choice(90, 3, "Ballroom Curtains: skip adventure");
		set_choice(184, 1, "That Explains all the Eyepatches in Barrrney's Barrr: fight a pirate");
		set_choice(186, 1, "A Test of Testarrrsterone in Barrrney's Barrr: get stats");
		set_choice(191, 3, "F'c'le, Chatterboxing: get Muscle stats");
		set_choice(402, 1, "Bathroom, Don't Hold a Grudge: Get Muscle stats");
		set_choice(141, 2, "Hippies on the Verge of War, Blockin' Out the Scenery: Get rations");
		set_choice(145, 1, "Frats on the Verge of War, Fratacombs: Get Muscle stats");
		set_choice(793, 1, "Take Muscle vacation.");
		set_choice(876, 2, "Bedroom, White Nightstand: Get Muscle stats");
		if(my_path() == "The Source")
			set_choice(153, 1, "Defiled Alcove: Desperately need mainstat when fighting the Source");
		break;
	case $stat[mysticality]:
		set_choice(73, 3, "Whitey's Grove: Get wedding cake and rice");
		set_choice(74, 2, "Whitey's Grove: Get boxes of wine");
		set_choice(75, 1, "Whitey's Grove: Get Mysticality stats");
		set_choice(90, 3, "Ballroom Curtains: skip adventure");
		set_choice(184, 2, "That Explains all the Eyepatches in Barrrney's Barrr: shot of rotgut");
		set_choice(186, 1, "A Test of Testarrrsterone in Barrrney's Barrr: get stats");
		set_choice(191, 4, "F'c'le, Chatterboxing: get Mysticality stats");
		set_choice(402, 2, "Bathroom, Don't Hold a Grudge: Get Mysticality stats");
		set_choice(141, 1, "Hippies on the Verge of War, Blockin' Out the Scenery: Get Mysticality stats");
		set_choice(145, 2, "Frats on the Verge of War, Fratacombs: Get food");
		set_choice(793, 2, "Take Mysticality vacation.");
		if(my_path() == "The Source") {
			set_choice(157, 1, "Defiled Niche: Desperately need mainstat when fighting the Source");
			set_choice(876, 2, "Bedroom, White Nightstand: Get Muscle stats");
		} else
			set_choice(876, 1, "Bedroom, White Nightstand: old leather wallet");
		break;
	case $stat[moxie]:
		set_choice(73, 3, "Whitey's Grove: Get wedding cake and rice");
		set_choice(74, 1, "Whitey's Grove: Get Moxie stats");
		set_choice(75, 2, "Whitey's Grove: Get white lightning");
		if(skipStatNCs)  // No need to level up in BIG!
			set_choice(90, 3, "Ballroom Curtains: skip adventure");
		else
			set_choice(90, 2, "Ballroom Curtains: get Moxie stats");
		set_choice(184, 1, "That Explains all the Eyepatches in Barrrney's Barrr: fight a pirate");
		set_choice(186, 3, "A Test of Testarrrsterone in Barrrney's Barrr: get lots of Moxie"); 
		set_choice(191, 1, "F'c'le, Chatterboxing: get Moxie stats");
		set_choice(402, 3, "Bathroom, Don't Hold a Grudge: Get Moxie stats");
		set_choice(141, 2, "Hippies on the Verge of War, Blockin' Out the Scenery: Get rations");
		set_choice(145, 2, "Frats on the Verge of War, Fratacombs: Get food");
		set_choice(793, 3, "Take Moxie vacation.");
		if(my_path() == "The Source") {
			set_choice(876, 2, "Bedroom, White Nightstand: Get Muscle stats");
			set_choice(155, 1, "Defiled Nook: Desperately need mainstat when fighting the Source");
		} else
		set_choice(876, 1, "Bedroom, White Nightstand: old leather wallet");
		break;
	}
	if(getvar("newLife_SetupGuyMadeOfBees").to_boolean())
		set_choice(105, 3, "Bathroom, Having a Medicine Ball: Say, \"Guy made of Bees.\"");
	else if(primestat == $stat[mysticality] && !skipStatNCs)
		set_choice(105, 1, "Bathroom, Having a Medicine Ball: Get Mysticality stats");
	else {
		set_choice(105, 2, "Bathroom, Having a Medicine Ball: Skip adventure");
		set_choice(107, 4, "");
	}
	
	// Set up for Dis in a Jif. Feature Creep?
	// This way I can change them later to get a specific buff without worry about completing the quest next ascension.
	set_choice(560, 1, "Clumsiness Grove, Prepare for Fighting");
	set_choice(561, 1, "Clumsiness Grove, The Thorax");
	set_choice(563, 1, "Clumsiness Grove, Prepare for Fighting");
	set_choice(564, 1, "Maelstrom of Lovers, Prepare for Fighting");
	set_choice(565, 1, "Maelstrom of Lovers, The Terrible Pinch");
	set_choice(566, 1, "Maelstrom of Lovers, Prepare for Fighting");
	set_choice(567, 1, "Glacier of Jerks, Prepare for Fighting");
	set_choice(568, 1, "Glacier of Jerks, Mammon the Elephant");
	set_choice(569, 1, "Glacier of Jerks, Prepare for Fighting");
	
	vprint("Optimal ascension choices set.", "blue", 3);

	//3BH additions
	set_choice("choiceAdventure692", 11, "DD: Use Lockpicks");
	set_choice("choiceAdventure691", 2, "DD: Use Lockpicks");
	set_choice("choiceAdventure690", 2, "DD: Boring Door");
	set_choice("choiceAdventure693", 2, "DD: Use pole");
	set_choice("choiceAdventure670", 4, "You Don't Mess Around with Gym: Open Ground floor (with amulet)");
	set_choice("choiceAdventure669", 1, "Open Floor with umbrella");
	set_choice("choiceAdventure675", 2, "Goth Complete Quest");
	set_choice("choiceAdventure678", 1, "Punk Rock Complete Quest");
	set_choice("choiceAdventure676", 4, "Raver to punk rock");
	set_choice("choiceAdventure677", 1, "Steampunk Complete Quest");
	set_choice("choiceAdventure671", 4, "Steampunk Complete Quest");
	cli_execute("set newlifecomplete = true;");
}




void prep() {
cli_execute("set choiceAdventure1062 => 1;");
cli_execute("set choiceAdventure502 => 2;");
cli_execute("set choiceAdventure505 => 1;");
cli_execute("set choiceAdventure875 => 1;");
cli_execute("set choiceAdventure888 => 4;");
cli_execute("set choiceAdventure889 => 4;");
print("Prefs_Set Done");
cli_execute("set recoveryScript = scripts\\Universal_recovery.ash");
cli_execute("set autoSatisfyWithCoinmasters = true;");
cli_execute("set hpAutoRecovery = 0.3;");
cli_execute("set customCombatScript = multiscript");
set_choice(878, 4, "Bedroom, Ornate Nightstand: Get spectacles");
set_choice(788, 1, "bowl and fight spirit");
set_choice(786, 1, "bowl and fight spirit");
set_choice(784, 1, "bowl and fight spirit");
set_choice(780, 1, "bowl and fight spirit");
set_choice("choiceAdventure791", 1, "fight protecter");
while (item_amount($item[ten-leaf clover]) >0) 	{
	cli_execute("use ten-leaf clover");
}

}

void galactic() {
	print("Doc");
	if ( get_property("questM24Doc").to_string() == "finished" ) {
			return;
		}
	print("Starting Doc Quest");
	cli_execute("maximize mainstat");
	cli_execute("use homeopathic elixir");
	if(internalQuestStatus("questM24Doc") == -1) {
		string temp = visit_url("shop.php?whichshop=doc");
		temp = visit_url("shop.php?whichshop=doc&action=talk");
		temp = visit_url("choice.php?pwd=&whichchoice=1064&option=1");
		}

	while ( internalQuestStatus("questM24Doc") < 10 ) {
		autoadv($location[The Overgrown Lot]);
		if((item_amount($item[Swindleblossom]) >= 3) && (item_amount($item[Fraudwort]) >= 3) && (item_amount($item[Shysterweed]) >= 3)) {
			string temp = visit_url("shop.php?whichshop=doc");
			temp = visit_url("shop.php?whichshop=doc&action=talk");
			temp = visit_url("choice.php?pwd=&whichchoice=1064&option=2");
			return;
		}
	}
}

void larva() {
	print("Larva");
	council();
	if ( get_property("questL02Larva").to_string() == "finished" ) {
		print("Larva Done");
		return;
	}

	while (item_amount($item[mosquito larva]) < 1) {
		autoadv($location[The Spooky Forest]);
	}
	council();
	cli_execute("use familiar gro;");

}

void painter() {
	if ( get_property("questM02Artist").to_string() == "finished" ) {
		print("painter Done");
		return;
	}
	while (item_amount($item[pretentious paintbrush]) < 1) {
			autoadv($location[The Outskirts of Cobb\'s Knob]);
			cli_execute("refresh inv");
	}
	while (item_amount($item[pail of pretentious paint]) < 1) {
			autoadv($location[The Sleazy Back Alley]);
			cli_execute("refresh inv");
	}
	while (item_amount($item[pretentious palette]) < 1) {
			autoadv($location[The Haunted Pantry]);
			cli_execute("refresh inv");
	}
}

void rats() {
	print("Rats");
	if ( get_property("questL03Rat").to_string() == "finished" ) {
		print("Rats Done");
		return;
	}
	council();
	cli_execute("tavern quest faucet");

}

void lvltosix() {
	print("lvltosix");
	if (have_familiar($familiar[smiling rat])) {
		cli_execute("familiar smiling rat");
		} else {
		cli_execute("use smiling rat; familiar smiling rat");
	}


	while (my_level() < 6)  {
	visit_url("cellar.php?action=autofaucet");
	run_combat();
		if (my_hp() < 15) {
			if (have_effect($effect[Beaten Up]) > 1){
				visit_url("campground.php?action=rest");
			}
			cli_execute("use homeopathic elixir");
		}
	}
}


void spookyraven() {
	print("spookyraven");
#while ( internalQuestStatus("questM24Doc") < 10 )
	if ( get_property("questM20Necklace").to_string() == "finished" ) {
		return;
	}

	if(item_amount($item[Telegram From Lady Spookyraven]) > 0) {
		use(1, $item[Telegram From Lady Spookyraven]);
	}
	council();

	if ( possessEquipment($item[double-ice cap]) ) {
			equip($item[double-ice cap]);
		} else {
		cli_execute("acquire double-ice cap");
		equip($item[double-ice cap]);
	}
	visit_url("main.php?");
	visit_url("messages.php");
	if(item_amount($item[Telegram From Lady Spookyraven]) > 0){
			print("Lady Spookyraven quest not detected as started should have been auto-started. Starting it. If you are not in an Ed run, report this. Otherwise, it is expected.", "red");
			use(1, $item[Telegram From Lady Spookyraven]);
	}

	while (item_amount($item[Spookyraven billiards room key]) < 1) {
			autoadv($location[The Haunted Kitchen]);
			cli_execute("refresh inv");
	}
	if (my_inebriety() < 9 ) {
		abort("drink up me hearties");
	}
	while (item_amount($item[[7302]Spookyraven library key]) < 1) {
		if(item_amount($item[handful of hand chalk]) > 0){
			use(1, $item[handful of hand chalk]);
		}

		if ( possessEquipment($item[Pool Cue]) ) {
			equip($item[Pool Cue]);
		}

		autoadv($location[The Haunted Billiards Room]);
		cli_execute("refresh inv");
	}

	while (item_amount($item[Lady Spookyraven\'s necklace]) < 1) {
		autoadv($location[The Haunted Library]);
		cli_execute("refresh inv");
	}

	if ((item_amount($item[Lady Spookyraven\'s necklace]) > 0)) {
		visit_url("place.php?whichplace=manor1&action=manor1_ladys");
	}

}
void digikey() {
	print("digikey");
    if (my_level() >= 6) {
		return;
	}

    while (item_amount($item[Digital Key]) < 1) {
        if(creatable_amount($item[Digital Key]) > 0 && item_amount($item[Digital Key]) == 0){
                cli_execute("acquire digital key");
            }
        autoadv($location[8-bit Realm]);
        cli_execute("refresh inv");
    }
}

void spooky2 () {
	print("spooky2");
	if ( get_property("questM21Dance").to_string() == "finished" ) {
		return;
	}
	visit_url("place.php?whichplace=manor2&action=manor2_ladys");
	print(internalQuestStatus("questM21Dance"));
	if ( internalQuestStatus("questM21Dance") >= 3 ) {
		return;
	}


	if ( possessEquipment($item[ring of conflict]) ) {
			equip($item[ring of conflict]);
	} else {
		cli_execute("acquire ring of conflict");
		equip($item[ring of conflict]);
	}

	cli_execute("refresh inv");

	while (item_amount($item[Lady Spookyraven\'s powder puff]) < 1) {
		autoadv($location[The Haunted Bathroom]);
		cli_execute("refresh inv");
	}

	while (item_amount($item[Lady Spookyraven\'s finest gown]) < 1) {
		autoadv($location[The Haunted Bedroom]);
		cli_execute("refresh inv");
	}

	while (item_amount($item[Lady Spookyraven\'s dancing shoes]) < 1) {
		autoadv($location[The Haunted Gallery]);
		cli_execute("refresh inv");
	}
	visit_url("place.php?whichplace=manor2&action=manor2_ladys");

}

void dailyDung() {
	print("dailyDung");
	if (get_property("dailyDungeonDone") == true) {
			return;
	}
	if (item_amount($item[fat loot token]) >= 3) {
		return;
	}
	cli_execute("acquire ring of Detect Boring Doors");
	cli_execute("acquire eleven-foot pole");
	cli_execute("acquire Pick-O-Matic lockpicks");
	while (get_property("dailyDungeonDone") == false) {
		cli_execute("maximize mainstat, +equip ring of Detect Boring Doors");
		autoadv($location[The Daily Dungeon]);
	}
}

void powerlevelprep() {
	print("powerlevelprep");
	if (my_level() >= 12) {
		return;
	}
	if (my_primestat() == $stat[muscle]) {
	set_choice("louvreDesiredGoal", 4, "Haunted Gallery: powerlevel time");
	}
	if (my_primestat() == $stat[mysticality]) {
	set_choice("louvreDesiredGoal", 5, "Haunted Gallery: powerlevel time");
	}
	if (my_primestat() == $stat[moxie]) {
	set_choice("louvreDesiredGoal", 6, "Haunted Gallery: powerlevel time");
	}
}

void powerlevel() {
	print("powerlevel");
	if (my_level() >= 12) {
			return;
	}
	cli_execute("maximize -combat");
	while (my_adventures() > 0)  {
		if (my_level() >= 12) {
			return;
		}
		if (my_basestat($stat[mysticality]) > 50 ) {
			if ( possessEquipment($item[Bram\'s choker]) ) {
			equip($item[Bram\'s choker]);
			} else {
			cli_execute("acquire Bram\'s choker");
			equip($item[Bram\'s choker]);
			}
		}
		cli_execute("trigger lose_effect, Category, chew 1 abstraction:category");
		cli_execute("trigger lose_effect, Perception, chew 1 abstraction:perception");
		cli_execute("trigger lose_effect, Purpose, chew 1 abstraction:purpose");
		cli_execute("trigger lose_effect, Trivia Master, use 1 Trivial Avocations Card: What?, 1 Trivial Avocations Card: When?, 1     Trivial Avocations Card: Who?, 1 Trivial Avocations Card: Where?");
		adventure(4, $location[The Haunted Gallery]);
	}
}
	


void castle() {
	print("castle");
	if (primestat == $stat[moxie]) {
		cli_execute("acquire deep six-shooter");
	}
	if (have_familiar($familiar[bowlet])) {
		cli_execute("familiar bowlet");
	} else {
	cli_execute("use bowlet; familiar bowlet");
	}
	cli_execute("mood clear");
	cli_execute("trigger lose_effect, Trivia Master, use 1 Trivial Avocations Card: What?, 1 Trivial Avocations Card: When?, 1     Trivial Avocations Card: Who?, 1 Trivial Avocations Card: Where?");	
	if (internalQuestStatus("questL10Garbage") > 20 ) {
		return;
	}
	if (internalQuestStatus("questL10Garbage") < 0 ) {
		print("Need to start castle");
		council();
	}

	if (internalQuestStatus("questL10Garbage") < 1 ) {
		cli_execute("use enchanted bean");
	} 
	cli_execute("maximize -combat");
	while (item_amount($item[S.O.C.K.]) < 1) {
			autoadv($location[The Penultimate Fantasy Airship]);
			cli_execute("refresh inv");
	}
	//basement
	cli_execute("acquire amulet of extreme plot significance; acquire titanium assault umbrella;");
	cli_execute("maximize -combat, +equip amulet of extreme plot significance, +equip titanium assault umbrella");
	while (internalQuestStatus("questL10Garbage") < 8) {
			autoadv($location[The Castle in the Clouds in the Sky (Basement)]);
			cli_execute("refresh quests");
	}
	//ground floor
	while (internalQuestStatus("questL10Garbage") < 9) {
			autoadv($location[The Castle in the Clouds in the Sky (Ground Floor)]);
			cli_execute("refresh quests");
	}
	//top floor
	cli_execute("acquire mohawk wig");
	cli_execute("maximize -combat, +equip mohawk wig");
	while (internalQuestStatus("questL10Garbage") < 10) {
			autoadv($location[The Castle in the Clouds in the Sky (Top Floor)]);
			cli_execute("refresh quests");
	}

}

void blackforest(){
	print("castle");
	council();
	if ( get_property("questL11Black").to_string() == "finished" ) {
		print("Finished black forest");
		return;
	}

	cli_execute("acquire blackberry galoshes");
	cli_execute("maximize item, +equip blackberry galoshes");
	while (internalQuestStatus("questL11Black") < 2) {
		if ( item_amount($item[beehive]) >= 1) {
		set_choice("choiceAdventure924", 1, "Have beehive");
		set_choice("choiceAdventure889", 3, "looking for blackberries");
		}
		autoadv($location[The Black Forest]);
		cli_execute("refresh quests");
	}
	cli_execute("acquire forged identification documents");
	cli_execute("acquire bitchin meatcar");
}

void vacation(){
	print("vacation");
	council();
	if ( item_amount($item[UV-resistant compass]) >= 1) {
		print("Have UV-resistant compass, considering this complete");
		return;
	}
	if ( get_property("lastIslandUnlock") == 0) {
		print("Island unlocked, considering this complete");
		return;
	}
	while (item_amount($item[Shore Inc. Ship Trip Scrip]) < 4) {
	autoadv($location[The Shore\, Inc. Travel Agency]);
	}
	cli_execute("make UV-Resistant Compass");
	cli_execute("make dinghy plans ");
	cli_execute("acquire Dingy planks");
	cli_execute("use dinghy plans");
}


void macguffin() {
	print("vacation");
	cli_execute("use your father\'s Macguffin Diary");
}

void lordspooky() {
	if (internalQuestStatus("questL11Manor") >= 3)  {
		return;
	}        
	if (internalQuestStatus("questL11MacGuffin") < 2)  {
		return;
	}     
	cli_execute("maximize -combat");
	while (internalQuestStatus("questL11Manor") < 1) {
			autoadv($location[The Haunted Ballroom]);
			cli_execute("refresh quests");
	}
	visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
	while (item_amount($item[Lord Spookyraven\'s spectacles]) < 1){
		set_choice("choiceAdventure878", 3, "");
		autoadv($location[The Haunted Bedroom]);
	}
	cli_execute("equip Lord Spookyraven\'s spectacles");
	use(1, $item[recipe: mortar-dissolving solution]);
	if ( get_property("spookyravenRecipeUsed").to_string() == "no_glasses" ) {
		abort("need reading glasses");
	}
							
	cli_execute("maximize item");

	if (item_amount($item[unstable fulminate]) < 1) {
		while (item_amount($item[bottle of Chateau de Vinegar]) < 1) {
			autoadv($location[The Haunted Wine Cellar]);
			cli_execute("refresh inv");
		}
		while (item_amount($item[blasting soda]) < 1) {
			autoadv($location[The Haunted Laundry Room]);
			cli_execute("refresh inv");
		}
	cli_execute("acquire unstable fulminate");
	}
	if (monster_level_adjustment() < 82) {
		cli_execute("chew 1 slimy alveolus");
		cli_execute("use 1 the most dangerous bait");
		cli_execute("use 1 mocking turtle");
	}
	cli_execute("equip unstable fulminate");
	while (item_amount($item[wine bomb]) < 1) {
			autoadv($location[The Haunted Boiler Room]);
			cli_execute("refresh inv");
	}
	visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
	cli_execute("uneffect slimebreath");
	cli_execute("uneffect Manbait");
}

void zeppelin(){
	print("zeppelin");
	if (internalQuestStatus("questL11MacGuffin") < 2)  {
		return;
	}    
	if (internalQuestStatus("questL11Ron") >= 2)  {
		return;
	}  
	if (my_basestat($stat[moxie]) < 70){
		return;
	}
	cli_execute("acquire lynyrdskin cap");
	cli_execute("acquire lynyrdskin breeches");
	cli_execute("use lynyrd musk");
	cli_execute("maximize item, +equip lynyrdskin cap, +equip lynyrdskin breeches");
	cli_execute("use 5 dis clover");
	set_choice("choiceAdventure856", 1, "Steampunk Complete Quest");
	set_choice("choiceAdventure866", 1, "Steampunk Complete Quest");
	adventure(7, $location[A Mob Of Zeppelin Protesters]);
}

void ron(){
	print("ron");
	if (internalQuestStatus("questL11Ron") >= 10)  {
		return;
	}  
	if (internalQuestStatus("questL11Ron") < 2)  {
		return;
	}  
	while (internalQuestStatus("questL11Ron") < 5) {
			autoadv($location[The Red Zeppelin]);
	}
}




void goblinking() {
	print("goblinking");
	if ( get_property("questL05Goblin").to_string() == "finished" ) {
    print("Finished Goblin King");
    return;
	}
	while ((item_amount($item[Knob Goblin encryption key]) < 1) && (internalQuestStatus("questL05Goblin") == 0) ) {
		autoadv($location[The Outskirts of Cobb\'s Knob]);
        cli_execute("refresh inv");
	}
	cli_execute("use Cobb's Knob map");
	cli_execute("acquire knob goblin harem veil");
	cli_execute("acquire knob goblin harem pants");
	cli_execute("use Knob Goblin perfume");
	autoadv($location[Throne Room]);

}

void crypt() {
	print("crypt");
	if ( get_property("questL07Cyrptic").to_string() == "finished" ) {
    print("Finished crypt");
    return;
	}
	while (get_property("cyrptAlcoveEvilness") > 0)  {
		autoadv($location[The Defiled Alcove]);
	}
	while (get_property("cyrptNicheEvilness") > 0)  {
		autoadv($location[The Defiled Niche ]);
	}
	while (get_property("cyrptNookEvilness") > 0)  {
		    if(item_amount($item[evil eye]) > 0)
			{
			use(1, $item[evil eye]);
    		}
		autoadv($location[The Defiled Nook]);
	}
	while (get_property("cyrptCrannyEvilness") > 0)  {
		autoadv($location[The Defiled Cranny]);
	}
	autoadv($location[Haert of the Cyrpt]);
	

}

void friars() {
	print("friars");
	if ( get_property("questL06Friar").to_string() == "finished" ) {
    print("Finished friars");
    return;
	}
	cli_execute("trigger lose_effect, Trivia Master, use 1 Trivial Avocations Card: What?, 1 Trivial Avocations Card: When?, 1     Trivial Avocations Card: Who?, 1 Trivial Avocations Card: Where?");
	cli_execute("mood execute");
	if ( possessEquipment($item[ring of conflict]) ) {
        equip($item[ring of conflict]);
    } else {
    cli_execute("acquire ring of conflict");
    equip($item[ring of conflict]);
    }
	while (item_amount($item[dodecagram]) < 1)  {
		autoadv($location[The Dark Neck of the Woods]);
        cli_execute("refresh inv");
	}
	while (item_amount($item[box of birthday candles]) < 1)  {
		autoadv($location[The Dark Heart of the Woods]);
        cli_execute("refresh inv");
	}

	while (item_amount($item[eldritch butterknife]) < 1)  {
		autoadv($location[The Dark Elbow of the Woods]);
        cli_execute("refresh inv");
	}
	visit_url("friars.php?action=ritual&pwd");
	council();
}

void chasm() {
	print("chasm");
	if ( get_property("chasmBridgeProgress") == 30 ) {
		print("Finished chasm");
		return;
		} else {
		cli_execute("acquire 6 snow boards");	
		visit_url("place.php?whichplace=orc_chasm");
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));

	}
}

void oilpeak() {
	print("oilpeak");
	if (get_property("oilPeakProgress")  == 0) {
		print("Finished oilpeak");
		return;
	}
	cli_execute("maximize item");
	if ( get_property("chasmBridgeProgress") == 30 ) {
		while (get_property("oilPeakProgress")  > 0) {
			cli_execute("trigger lose_effect, Slimebreath, chew 1 slimy alveolus");
			autoadv($location[Oil Peak]);
		}
		cli_execute("mood clear");
		cli_execute("uneffect Somewhat Poisoned");
		cli_execute("trigger lose_effect, Trivia Master, use 1 Trivial Avocations Card: What?, 1 Trivial Avocations Card: When?, 1     Trivial Avocations Card: Who?, 1 Trivial Avocations Card: Where?");
	}

}




void opencity(){
	print("opencity");
	if (internalQuestStatus("questL11MacGuffin") < 2)  {
		return;
	}    
	if (internalQuestStatus("questL11Worship") < 3) {
		cli_execute("acquire 2 stone wool");	
		cli_execute("acquire bloodied surgical dungarees; acquire surgical mask;acquire antique machete;");		
		cli_execute("acquire 5 bowling ball; ");	
		cli_execute("equip bloodied surgical dungarees; equip surgical mask; equip antique machete;");	
		if (internalQuestStatus("questM16Temple") <1 ) {
			abort("open the hidden city");
		}                    
		cli_execute("use stone wool");
		set_choice(582, 1, "");
		set_choice(579, 2, "");
		autoadv($location[The Hidden Temple]);
		cli_execute("use stone wool");
		set_choice(582, 2, "");
		set_choice(584, 4, "");
		autoadv($location[The Hidden Temple]);
	}

}

void hiddencity() {
	print("opencity");
	if (internalQuestStatus("questL11MacGuffin") < 2)  {
		return;
	}    
		if (internalQuestStatus("questL11Worship") < 3) {
	return;
	} 
	council();
	equip($item[antique machete]);
	if (get_property("hiddenTavernUnlock") == -1 ){
		cli_execute("use book of matches");
	}
	if ( possessEquipment($item[double-ice cap]) ) {
			equip($item[double-ice cap]);
	} else {
		cli_execute("acquire double-ice cap");
		equip($item[double-ice cap]);
	}
	while (internalQuestStatus("questL11Business") == -1) {
		autoadv($location[An Overgrown Shrine (Northeast)]);
	}
	while (internalQuestStatus("questL11Curses") == -1) {
		autoadv($location[An Overgrown Shrine (Northwest)]);
	}
	while (internalQuestStatus("questL11Doctor") == -1) {
		autoadv($location[An Overgrown Shrine (Southwest)]);
	}
	while (internalQuestStatus("questL11Spare") == -1) {
		autoadv($location[An Overgrown Shrine (Southeast)]);
	}
	if (internalQuestStatus("questL11Spare") == 0) {
		cli_execute("maximize mainstat, +equip double-ice cap, -equip pool cue");
		while (internalQuestStatus("questL11Spare") < 1) {
			autoadv($location[The Hidden Bowling Alley]);	
		}
	}

	if (internalQuestStatus("questL11Doctor") == 0) {
			cli_execute("maximize mainstat, +equip double-ice cap, +equip bloodied surgical dungarees, +equip surgical mask, -equip pool cue");
		while (internalQuestStatus("questL11Doctor") < 1) {
			autoadv($location[The Hidden Hospital]);	
		}
	}
	if (internalQuestStatus("questL11Curses") == 0) {
		if (my_inebriety() < 12){
			cli_execute("drink 3 cursed punch"); 
		} else {
			return;
		}
		cli_execute("maximize mainstat, +equip double-ice cap, -equip pool cue");
		while (internalQuestStatus("questL11Curses") < 1) {
			autoadv($location[The Hidden Apartment Building]);	
		}
	}
	if (internalQuestStatus("questL11Business") == 0) {
		while (internalQuestStatus("questL11Business") < 1) {
			cli_execute("maximize mainstat, +equip double-ice cap, -equip pool cue");
			autoadv($location[The Hidden Office Building]);	
		}
	}
}

void ultrahydrated() {
	print("ultrahydrated");
	if (internalQuestStatus("questL11MacGuffin") < 2)  {
	return;
	}    
	if ( get_property("desertExploration") == 100) {
		return;	
	}
	cli_execute("maximize mainstat, +equip double-ice cap, +equip UV-resistant compass, -equip pool cue");
	if ( get_property("desertExploration") == 0) {
		autoadv($location[The Arid, Extra-Dry Desert]);	
	}
	while(item_amount($item[Worm-riding manual page]) < 15){
		if(have_effect($effect[ultrahydrated]) > 0){
			autoadv($location[The Arid, Extra-Dry Desert]);
		}
		else {
			cli_execute("use 1 dis clover");
			autoadv($location[The Oasis]);
		}

	}
	cli_execute("acquire killing jar; acquire can of black paint;acquire drum machine;");
	set_choice(805, 3, "");
	visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
	visit_url("choice.php?whichchoice=805&option=1&pwd=");
	visit_url("choice.php?whichchoice=805&option=2&pwd=");
	visit_url("choice.php?whichchoice=805&option=2&pwd=");
	visit_url("choice.php?whichchoice=805&option=2&pwd=");
	visit_url("choice.php?whichchoice=805&option=1&pwd=");
	cli_execute("use 2 desert sightseeing pamphlet");
	cli_execute("use drum machine");
}

void UnlockTemple(){
	print("UnlockTemple");
	if ( get_property("questM16Temple").to_string() == "finished" ) {
		print("Finished temple");
		return;
	}
	while(item_amount($item[spooky sapling]) == 0){
		set_choice(502, 1, "");
		set_choice(503, 3, "");
		set_choice(504, 3, "");
		autoadv($location[The Spooky Forest]);	
	}
	while(item_amount($item[tree-holed coin]) == 0 ){
		print("getting tree coin","blue");
		set_property("choiceAdventure502","2");
		set_property("choiceAdventure505","2");
		autoadv($location[The Spooky Forest]);		
	}
	while(item_amount($item[Spooky Temple map]) == 0) {
		set_property("choiceAdventure502","3");
		set_property("choiceAdventure506","3");
		set_property("choiceAdventure507","1");
		print("getting temple map","blue");
		autoadv($location[The Spooky Forest]);
	}
	while(item_amount($item[Spooky-Gro fertilizer]) == 0){
			print("getting spooky gro fertilizer","blue");
			set_property("choiceAdventure502","3");
			set_property("choiceAdventure506","2");
			autoadv($location[The Spooky Forest]);
	}
	if ((available_amount($item[spooky sapling]) > 0) && (available_amount($item[Spooky-Gro fertilizer]) > 0) && (available_amount($item[Spooky Temple map]) > 0)){
			print("using map","blue");
			//set choiceadvs for normal adventuring
			set_property("choiceAdventure502","3");
			set_property("choiceAdventure506","1");
			set_property("choiceAdventure26","2");
			set_property("choiceAdventure28","2");
			use(1, $item[Spooky Temple map]);
	} else {
			abort();
	}
}

void trapper() {
	print("trapper");
	if (internalQuestStatus("questL08Trapper") > 5 ) {
		return;
	}
	if (internalQuestStatus("questL08Trapper") <= 0 ) {
		visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
	}
	if (internalQuestStatus("questL08Trapper") == 1 ) {
		cli_execute("acquire 3 "+ get_property("trapperOre").to_string());
		cli_execute("acquire 3 goat cheese");
		visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
	}
	if (internalQuestStatus("questL08Trapper") == 2 ) {
		cli_execute("myninja");
		visit_url("place.php?whichplace=mclargehuge&action=cloudypeak");
	}
	while (internalQuestStatus("questL08Trapper") < 5) {
			autoadv($location[Mist-Shrouded Peak]);	
	}
	visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
}

void shen() {
	print("shen");
	if (internalQuestStatus("questL11MacGuffin") < 2)  {
		return;
	}    
	if (internalQuestStatus("questL11Shen") > 7 ) {
		return;
	}
	set_property("choiceAdventure1074", 1);
	if (internalQuestStatus("questL11Shen") == 0 ) {
		autoadv($location[The Copperhead Club]);	
	}
	while (internalQuestStatus("questL11Shen") < 7 ) {
		item it = to_item(get_property("shenQuestItem"));
			location goal = $location[none];
			switch(it)
			{
			case $item[The Stankara Stone]:					goal = $location[The Batrat and Ratbat Burrow];						break;
			case $item[The First Pizza]:					goal = $location[Lair of the Ninja Snowmen];						break;
			case $item[Murphy\'s Rancid Black Flag]:		goal = $location[The Castle in the Clouds in the Sky (Top Floor)];	break;
			case $item[The Eye of the Stars]:				goal = $location[The Hole in the Sky];								break;
			case $item[The Lacrosse Stick of Lacoronado]:	goal = $location[The Smut Orc Logging Camp];						break;
			case $item[The Shield of Brook]:				goal = $location[The VERY Unquiet Garves];							break;
			}

		while(item_amount(it) == 0){
			autoadv(goal);	
		}
		adventure(6, $location[The Copperhead Club]);
		if (it == to_item(get_property("shenQuestItem")) ) {
			abort();
		}
	}
}

void palindrome(){
	print("palindrome");
	if (!possessEquipment($item[Talisman o' Namsilat])){
		return;
	}
	print("palindrome2");
	if (item_amount($item[Photograph Of God]) < 1) {
		cli_execute("acquire disposable instant camera");
	}
	if (internalQuestStatus("questL11Palindome") < 1) {
		cli_execute("maximize -combat, +equip Talisman o' Namsilat");
		int total = 0;
		total = item_amount($item[Photograph Of An Ostrich Egg]) + item_amount($item[Photograph Of A Red Nugget]) + item_amount($item[Photograph Of God]) + item_amount($item[Photograph Of A Dog]) ;
		while (total < 4)  { 
			autoadv($location[Inside the Palindome]);
			total = item_amount($item[Photograph Of An Ostrich Egg]) + item_amount($item[Photograph Of A Red Nugget]) + item_amount($item[Photograph Of God]) + item_amount($item[Photograph Of A Dog]) ;
		}

			cli_execute("use i love me");
		equip($slot[acc3], $item[Talisman o\' Namsilat]);
		visit_url("place.php?whichplace=palindome&action=pal_drlabel");
		visit_url("choice.php?pwd&whichchoice=872&option=1&photo1=2259&photo2=7264&photo3=7263&photo4=7265");
	}
	if (internalQuestStatus("questL11Palindome") == 1) {
		cli_execute("use 2 Love Me");
	}

	if (internalQuestStatus("questL11Palindome") == 2) {
		visit_url("place.php?whichplace=palindome&action=pal_mrlabel");
		cli_execute("acquire wet stunt nut stew");
		visit_url("place.php?whichplace=palindome&action=pal_mrlabel");
	}
	if (internalQuestStatus("questL11Palindome") == 5) {
		cli_execute("use tiny house");
		cli_execute("maximize mainstat, +equip Talisman o' Namsilat, +equip Mega Gem, -equip pool cue");
		set_property("choiceAdventure131", 3);
		visit_url("place.php?whichplace=palindome&action=pal_drlabel");
	}
}
	
	


void pyramid(){
	print("pyramid");
	if (internalQuestStatus("questL11Pyramid") < 0 ) {
	return;
	}
	cli_execute("maximize -combat");
	while (internalQuestStatus("questL11Pyramid") < 1 ) {
		autoadv($location[The Upper Chamber]);
	}
	while (internalQuestStatus("questL11Pyramid") < 1 ) {
		autoadv($location[The Upper Chamber]);
	}

	while (internalQuestStatus("questL11Pyramid") < 3 ) {
		autoadv($location[The Middle Chamber]);
	}
	if (get_property("pyramidBombUsed") == false) {
		int wheel = 10 - item_amount($item[Crumbling Wooden Wheel]);
		cli_execute("acquire "+ wheel + " tomb ratchet");
		int total = item_amount($item[Crumbling Wooden Wheel]) + item_amount($item[Tomb Ratchet]);
		if((total >= 10) && (my_adventures() >= 4) && get_property("controlRoomUnlock").to_boolean()) {
			visit_url("place.php?whichplace=pyramid&action=pyramid_control");
			int x = 0;
			while(x < 10)
			{
				if(item_amount($item[crumbling wooden wheel]) > 0)
				{
					visit_url("choice.php?pwd&whichchoice=929&option=1&choiceform1=Use+a+wheel+on+the+peg&pwd="+my_hash());
				}
				else
				{
					visit_url("choice.php?whichchoice=929&option=2&pwd");
				}
				x = x + 1;
				if((x == 3) || (x == 7) || (x == 10))
				{
					visit_url("choice.php?pwd&whichchoice=929&option=5&choiceform5=Head+down+to+the+Lower+Chambers+%281%29&pwd="+my_hash());
				}
				if((x == 3) || (x == 7))
				{
					visit_url("place.php?whichplace=pyramid&action=pyramid_control");
				}
			}
		}	
	}
	autoadv($location[The Lower Chambers]);
}

void twinpeak() {
	print("twinpeak");
	if (get_property("twinPeakProgress") == 0) {
		set_property("choiceAdventure604", "1");	//welcome NC to twin peak step 1 = "continue"
		set_property("choiceAdventure605", "1");	//welcome NC to twin peak step 2 = "everything goes black"
		set_property("choiceAdventure607", "1");	//finish stench / room 237
		set_property("choiceAdventure608", "1");	//finish food drop / pantry
		set_property("choiceAdventure609", "1");	//do jar of oil / sound of music... goto 616
		set_property("choiceAdventure616", "1");	//finish jar of oil / sound of music
		set_property("choiceAdventure610", "1");	//do init / "who's that" / "to catch a killer"... goto 1056
		set_property("choiceAdventure1056", "1");	//finish init / "now it's dark"
		set_property("choiceAdventure618", "2");	//burn this hotel pity NC to skip the zone if you spent over 50 adventures there.
		cli_execute("acquire 4 rusty hedge trimmer");
	}

	if (get_property("twinPeakProgress") == 0) {
		cli_execute("maximize stench res");
		set_property("choiceAdventure606", "1");
		cli_execute("use rusty hedge trimmer");
	}

	if (get_property("twinPeakProgress") == 1) {
		cli_execute("maximize item");
		cli_execute("chew knob goblin eyedrops");
		cli_execute("use 1 resolution:be happier");
		set_property("choiceAdventure606", "2");
		cli_execute("use rusty hedge trimmer");
	}
	if (get_property("twinPeakProgress") == 3) {
		cli_execute("acquire jar of oil");
		set_property("choiceAdventure606", "3");
		cli_execute("use rusty hedge trimmer");
	}
	if (get_property("twinPeakProgress") == 7) {
		cli_execute("maximize init");
		set_property("choiceAdventure606", "4");
		cli_execute("use rusty hedge trimmer");
	}
	if (internalQuestStatus("questL09Topping") == 3)  {
		visit_url("place.php?whichplace=highlands&action=highlands_dude");
		council();	
	}

}

void aboo(){
	print("aboo");
	if (get_property("booPeakLit")  == true )  {
		print("Finished boopeak");
		return;
	}
	if ( get_property("chasmBridgeProgress") == 30 ) {
		while ((item_amount($item[A-Boo clue]) == 0 ) && (get_property("booPeakProgress") == 100) ){
			cli_execute("use 3 dis clover");
			adventure(3, $location[A-Boo Peak]);
		}
		set_choice(611, 1, "");
		cli_execute("maximize spooky res, cold res"); 
		cli_execute("trigger lose_effect, Spiro Gyro , use 1 programmable turtle");
		cli_execute("trigger lose_effect, Oiled-Up, use 1 pec oil");

		while (get_property("booPeakProgress")  > 0) {
			cli_execute("use a boo clue"); 
			autoadv($location[A-Boo Peak]);
			
		}
		if ((get_property("booPeakLit")  == false ) && (get_property("booPeakProgress")  == 0) ){
			autoadv($location[A-Boo Peak]);
			cli_execute("mood clear");
			cli_execute("trigger lose_effect, Trivia Master, use 1 Trivial Avocations Card: What?, 1 Trivial Avocations Card: When?, 1     Trivial Avocations Card: Who?, 1 Trivial Avocations Card: Where?");
		
		}                        
		
	}

}

void spectre() {
	print("spectre");
	if (internalQuestStatus("questL11Worship") > 4 ) {
		return;
	}
	if (get_property("hiddenOfficeProgress") == 7 ) {
		autoadv($location[An Overgrown Shrine (Northeast)]);
	}
	if (get_property("hiddenApartmentProgress") == 7 ) {
		autoadv($location[An Overgrown Shrine (Northwest)]);
	}
	if (get_property("hiddenBowlingAlleyProgress") == 7 ) {
		autoadv($location[An Overgrown Shrine (Southeast)]);
	}
	if (get_property("hiddenHospitalProgress") == 7 ) {
		autoadv($location[An Overgrown Shrine (Southwest)]);
	}
	
	while (internalQuestStatus("questL11Worship") == 4 ) {
		cli_execute("maximize mainstat, +equip antique machete, +equip double-ice cap, -equip pool cue");
		autoadv($location[A Massive Ziggurat]);
	}
}

void killspooks() {
	print("killspooks");
	if (internalQuestStatus("questL11Manor") == 3 ) {
		autoadv($location[Summoning Chamber]);
	} else {
		return;
	}
}

void getstaff() {
	print("getstaff");
	if (internalQuestStatus("questL11Manor") > 3 ||  internalQuestStatus("questL11Palindome") > 5 || internalQuestStatus("questL11Worship") > 4  ) {
		if (internalQuestStatus("questL11Pyramid") < 0 ) {
			if ((item_amount($item[headpiece of the Staff of Ed]) == 0) && (item_amount($item[[2325]Staff Of Ed]) == 0) ) {
				cli_execute("make headpiece of the Staff of Ed");
			}
			if (item_amount($item[[2325]Staff Of Ed]) == 0) {
				cli_execute("make [2325]Staff Of Ed");
			}
			if (item_amount($item[[2325]Staff Of Ed]) == 1) {
				visit_url("place.php?whichplace=desertbeach&action=db_pyramid1");
			}
		}
	}
}

void bossbat() {
	print("bossbat");
	if (internalQuestStatus("questL04Bat") > 4 ) {
		return;
	}
	while (internalQuestStatus("questL04Bat") < 3 ) {
	cli_execute("use sonar in a");
	}
	while (internalQuestStatus("questL04Bat") == 3 ) {
		autoadv($location[The Boss Bat's Lair]);
	}
}

void war() {
	print("war");
	if ( get_property("questL12War").to_string() == "finished" ) {
		print("Finished War");
		return;
	}
	if (internalQuestStatus("questL12War") <= 0 ) {
		print("Need to start war");
		council();
	}
	cli_execute("getfrat");
	print("Need to start war");
	cli_execute("maximize -combat, +outfit frat warrior fatigues");
	while (internalQuestStatus("questL12War") == 0 ) {
		autoadv($location[Hippy Camp]);
	}
}

void sorceress() {
	print("sorceress");
	if (internalQuestStatus("questL13Final") < 0) {
		return;
	}
	cli_execute("acquire richards star key; acquire digital key; acquire  jarlsberg's key; acquire boris's key; acquire sneaky pete's key; acquire skeleton key;");
	visit_url("place.php?whichplace=nstower&action=ns_01_contestbooth");
}

void main() {
	set_choice_adventures();
	prep();
	galactic();
	larva();
	painter();
	rats();
	lvltosix();
	spookyraven();
	digikey();
	dailyDung ();
	friars();
	spooky2 ();
	goblinking();
	powerlevelprep();
	powerlevel();
	castle();
	crypt();
	chasm();
	bossbat();
	blackforest();
	vacation();
	macguffin();
	lordspooky();
	UnlockTemple();
	zeppelin();
	ron();
	oilpeak();
	opencity();
	hiddencity();
	ultrahydrated();
	trapper();
	shen();
	spectre();
	killspooks();
	palindrome();
	getstaff();
	pyramid();
	aboo();
	twinpeak();
	war();
	sorceress();
}

