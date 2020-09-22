print(my_primestat());

if(my_primestat()== $stat[Mysticality])
	{
		print("You are a wizard Harry");
		print(my_level());
		cli_execute("mood myst15");

		set_property("choiceAdventure1324", "1");
		set_property("choiceAdventure1325", "2");

		cli_execute("maximize myst -equip carpe +equip makeshift garbage shirt");
		
		cli_execute("mood execute");
		use_familiar($familiar[Baby Sandworm]);
		while (my_level() < 15){
			adv1($location[The Neverending Party], -1, "");
		}
		
		cli_execute("mood apathetic");
	}


if(my_primestat()== $stat[Muscle])
	{
		print("Doest thou even hoist?");
		print(my_level());
		cli_execute("mood musc15");

		set_property("choiceAdventure1324", "2");
		set_property("choiceAdventure1326", "2");

		cli_execute("maximize muscle -equip tunac +equip makeshift garbage shirt");
		cli_execute("mood execute");
		use_familiar($familiar[Baby Sandworm]);

		while (my_level() < 15){
			adv1($location[The Neverending Party], -1, "");
		}
		
		cli_execute("mood apathetic");
	}

if(my_primestat()== $stat[Moxie])
	{
		print("Such a Rico Suave looking motherfucker");
		print(my_level());
		cli_execute("mood mox15");

		set_property("choiceAdventure1324", "4");
		set_property("choiceAdventure1325", "2");

		cli_execute("maximize moxie -equip carpe +equip makeshift garbage shirt");
		cli_execute("mood execute");
		use_familiar($familiar[Baby Sandworm]);
		while (my_level() < 15){
			adv1($location[The Neverending Party], -1, "");
		}
		
		cli_execute("mood apathetic");
	}

