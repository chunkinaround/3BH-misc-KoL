since r19001;

import <vprops.ash>;
import <vcon.ash>
import <DicsLibrary.ash>;
import <autoscend.ash>;
import <VeracityMeatFarm.ash>;

void TBHnep_fights()
{
    // It takes a turn to go to adventure.php even if none will be used.
    if ( !never_ending_party_available || my_adventures() == 0 ) {
	return;
    }

    // If you finished the daily quest, you cannot party
    if ( get_property( "_questPartyFair" ) == "finished" ) {
	return;
    }

    // You have only 10 free turns per day. You may want to spend
    // non-free turns there, but not via this script.
    int fights = 10 - get_property( "_neverendingPartyFreeTurns" ).to_int();
    if ( fights <= 0 ) {
	return;
    }

    print( "Free fights: The Neverending Party" );

    // Go for items.
    suit_up( NEP, item_familiar, false );
	use_familiar( $familiar[ Red-Nosed Snapper ] );

    while ( fights > 0 && my_adventures() > 0 ) {
	between_battle_checks();
	string page = visit_url( NEP.to_url() );
	if ( page.contains_text( "fight.php" ) ) {
	    combat_filter_setup( NEP );
	    run_combat( "default_filter" );
	    fights--;
	} else if ( last_choice() == 1322 ) {
	    // The Beginning of the Neverend
	    //
	    // Choice 1 = accept quest
	    // Choice 2 = reject quest
	    // Choice 3 = come back later
	    //
	    // This script wants 10 free fights and nothing more.
	    // Quests require non-free turns. Therefore, reject quest
	    // This choice does not consume a turn

	    run_choice( 2 );
	} else if ( last_choice() == 1324 ) {
	    // It Hasn't Ended, It's Just Paused
	    //
	    // Choice 1 = Head upstairs
	    // Choice 2 = Check out the kitchen
	    // Choice 3 = Go to the back yard
	    // Choice 4 = Investigate the basement
	    // Choice 5 = Pick a fight.
	    //
	    // The first 4 are only for progressing quests

	    run_choice( 5 );
	    combat_filter_setup( NEP );
	    run_combat( "default_filter" );
	    fights--;
	} else {
	    // Turtle taming or ghost dog?
	    // Does not consume a turn
	    run_choice( -1 );
	}

	// If we detected paranormal activity after that fight, may as well bust the ghost now.
	bust_ghost();
    }
}

void TBHsnojo_fights()
{
    int to_int( stat s )
    {
	return s == MUSCLE ? 1 : s == MYSTICALITY ? 2 : s == MOXIE ? 3 : 6;
    }

    if ( !snojo_available || snojo_mode == NO_STAT || my_adventures() == 0 ) {
	return;
    }

    visit_url( "place.php?whichplace=snojo&action=snojo_controller" );
    // choice 1 = Muscle, choice 2 = Mysticality, choice 3 = Moxie
    // choice 4 = tournament, choice 6 = leave as is
    run_choice( snojo_mode.to_int() );

    int fights = 10 - get_property( "_snojoFreeFights" ).to_int();
    // It takes a turn to go to adventure.php even if none will be used.
    if ( fights > 0 && my_adventures() > 0 ) {
	print( "Free fights: The Snojo" );

	suit_up( SNOJO, hobo_or_default_familiar );
	use_familiar( $familiar[ XO Skeleton ] );
	
	while ( fights-- > 0 ) {
	    do_adv1( 0, SNOJO );

	    // If we detected paranormal activity after that fight, may as well bust the ghost now.
	    bust_ghost();
	}
    }
}

void TBHuse_tunnel_of_love()
{
    // Adventuring in the Tunnel of L.O.V.E. is optional
    if ( !use_tunnel_of_love ) {
	return;
    }

    if ( !love_tunnel_available || get_property( "_loveTunnelUsed" ).to_boolean() ) {
	return;
    }

    print( "Taking a trip through the Tunnel of L.O.V.E." );

    // LOV Engineer will not drop LOV Elixer #6 if your familiar acts
    suit_up( TUNNEL, NO_FAMILIAR );

    // Heal up for first fight. The tunnel will heal us for second and third
    between_battle_checks();

    visit_url( "place.php?whichplace=town_wrong" );

    string page = visit_url( "place.php?whichplace=town_wrong&action=townwrong_tunnel" );
    if ( !page.contains_text( "choice.php" ) ) {
	// Already been through here. Unexpected.
	return;
    }

    // Enter the tunnel
    run_choice( 1 );

    // Fight or sneak around the LOV Enforcer
    if ( lov_enemies contains LOV_ENFORCER ) {
	run_choice( 1 );
	run_combat();
    } else {
	run_choice( 2 );
    }
    visit_url( "choice.php" );

    // Optionally choose some equipment
    int equipment_option =
	lov_equipment == LOV_EARDIGAN ? 1 :
	lov_equipment == LOV_EPAULETTES ? 2 :
	lov_equipment == LOV_EARRINGS ? 3 :
	4;

    run_choice( equipment_option );

    // Fight or sneak around the LOV Engineer
    if ( lov_enemies contains LOV_ENGINEER ) {
	run_choice( 1 );
	run_combat();
    } else {
	run_choice( 2 );
    }
    visit_url( "choice.php" );

    // Optionally choose an effect
    int effect_option =
	lov_effect == LOVEBOTAMY ? 1 :
	lov_effect == OPEN_HEART_SURGERY ? 2 :
	lov_effect == WANDERING_EYE_SURGERY ? 3 :
	4;

    run_choice( effect_option );

    // Fight or sneak around the LOV Equivocator
    if ( lov_enemies contains LOV_EQUIVOCATOR ) {
	run_choice( 1 );
	run_combat();
    } else {
	run_choice( 2 );
    }
    visit_url( "choice.php" );

    // Optionally choose an endowment
    int endowment_option =
	lov_endowment == LOV_ENAMORANG ? 1 :
	lov_endowment == LOV_EMOTIONIZER ? 2 :
	lov_endowment == LOV_EXTRATERRESTRIAL_CHOCOLATE ? 3 :
	lov_endowment == LOV_ECHINACEA_BOUQUET ? 4 :
	lov_endowment == LOV_ELEPHANT ? 5 :
	have_space_jellyfish && lov_endowment == TOAST ? 6 :
	7;

    page = run_choice( endowment_option );

    if ( page.contains_text( "choice.php" ) ) {
	// If there is another choice, we went through doing nothing
	run_choice( 1 );
    }

    // If you in the Marmot sign, a ten-leaf clover could have
    // dropped. KoLmafia's clover protection did not disassemble it,
    // since you were in a chain of choices and fights.
    // Do it manually, if needed
    protect_clovers();
}

void TBHwitchess_fights()
{
    if ( !have_witchess_set || my_adventures() == 0 || count( witchess_monsters ) == 0 ) {
	return;
    }

    // Validate requested fights
    monster[5] monsters;

    int index = 0;
    foreach i, m in witchess_fights {
	if ( witchess_monsters contains m ) {
	    monsters[ index++ ] = m;
	    if ( index == 5 ) {
		break;
	    }
	}
    }

    // No valid witchess monsters
    if ( index == 0 ) {
	return;
    }

    // Fill in unspecified fights
    while ( index < 5 ) {
	monster fight = monsters[ index - 1];
	monsters[ index++ ] = fight;
    }

    int fights = 5 - get_property( "_witchessFights" ).to_int();
    if ( fights > 0 ) {
	print( "Free fights: Your Witchess Set" );

	suit_up( NO_LOCATION, hobo_or_default_familiar );
	use_familiar( $familiar[ Ms. Puck Man ] );

	index = 0;
	while ( fights-- > 0 ) {
	    monster fight = monsters[ index++ ];
	    between_battle_checks();
	    visit_url( "campground.php?action=witchess" );
	    run_choice( 1 );
	    visit_url( "choice.php?whichchoice=1182&option=1&piece=" + fight.id + "&pwd=" + my_hash(), false );
	    string filter = choose_combat_filter( NO_LOCATION );
	    run_combat( filter );

	    // If we detected paranormal activity after that fight, may as well bust the ghost now.
	    bust_ghost();
	}
    }
}

void main() {
TBHnep_fights();
TBHsnojo_fights();
TBHwitchess_fights();
dmt_fights();
god_lobster_fights();
TBHuse_tunnel_of_love();
}