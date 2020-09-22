since r19001;
//*******************************************************************************************
//*******************************************************************************************
// Initiation
//*******************************************************************************************
//*******************************************************************************************

import <vprops.ash>;
import <vcon.ash>
import <Garden Harvester.ash>;
import <DicsLibrary.ash>;
import <autoscend.ash>;
import <aen_utils.ash>;

//*******************************************************************************************
//Static Variables



static item NO_ITEM = $item[ none ];



item dearest( item_set items )
{
    // Bulk cache mall prices
    mall_prices( items );

    item best = NO_ITEM;
    int current_best_price = 0;

    foreach candidate in items {
	int price = mall_price( candidate );
	if ( price > current_best_price ) {
	    current_best_price = price;
	    best = candidate;
	}
    }

    return best;
}
static item_set CLIP_ART_ITEMS = $items[
     Ur-Donut,
     The Bomb,
     box of Familiar Jacks,
     bucket of wine,
     ultrafondue,
     oversized snowflake,
     unbearable light,
     crystal skull,
     borrowed time,
     box of hammers,
     shining halo,
     furry halo,
     frosty halo,
     time halo,
     Lumineux Limnio,
     Morto Moreto,
     Temps Tempranillo,
     Bordeaux Marteaux,
     Fromage Pinotage,
     Beignet Milgranet,
     Muschat,
     cool jelly donut,
     shrapnel jelly donut,
     occult jelly donut,
     thyme jelly donut,
     frozen danish,
     smashed danish,
     forbidden danish,
     cool cat claw,
     blunt cat claw,
     shadowy cat claw,
     cheezburger,
     toasted brie,
     potion of the field gar,
     too legit potion,
     Bright Water,
     cold-filtered water,
     graveyard snowglobe,
     cool cat elixir,
     potion of the captain's hammer,
     potion of X-ray vision,
     potion of the litterbox,
     potion of animal rage,
     potion of punctual companionship,
     holy bomb\, batman,
     bobcat grenade,
     chocolate frosted sugar bomb,
     broken glass grenade,
     noxious gas grenade,
     skull with a fuse in it,
     boozebomb,
     4:20 bomb,
     blunt icepick,
     fluorescent lightbulb,
     blammer,
     clock-cleaning hammer,
     hammerus,
     broken clock,
     dethklok,
     glacial clock
];

static item_set STILL_ITEMS = $items[
     bottle of Calcutta Emerald,
     bottle of Lieutenant Freeman,
     bottle of Jorge Sinsonte,
     bottle of Definit,
     bottle of Domesticated Turkey,
     boxed champagne,
     bottle of Ooze-O,
     bottle of Pete's Sake,
     tangerine,
     kiwi,
     cocktail onion,
     kumquat,
     tonic water,
     raspberry
];


static skill SUMMON_CLIPART = $skill[ Summon Clip Art ];

void sell_breakfast_loot()
{
return;
}


//*******************************************************************************************
// CLIP ART
//*******************************************************************************************


void TBHClipArt() {
boolean have_clipart = have_skill( SUMMON_CLIPART );
print( "Start Clip Art");
if (have_clipart) {
  int clipart_available = 3 - get_property( "_clipartSummons" ).to_int();
  print("Clip Art available: "+ clipart_available);
  if (clipart_available > 0){
    item clip = dearest( CLIP_ART_ITEMS );
    print( "Summoning Clip Art" );
    create (clipart_available, clip);
    }
}
print( "End Clip Art");
}



//*******************************************************************************************
// TIMESPINNER
//*******************************************************************************************

void TBHTimespin()
{
print( "Start Timespinner");
item far_future_item = $item[ Shot of Kardashian Gin ];
static int minutes_left = (10 - get_property( "_timeSpinnerMinutesUsed" ).to_int());
boolean replicator_available = get_property( "_timeSpinnerReplicatorUsed").to_boolean();
print("Replicator Used: " + replicator_available);
if ( minutes_left > 2 && !replicator_available ) {
  print( "Using the Time-Spinner" );
  cli_execute( "FarFuture " + far_future_item );
}
print( "End Timespinner");

}

//*******************************************************************************************
//FAX MONSTER
//*******************************************************************************************


//*******************************************************************************************
//Consult
//*******************************************************************************************
int attempts = 0;
int player = 3038166;
string name = get_player_name(player);
int consults_available = 3 - get_property( "_clanFortuneConsultUses" ).to_int();
print( "Consults Available: " + consults_available );
string temp = visit_url("clan_viplounge.php?preaction=lovetester", false);
string choices = "&q1=pizza&q2=batman&q3=thick";

//*******************************************************************************************
//Raffle
//*******************************************************************************************

void TBHRaffle() {
print( "Start Raffle");
boolean buyRaffle(int ticket_qty) {
    if(available_amount($item[raffle ticket]) < ticket_qty && my_name() == "threebullethamburgler" && visit_url("main.php").contains_text("map7beach.gif") && my_path() != "Zombie Slayer")
        cli_execute("raffle " + ticket_qty + (can_interact() ? " inventory": " storage"));
    return(available_amount($item[raffle ticket]) >= ticket_qty);
}
buyRaffle(5);
print( "End Raffle");

}



//*******************************************************************************************
//KGB
//*******************************************************************************************

void TBHKGB() {
print( "KGB Time");


while((get_property("_kgbDispenserUses").to_int() < 3) && (get_property("_kgbClicksUsed").to_int() < 22)) {
  visit_url("place.php?whichplace=kgb&action=kgb_dispenser", false);
}
if(!get_property("_kgbRightDrawerUsed").to_boolean()) {
 visit_url("place.php?whichplace=kgb&action=kgb_drawer1", false);
}
if(!get_property("_kgbLeftDrawerUsed").to_boolean()) {
  visit_url("place.php?whichplace=kgb&action=kgb_drawer2", false);
}
print( "KGB Done");

}


void ttKGB()
{
	if(item_amount($item[Kremlin's Greatest Briefcase]) == 0)
	{
		return;
	}

	if(!get_property("_kgbLeftDrawerUsed").to_boolean() || !get_property("_kgbRightDrawerUsed").to_boolean())
	{
		//ezandora script will do: unlockCrank(); unlockMartiniHose(); openLeftDrawer(); openRightDrawer(); unlockButtons();
		cli_execute("briefcase unlock");
	}
	if(get_property("_kgbDispenserUses").to_int() < 3)
	{
		cli_execute("briefcase epic");			//ezandora script collects 3x epic drinks
	}
}
//*******************************************************************************************
//Stock Up
//*******************************************************************************************
void TBHStock() {
print( "Start stocking Up");
if ( !get_property("_stocked").to_boolean() ){
        StockUp(55,$item[extra-greasy slider],23456,34567);
        StockUp(55,$item[ol' scratch's salad fork],12345,25000);
        StockUp(55,$item[frosty's frosty mug],23456,45678);
        StockUp(55,$item[jar of fermented pickle juice],33333,54321);
        StockUp(55,$item[voodoo snuff],10000,20000);
        StockUp(3,$item[mojo filter],3000,7890);
        cli_execute("set _stocked= true");
		}
print( "End Stocking Up");

}

//*******************************************************************************************
//Detective Solver
//*******************************************************************************************
void TBHDetective() {
print( "Start Detective School");
cli_execute("call Detective Solver");
print( "End Detective School");

}

//*******************************************************************************************
//Chateau
//*******************************************************************************************

void TBHChateau() {
print( "Start Chateau");
    if ( get_property_bool("chateauAvailable") && !get_property_bool("_chateauDeskHarvested") ) {
        visit_url("place.php?whichplace=chateau&action=chateau_desk1",false);
        visit_url("place.php?whichplace=chateau&action=chateau_desk2",false);
        visit_url("place.php?whichplace=chateau&action=chateau_desk3",false);
    }

if (get_property("chateauMonster") == "Black Crayon Crimbo Elf" && !get_property("_chateauMonsterFought").to_boolean()
  && $familiar[Robortender].try_equip()) {
  visit_url("/place.php?whichplace=chateau&action=chateau_painting", false);
  run_combat();
}
print( "End Chateau");

}

//*******************************************************************************************
//Clan Stuff
//*******************************************************************************************

void TBHClanStuff() {
print( "Start Clan Stuff");
    while(get_property("_clanFortuneConsultUses") < 3 && is_online(3038166) && switchClan(90485) ) { //BAfH
        if ( !can_interact() ) {
            if ( my_path() == "G-Lover" )
                cli_execute("fortune cheesefax asdf batman asdf");
            else
                cli_execute("fortune cheesefax asdf asdf thick");
        }
        else
            cli_execute("fortune cheesefax pizza batman thick");
        cli_execute("waitq 5");
    }
    cli_execute("shower cold");
    print( "End Clan Stuff");

}

//*******************************************************************************************
//DeckOfCards
//*******************************************************************************************

void TBHDeck() {
print( "Start Draw Cards");
if ( get_property("_deckCardsDrawn").to_int() < 3 ){
print( "Drawing the Deck" );
cli_execute("cheat ancestral");
cli_execute("cheat island");
cli_execute("cheat clubs");
}
print( "End Draw Cards");

}

//*******************************************************************************************
//Source Terminal
//*******************************************************************************************

void TBHExtrude() {
print( "Start Source Extrusion");
  while(get_property("_sourceTerminalExtrudes").to_int() < 3 ){
  cli_execute("terminal extrude cookie");
  }
  print( "End Source Extrusion");

}


//*******************************************************************************************
//Nash's Still
//*******************************************************************************************
void TBHStill(){

if (stills_available() > 0) {
print( "Start Distilling");
  item still = dearest( STILL_ITEMS );
  while (stills_available() > 0 ){
    cli_execute("make "+still);
    }
    print( "End Distilling");

  }

}

//*******************************************************************************************
//Free Crafts
//*******************************************************************************************
void TBHFreeCraft(){
if (freeCrafts() > 0){
  print( "Start Free Crafts");

  print( "End Free Crafts");

}

}
//*******************************************************************************************
//Tag Phil
//*******************************************************************************************
void TBHTagPhil(){
	if (!to_boolean(get_property("_taggedPhil"))) {
		print("Tagging Phil time");
		if (available_amount($item[personal graffiti kit]) > 0){
		visit_url('curse.php?action=use&whichitem=9738&targetplayer=2393910');
			set_property("_taggedPhil", true);
		}
	} else {
	print("Already Tagged Phil today");
	}
}

//*******************************************************************************************
//Boxing Daycare
//*******************************************************************************************
void BoxingDaycare() {
    string page;

    if ( get_property_bool("daycareOpen") || get_property_bool("_daycareToday") ) {
        void HireInstructors() {
            while ( page.contains_text("Hire an instructor ") && !page.contains_text("<font color=blue><b>[None currently available]</b></font>") && can_interact() ) {
                string [int,int] instructorItems;
                string instructorItemPlural;
                int instructorItemQty;
                item instructorItem;
                //<Table><tr><td valign=center><input  class=button type=submit value="Hire an instructor "></td><td valign=center><font color=blue><b>[539 patches of skate skin]</b></font></td></tr>
                instructorItems = group_string(page,"\"Hire an instructor \"></td><td valign=center><font color=blue><b>\\[(\\d+) ([^]]*)\\]");
                instructorItemPlural = instructorItems[0,2];
                instructorItemQty = to_int(instructorItems[0,1]);
                foreach it in $items[] {
                    if ( it.plural == instructorItemPlural ) {
                        instructorItem = it;
                        break;
                    }
                }
                mall_price(instructorItem);
                if ( instructorItem == $item[none] ) {
                    print("Failed to recognize requested daycare item plural: "+instructorItemPlural,"red");
                    break;
                }
                else if ( user_confirm("Do you want to hire an instructor for "+instructorItemQty+" "+instructorItem.plural+" costing approximately "+mall_price(instructorItem)*instructorItemQty+" meat ("+mall_price(instructorItem)+" each).", 60000, ((mall_price(instructorItem)==100) && has_effect($effect[Boxing Day Drinking])) )
                    && StockUp(instructorItemQty,instructorItem,1,mall_price(instructorItem)*3) ) {
                    page = visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
                    page = visit_url("choice.php?whichchoice=1334&option=3");
                    page = visit_url("choice.php?whichchoice=1336&pwd&option=3");
                }
                else
                    break;
            }
        }

        if ( !get_property_bool("_daycareNap") )
            cli_execute("daycare item");
        page = visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
        if ( !page.contains_text("a door to a spa to your left") )
            abort("We got lost in a daycare, didn't we?");
        else
            page = visit_url("choice.php?whichchoice=1334&option=3");
        if ( page.contains_text("<font color=blue><b>[free]</b></font>") )
            page = visit_url("choice.php?whichchoice=1336&pwd&option=2");
        HireInstructors();
        while ( (get_property_int("_daycareRecruits") < 1 || can_interact() && get_property_int("_daycareRecruits") < 2) && page.contains_text("00 Meat]</b></font>") && !page.contains_text("00,000 Meat]</b></font>") ) { // spend 10k meat at most
            page = visit_url("choice.php?whichchoice=1336&pwd&option=1");
            HireInstructors();
        }
        if ( !get_property_bool("_daycareFights") && hippy_stone_broken()  && !bossKilling
            && user_confirm("Do you want to fight "+get_property("daycareToddlers")+" toddlers to turn 1 adventure into "+min(11,2*length(get_property("daycareToddlers")))+" pvp fights?",60000,true) ) {
            page = visit_url("choice.php?whichchoice=1336&pwd&option=4");
        }
    }
}


//*******************************************************************************************
//Glitch Monster -- stolen from taltamir
//*******************************************************************************************

void glitchmon()
{
	//automatically fight glitch monster
	// https://kol.coldfront.net/thekolwiki/index.php/Glitch_season_reward_name
	if(item_amount($item[\[glitch season reward name\]]) == 0)
	{
		return;		//do not have item
	}
	if(get_property("_glitchMonsterFights").to_int() > 0)
	{
		return;		//only 1 fight per day allowed
	}

	//_glitchMonsterFights counts how many glitch monsters you fought today. can only fight 1/day.
	visit_url("inv_eat.php?&pwd&which=3&whichitem=10207"); 		//start fight with %monster%
	run_combat();												//finish combat using ccs
}
//*******************************************************************************************
//Do Free Fights 
//*******************************************************************************************

void TBHfreefights()
{
	if(to_boolean(get_property("doFreeFights")))
	{
		print("Doing Free Fights");
        cli_execute("3BHfreefights");
	}

}

//*******************************************************************************************
//*******************************************************************************************
//Start of Script
//*******************************************************************************************
//*******************************************************************************************
void main() {


if ( can_interact() ){
    TBHClipArt();
    TBHTimespin();
    TBHRaffle();
    ttKGB() ;
    TBHDetective();
    TBHStock();
    TBHChateau();
    TBHClanStuff();
    TBHDeck() ;
    TBHExtrude();
    TBHStill();
    TBHFreeCraft();
    cli_execute("breakfast");
    BoxingDaycare();
    glitchmon();
    TBHTagPhil();
    TBHfreefights();
  } else {
    TBHDetective();
    cli_execute("breakfast");
  }

}
