script "missingManuel.ash";

since r19861;

string thisver = "1.38";

//CheckVersion by Bale.
string CheckVersion() {
	string soft = "missingManuel";
	string prop = "_version_MissingManuel";
	int thread = 11428;
	int w; string page;
	boolean sameornewer(string local, string server) {
		if (local == server) return true;
		string[int] loc = split_string(local,"\\.");
		string[int] ser = split_string(server,"\\.");
		for i from 0 to max(count(loc)-1,count(ser)-1) {
			if (i+1 > count(loc)) return false;
			if (i+1 > count(ser)) return true;
			if (loc[i].to_int() < ser[i].to_int()) return false;
			if (loc[i].to_int() > ser[i].to_int()) return true;
		}
		return local == server;
	}
	switch(get_property(prop)) {
	case thisver: return "";
	case "":
		print("Checking for updates (running "+soft+" ver. "+thisver+")...");
		page = visit_url("https://kolmafia.us/showthread.php?t="+thread);
		matcher find_ver = create_matcher("<b>"+soft+" (.+?)</b>",page);
		if (!find_ver.find()) {
			print("Unable to load current version info.", "red");
			set_property(prop,thisver);
			return "";
		}
		w=19;
		set_property(prop,find_ver.group(1));
		default:
		if(sameornewer(thisver,get_property(prop))) {
			set_property(prop,thisver);
			print("You have a current version of "+soft+".");
			return "";
		}
		string msg = "<big><font color=red><b>New Version of "+soft+" Available: "+get_property(prop)+"</b></font></big>"+
		"<br><a href='https://kolmafia.us/showthread.php?t="+thread+"' target='_blank'><u>Upgrade from "+thisver+" to "+get_property(prop)+" here!</u></a><br>"+
		"<small>Think you are getting this message in error?  Force a re-check by typing \"set "+prop+" =\" in the CLI.</small><br>";
		find_ver = create_matcher("\\[requires revision (.+?)\\]",page);
		if (find_ver.find() && find_ver.group(1).to_int() > get_revision())
		msg += " (Note: you will also need to <a href='https://builds.kolmafia.us/' target='_blank'>update mafia to r"+find_ver.group(1)+" or higher</a> to use this update.)";
		print_html(msg);
		if(w > 0) wait(w);
		return "<div class='versioninfo'>"+msg+"</div>";
	}
	return "";
}

static boolean [monster] blocked_monsters = $monsters[ none ];

static boolean [string][monster] extra_monsters;
static {
    extra_monsters["The Middle Chamber"] = $monsters[tomb rat king];
    extra_monsters["Hobopolis Town Square"] = $monsters[gang of hobo muggers];
    extra_monsters["The Typical Tavern Cellar"] = $monsters[bunch of drunken rats,drunken rat king];
    extra_monsters["The Red Queen's Garden"] = $monsters[croqueteer];
    extra_monsters["The Outer Compound"] = $monsters[french guard turtle];
    extra_monsters["Fudge Mountain"] = $monsters[swarm of fudgewasps];
    extra_monsters["Vanya's Castle Foyer"] = $monsters[Vanya's Creature];
    extra_monsters["The Brinier Deepers"] = $monsters[trophyfish];
    extra_monsters["Itznotyerzitz Mine"] = $monsters[mountain man];
    extra_monsters["The Jungles of Ancient Loathing"] = $monsters[group of cultists,ancient temple guardian];
    extra_monsters["The Haunted Bedroom"] = $monsters[animated nightstand (mahogany combat),animated nightstand (mahogany noncombat),animated nightstand (white combat),animated nightstand (white noncombat)];
    extra_monsters["El Vibrato Island"] = $monsters[bizarre construct (translated),hulking construct (translated),industrious construct (translated),lonely construct (translated),menacing construct (translated),towering construct (translated)];
    extra_monsters["1st Floor, Shiawase-Mitsuhama Building"] = $monsters[Chief Electronic Overseer];
    extra_monsters["Mer-kin Elementary School"] = $monsters[Mer-kin specter];
    extra_monsters["The Landscaper's Lair"] = $monsters[The Landscaper];
    extra_monsters["A Mob of Zeppelin Protesters"] = $monsters[lynyrd];
}

boolean [monster] jerry_bradford()
{
    boolean [monster] jerry;

    // Pokefam has 10 versions of Jerry Bradford. 9 of them have the
    // same name.  There is no way to specify a monster by ID in ASH,
    // but to_monster will get it for you
    for i from 2050 to 2059 {
	jerry[ to_monster( i ) ] = true;
    }

    return jerry;
}

boolean [monster] plumber_monsters()
{
    boolean [monster] monsters;

    // There are two monsters named Bowser in Path of the Plumber. There
    // is no way to specify a monster by ID in ASH, but to_monster will
    // get it for you

    for i from 2165 to 2174 {
	monsters[ to_monster( i ) ] = true;
    }

    return monsters;
}

static boolean [string][monster] extra_areas;
static {
    extra_areas["Mist-Covered Icy Peak"] = $monsters[Groar, panicking Knott Yeti];
    extra_areas["Bees Hate You"] = $monsters[Bee Swarm, Bee Thoven, Beebee Gunners, Beebee King, Beebee Queue, Buzzerker, Moneybee, Mumblebee, Queen Bee];
    extra_areas["Surprising Fist"] = $monsters[Wu Tang the Betrayer];
    extra_areas["Avatar of Boris"] = $monsters[The Avatar of Sneaky Pete, The Luter];
    extra_areas["Bugbear Invasion"] = $monsters[Ancient Unspeakable Bugbear, Anesthesiologist Bugbear, Angry Cavebugbear, Batbugbear, Battlesuit Bugbear Type, Black Ops Bugbear, Bugaboo, Bugbear Captain, Bugbear Drone, Bugbear Mortician, Bugbear Robo-Surgeon, Bugbear Scientist, Creepy Eye-Stalk Tentacle Monster, Grouchy Furry Monster, Hypodermic Bugbear, Liquid Metal Bugbear, N-space Virtual Assistant, Scavenger Bugbear, Spiderbugbear, Trendy Bugbear Chef];
    extra_areas["Zombie Slayer"] = $monsters[Angry Space Marine, Charity the Zombie Hunter, Deputy Nick Soames & Earl, Father McGruber, Father Nikolai Ravonovich, Hank North\, Photojournalist, Herman East\, Relivinator, Norville Rogers, Peacannon, Rag-tag band of survivors, Scott the Miner, Special Agent Wallace Burke Corrigan, The Free Man, Wesley J. "Wes" Campbell, Zombie-huntin' feller, Rene C. Corman];
    extra_areas["Avatar of Jarlsberg"] = $monsters[Clancy, The Avatar of Boris];
    extra_areas["Avatar of Sneaky Pete"] = $monsters[The Avatar of Jarlsberg];
    extra_areas["Naughty Sorceress' Tower"] = $monsters[Beer Batter, Best-Selling Novelist, Big Meat Golem, Bowling Cricket, Bronze Chef, Collapsed Mineshaft Golem, Concert Pianist, El Diablo, Electron Submarine, Endangered Inflatable White Tiger, Enraged Cow, Fancy Bath Slug, Flaming Samurai, Giant Bee, Giant Desktop Globe, Giant Fried Egg, Ice Cube, Malevolent Crop Circle, Possessed Pipe-Organ, Pretty Fly, Darkness, Fickle Finger of F8, Naughty Sorceress, Naughty Sorceress (2), Naughty Sorceress (3), Tyrannosaurus Tex, Vicious Easel, Your Shadow];
    extra_areas["Mini-Hipster"] = $monsters[angry bassist, blue-haired girl, evil ex-girlfriend, peeved roommate, random scenester];
    extra_areas["Black Crayon"] = $monsters[Black Crayon Beast, Black Crayon Beetle, Black Crayon Constellation, Black Crayon Crimbo Elf, Black Crayon Demon, Black Crayon Elemental, Black Crayon Fish, Black Crayon Flower, Black Crayon Frat Orc, Black Crayon Goblin, Black Crayon Golem, Black Crayon Hippy, Black Crayon Hobo, Black Crayon Man, Black Crayon Manloid, Black Crayon Mer-kin, Black Crayon Penguin, Black Crayon Pirate, Black Crayon Shambling Monstrosity, Black Crayon Slime, Black Crayon Spiraling Shape, Black Crayon Undead Thing];
    extra_areas["BRICKO"] = $monsters[BRICKO airship, BRICKO bat, BRICKO cathedral, BRICKO elephant, BRICKO gargantuchicken, BRICKO octopus, BRICKO ooze, BRICKO oyster, BRICKO python, BRICKO turtle, BRICKO vacuum cleaner];
    extra_areas["Infernal Seals"] = $monsters[broodling seal, Centurion of Sparky, heat seal, hermetic seal, navy seal, Servant of Grodstank, shadow of Black Bubbles, Spawn of Wally, watertight seal, wet seal];
    extra_areas["Nemesis Assassins"] = $monsters[Argarggagarg the Dire Hellseal, B&eacute;arnaise zombie, Evil Spaghetti Cult Assassin, Flock of seagulls, Heimandatz\, Nacho Golem, Hunting Seal, Jocko Homo, Mariachi Bandolero, Menacing Thug, Mob Penguin hitman, Safari Jack\, Small-Game Hunter, The Mariachi With No Name, Turtle trapper, Yakisoba the Executioner];
    extra_areas["Nemeses"] = $monsters[Gorgolok\, the Demonic Hellseal, Gorgolok\, the Infernal Seal (The Nemesis' Lair), Gorgolok\, the Infernal Seal (Volcanic Cave), Lumpy\, the Demonic Sauceblob, Lumpy\, the Sinister Sauceblob (The Nemesis' Lair), Lumpy\, the Sinister Sauceblob (Volcanic Cave), Somerset Lopez\, Demon Mariachi, Somerset Lopez\, Dread Mariachi (The Nemesis' Lair), Somerset Lopez\, Dread Mariachi (Volcanic Cave), Stella\, the Demonic Turtle Poacher, Stella\, the Turtle Poacher (The Nemesis' Lair), Stella\, the Turtle Poacher (Volcanic Cave), Demon of New Wave, Spaghetti Demon, Spaghetti Elemental (Inner Sanctum), Spaghetti Elemental (The Nemesis' Lair), Spaghetti Elemental (Volcanic Cave), Spirit of New Wave (The Nemesis' Lair), Spirit of New Wave (Volcanic Cave)];
    extra_areas["Feast of Boris"] = $monsters[Candied Yam Golem, Malevolent Tofurkey, Possessed Can of Cranberry Sauce, Stuffing Golem];
    extra_areas["El Dia de los Muertos Borrachos"] = $monsters[Novio Cad&aacute;ver, Padre Cad&aacute;ver, Novia Cad&aacute;ver, Persona Inocente Cad&aacute;ver];
    extra_areas["Talk like a pirate day"] = $monsters[Ambulatory Pirate, Migratory Pirate, Peripatetic Pirate];
    extra_areas["Bigg's Dig"] = $monsters[reanimated baboon skeleton, reanimated bat skeleton, reanimated demon skeleton, reanimated giant spider skeleton, reanimated serpent skeleton, reanimated wyrm skeleton];
    extra_areas["Rock Event"] = $monsters[clod hopper, rock homunculus, rock snake, rockfish];
    extra_areas["Jacking's Lab"] = $monsters[Professor Jacking];
    extra_areas["The Lower Chamber"] = $monsters[Ed the Undying, Ed the Undying (1), Ed the Undying (2), Ed the Undying (3), Ed the Undying (4), Ed the Undying (5), Ed the Undying (6), Ed the Undying (7)];
    extra_areas["Altar"] = $monsters[The Thing with No Name];
    extra_areas["CLEESH"] = $monsters[Frog, Newt, Salamander];
    extra_areas["Summoning Chamber"] = $monsters[Lord Spookyraven];
    extra_areas["Grey Goo"] = $monsters[enormous blob of gray goo, largish blob of gray goo, little blob of gray goo];
    extra_areas["Taco Elves"] = $monsters[sign-twirling Crimbo elf, taco-clad Crimbo elf, tacobuilding elf];
    extra_areas["Crimbokutown Toy Factory"] = $monsters[Circuit-Soldering Animelf, Plastic-Extruding Animelf, Quality Control Animelf, Tiny-Screwing Animelf, Toy Assembling Animelf];
    extra_areas["The Gourd"] = $monsters[canned goblin conspirator, Fnord the Unspeakable, goblin conspirator, spider conspirator, spider-goblin conspirator, tin can conspirator, tin spider conspirator];
    extra_areas["Mer-kin Temple"] = $monsters[Dad Sea Monkee, Shub-Jigguwatt\, Elder God of Violence, Yog-Urt\, Elder Goddess of Hatred];
    extra_areas["Wandering Accordionists"] = $monsters[depressing French accordionist, lively Cajun accordionist, quirky indie-rock accordionist];
    extra_areas["KOLHS"] = $monsters[Principal Mooney];
    extra_areas["Food Monstrosities"] = $monsters[Box of Crafty Dinner, Frozen Bag of Tortellini, Possessed Can of Creepy Pasta, Possessed Can of Linguine-Os, Possessed Jar of Alphredo&trade;];
    extra_areas["Heavy Rains"] = $monsters[alley catfish, Aquabat, aquaconda, Aquagoblin, Auqadargon, Big Wisnaqua, Dr. Aquard, freshwater bonefish, giant isopod, giant tardigrade, gourmet gourami, Gurgle, Lord Soggyraven, piranhadon, Protector Spurt, storm cow, The Aquaman, The Rain King];
    extra_areas["Actually Ed the Undying"] = $monsters[Boss Bat?, Donerbagon, hulking bridge troll, new Knob Goblin King, You the Adventurer, Your winged yeti];
    extra_areas["Transmissions from Planet Xi"] = $monsters[holographic army, They, Xiblaxian political prisoner];
    extra_areas["Misc. Spelunking"] = $monsters[shopkeeper, ghost (Spelunky)];
    extra_areas["The Unknown Tomb"] = $monsters[The Unknown Accordion Thief, The Unknown Disco Bandit, The Unknown Pastamancer, The Unknown Sauceror, The Unknown Seal Clubber, The Unknown Turtle Tamer];
    extra_areas["Deck of Every Card"] = $monsters[legal alien, The Emperor];
    extra_areas["Halloween XX"] = $monsters[mutant gila monster,mutant rattlesnake,mutant saguaro,swarm of mutant fire ants];
    extra_areas["The Burning Inferno Discotheque"] = $monsters[Travoltron];
    extra_areas["Brushfires"] = $monsters[blazing bat,snakefire in the grass,Servant of Lord Flameface];
    extra_areas["Obsolete Monsters"] = $monsters[Gnollish Sorceress,giant pair of tweezers,Knob Goblin Elite Guardsman,topiary golem,eXtreme Sports Orcs,angry raccoon puppet,Astronomer (obsolete),Black Knight,ancient protector spirit (obsolete),possessed wine rack (obsolete),skeletal sommelier (obsolete),evil spaghetti cult priest,evil spaghetti cultist,evil trumpet-playing mariachi,evil vihuela-playing mariachi,haunted soup tureen,infernal seal larva,infernal seal spawn,pernicious puddle of pesto,psychedelic fur,slithering hollandaise glob,talking head,vengeful turtle spectre];
    extra_areas["Avatar of West of Loathing"] = $monsters[furious cow, furious giant cow, ungulith, emaciated rodeo clown, menacing rodeo clown, grizzled rodeo clown, aggressive grass snake, prince snake, king snake];
    extra_areas["The Source"] = $monsters[Source Agent, One Thousand Source Agents];
    extra_areas["Pocket Familiars"] = jerry_bradford();
    extra_areas["Path of the Plumber"] = plumber_monsters();
}

boolean [monster] get_all_monsters()
{
    boolean [monster] all_monsters = all_monsters_with_id();

    // Remove monsters known not to be in manuel
    foreach m in all_monsters {
	if ( m.attributes.index_of( "NOMANUEL" ) != -1 ||
	     blocked_monsters contains m ) {
	    remove all_monsters[ m ];
	}
    }

    return all_monsters;
}

void visit_page( string page )
{
    print( page );
    visit_url( "questlog.php?which=6&vl=" + page.to_lower_case() );
}

void visit_all()
{
    flush_monster_manuel_cache();
    visit_page("A");
    visit_page("B");
    visit_page("C");
    visit_page("D");
    visit_page("E");
    visit_page("F");
    visit_page("G");
    visit_page("H");
    visit_page("I");
    visit_page("J");
    visit_page("K");
    visit_page("L");
    visit_page("M");
    visit_page("N");
    visit_page("O");
    visit_page("P");
    visit_page("Q");
    visit_page("R");
    visit_page("S");
    visit_page("T");
    visit_page("U");
    visit_page("V");
    visit_page("W");
    visit_page("X");
    visit_page("Y");
    visit_page("Z");
    print("Now I know my ABCs!");
    visit_page("-");
}

int three, two, one, zero;

string GetLocName(string locName)
{
    if (locName == "Foyer") return "Vanya's Castle";
    if (locName == "A Well-Groomed Lawn") return "Landscaper's Map";
    if (locName == "Post-War Junkyard") return "Junkyard";
    if (locName == "1st Floor, Shiawase-Mitsuhama Building") return "Shiawase-Mitsuhama Building";
    return locName;
}

boolean print_all = false;

boolean process_monster ( monster m, string loc, boolean print_header )
{
    int missed = 3 - monster_factoids_available( m, true );

    if (missed == 0) {
	three += 1;
	if ( !print_all ) {
	    return print_header;
	}
    }

    if (missed == 1)
	two += 1;
    else if (missed == 2)
	one += 1;
    else if (missed == 3)
	zero += 1;

    if ( print_header ) {
	print("[" + GetLocName(loc) + "]");
    }

    if (missed > 2) {
	print( m.name + " {" + missed + "}", "red" );
    }
    else {
	print( m.name + " {" + missed + "}" );
    }

    return false;
}

void process_area( string area, boolean[monster] mon_list, boolean[monster] all_monsters )
{
    boolean print_header = true;
    foreach m in mon_list {
	if ( m.id > 0 && all_monsters contains m ) {
	    print_header = process_monster( m, area, print_header );
	    remove all_monsters[ m ];
	}
    }
    if ( !print_header ) {
	print("=================================");
    }
}

void process_wanderers( boolean[monster] all_monsters )
{
    boolean print_header = true;
    foreach m in all_monsters {
	if ( m.id > 0 && m.attributes.contains_text("WANDERER" ) ) {
	    print_header = process_monster( m, "Other Wandering Monsters", print_header );
	    remove all_monsters[ m ];
	}
    }
    if ( !print_header ) {
	print("=================================");
    }
}

void CheckManuel()
{
    CheckVersion();
    
    print("Checking Monster Manuel...", "blue");
    visit_all();
    print("Done checking Monster Manuel!", "blue");

    boolean [monster] all_monsters = get_all_monsters();

    print("=================================");
    location myloc = my_location();
    // Process monsters in known areas
	string area = myloc.to_string();
	process_area( area, get_location_monsters(myloc), all_monsters );
	if ( extra_monsters contains area ) {
	    process_area( area, extra_monsters[ area ], all_monsters );
	}
    

    print("");
    print("You have casually researched " + one + " creatures.");
    print("You have thoroughly researched " + two + " creatures.");
    print("You have exhaustively researched " + three + " creatures.");
    print("You have not researched " + zero + " creatures.");
    print("Total creatures: " + (one + two + three + zero) + ".");
    print("Done.", "blue");
}

// Many thanks to Veracity for pretty much rewriting this script (and adding some stuff to KolMafia to make it work better).
void main()
{
    if ( !visit_url("questlog.php?which=6").contains_text( "[Monster Manuel]" )) {
	print("Thank you, Mario, but your Monster Manuel is in another castle!", "blue");
	print("Perhaps you should consider getting one?");
	print("");
	print("=================================");
	print("[Every Single Area]");
	print("NOTHING!  ABSOLUTELY NOTHING!", "red");
	print("=================================");
	print("");
	print("You have casually researched 0 creatures.");
	print("You have thoroughly researched 0 creatures.");
	print("You have exhaustively researched 0 creatures.");
	print("You have not researched ANY creatures.");
	print("Done.", "blue");
	return;
    }
    CheckManuel();
}
