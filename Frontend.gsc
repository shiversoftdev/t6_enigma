///Functions:
///			CreateMain( title )																								--This is the main menu
///			AddOption( "Title", ::Function, arg1, arg2, arg3, arg4, arg5 );													--This is to add a option to the menu
///			AddPlayerOption("Title", ::Function, arg2, arg3, arg4, arg5);													--This is to add a player option to the menu. Please note: All functions called by AddPlayerOption are given the player as the first parameter!
///			AddSliderInt( "Title", defaultValue, minvalue, maxvalue, Increment, ::Onchanged, arg2, arg3, arg4, arg5);		--This is to add a slider to your menu. OnChanged is passed the new value in parameter 1 (Example: OnChanged( newvalue, other params... ) )
///			AddSliderBool("Title", ::OnChanged, arg1, arg2, arg3, arg4, arg5 );												--This is to add a slider to your menu. OnChanged must return true or false!
///			AddSliderList("Title", strings[], ::OnChanged, arg2, arg3, arg4, arg5 );										--This is to add a slider to your menu. OnChanged is passed the new string as parameter 1
///			SetCVar("Variable");																							--This is to set a variable in your menu
///			GetCVar("Variable");																							--This is to get a variable's value from your menu
///			GetCBool("Variable");																							--This will get a boolean variable from your variable list
///			Toggle("Variable");																								--This will toggle a variable in your menu and return the result
///			AddSubMenu( "Title", AccessLevel );																				--This is to add a submenu
///			EndSubMenu(); 																									--This is to close off the current submenu. You must call this each time you exit a sub menu
///			AddPlayersMenu( title, access )																					--This is a special function to add a players menu to your menu
///			AddPlayerSliderInt( "Title", defaultValue, minvalue, maxvalue, Increment, ::Onchanged, arg2, arg3, arg4, arg5);	--This is to add a slider to your menu. OnChanged is passed the new value in parameter 2 (Example: OnChanged( player, newvalue, other params... ) )
///			AddPlayerSliderBool("Title", ::OnChanged, arg1, arg2, arg3, arg4, arg5 );										--This is to add a slider to your menu. OnChanged must return true or false!
///			AddPlayerSliderList("Title", strings[], ::OnChanged, arg2, arg3, arg4, arg5 );									--This is to add a slider to your menu. OnChanged is passed the new string as parameter 2
///			EndPlayersMenu();																								--This is a special function to end your players menu
///
///			Note: Pages are automatically added for you. No need to worry about scroll.	
///			Note: Do not use any sliders in the main menu. They will not load properly.
///			Warning: Do not reference level.Evanescence.options or level.Evanescence. You will freeze. Use the provided functions instead.
/*
#Dev
TODO M AIMBOT

*/
MakeOptions()
{
	CreateStringArrays();
	CreateMain( "ENIGMA" );
		AddSubMenu("DEVELOPMENT MENU", 4);
			AddOption("NONE");
		EndSubMenu();
		AddSubMenu( "PERSONAL MENU", 1 );
			AddSliderBool("GODMODE", ::EnigmaBool, 0);
			AddSliderBool("INFINITE AMMO", ::EnigmaBool, 1);
			AddSliderBool("BIND NO CLIP", ::EnigmaBool, 8);
			AddSliderBool("INVISIBILITY", ::EnigmaBool, 5);
			AddSliderInt( "SPEED SCALE", 1, 0, undefined, 1, ::EnigmaValue, 0);
			AddSliderBool("ALL PERKS", ::EnigmaBool, 6);
			AddSliderBool("THIRD PERSON", ::EnigmaBool, 7);
			AddSubMenu("AIMBOT MENU",2);
				AddSliderList("WEAPON AIMBOT", strtok("OFF,FAIR,UNFAIR,CROSSHAIR",","), ::AimbotSwitch);
				AddSliderBool("TOMAHAWK AIMBOT", ::EnigmaBool, 10);
				AddSliderBool("PROJECTILE AIMBOT", ::EnigmaBool, 11);
				AddSliderBool("GRENADE AIMBOT", ::EnigmaBool, 12);
				if( level.script == "mp_nuketown_2020" )
					AddSliderBool("MANNEQUIN AIMBOT", ::EnigmaBool, 13);
				AddSliderBool("DOG AIMBOT", ::EnigmaBool, 14);
				AddSliderBool("SWARM AIMBOT", ::EnigmaBool, 15);
				AddSliderBool("VEHICLE AIMBOT", ::EnigmaBool, 16);
			EndSubMenu();
			AddOption("TELEPORT", ::EnigmaOption, 4);
			AddOption("SUICIDE", ::EnigmaOption, 5);
		EndSubMenu();
		AddSubMenu("FUN MENU", 2);
			AddSubMenu("WEAPONS", 2);
				AddSliderBool("GJALLARHORN", ::EnigmaBool, 4);
			EndSubMenu();
			AddSliderBool("AUTO TROPHY SYSTEM", ::EnigmaBool, 3);
		EndSubMenu();
		AddSubMenu("WEAPONS MENU", 1);
			AddSliderList("WEAPON", level.EnigmaWeapons, ::WeaponSet, 0);
			AddSliderInt( "CAMO", 1, 0, 45, 1, ::WeaponSet, 4);
			AddSliderList("ATTACHMENT", level.EnigmaAttachments, ::WeaponSet, 2);
			AddSliderList("GRENADE", level.EnigmaGrenades, ::WeaponSet, 1);
			AddOption("GIVE WEAPON", ::GiveEWeapon, 0);
			AddOption("GIVE CAMO", ::GiveEWeapon, 4);
			AddOption("GIVE ATTACHMENT", ::GiveEWeapon, 2);
			AddOption("GIVE GRENADE", ::GiveEWeapon, 1);
			AddOption("CLEAR ATTACHMENTS", ::GiveEWeapon, 3);
			AddOption("DROP WEAPON", ::GiveEWeapon, 5);
		EndSubMenu();
		AddSubMenu("MAP MODS", 3);
			MapSpecifics();
		EndSubMenu();
		AddSubMenu("GAME SETTINGS", 4);
			AddSliderList( "ANTI QUIT", strtok("OFF,BASIC,ADVANCED",","), ::AntiquitSwitch);
			AddSliderBool("UNLIMITED GAME", ::EnigmaBool, 9);
			AddSliderBool("FORCE HOST", ::EnigmaBool, 2);
			AddOption("RESET TIMER", ::EnigmaOption, 6);
			AddOption("RESTART GAME", ::EnigmaOption, 2);
			AddOption("END GAME", ::EnigmaOption, 1);
		EndSubMenu();
		AddSubMenu( "SETTINGS", 1 );
			AddSliderBool("FREEZE IN MENU", ::PersonalizeFreeze);
			AddSubMenu( "TITLE COLOR", 1 );
				AddOption("LOAD SETTINGS", ::LoadPreferenceSliderInfo, "TITLE COLOR");
				AddSliderInt( "RED VALUE", 255, 0, 255, 5, ::PersonalizeMenu, "TITLE COLOR","RED VALUE");
				AddSliderInt( "GREEN VALUE", 255, 0, 255, 5, ::PersonalizeMenu, "TITLE COLOR","GREEN VALUE");
				AddSliderInt( "BLUE VALUE", 255, 0, 255, 5, ::PersonalizeMenu, "TITLE COLOR","BLUE VALUE");
			EndSubMenu();
			AddSubMenu( "BACKGROUND COLOR", 1 );
				AddOption("LOAD SETTINGS", ::LoadPreferenceSliderInfo, "BACKGROUND COLOR");
				AddSliderInt( "RED VALUE", 0, 0, 255, 5, ::PersonalizeMenu, "BACKGROUND COLOR","RED VALUE");
				AddSliderInt( "GREEN VALUE", 0, 0, 255, 5, ::PersonalizeMenu, "BACKGROUND COLOR","GREEN VALUE");
				AddSliderInt( "BLUE VALUE", 0, 0, 255, 5, ::PersonalizeMenu, "BACKGROUND COLOR","BLUE VALUE");
			EndSubMenu();
			AddSubMenu( "TEXT COLOR", 1 );
				AddOption("LOAD SETTINGS", ::LoadPreferenceSliderInfo, "TEXT COLOR");
				AddSliderInt( "RED VALUE", 255, 0, 255, 5, ::PersonalizeMenu, "TEXT COLOR","RED VALUE");
				AddSliderInt( "GREEN VALUE", 255, 0, 255, 5, ::PersonalizeMenu, "TEXT COLOR","GREEN VALUE");
				AddSliderInt( "BLUE VALUE", 255, 0, 255, 5, ::PersonalizeMenu, "TEXT COLOR","BLUE VALUE");
			EndSubMenu();
			AddSubMenu( "HIGHLIGHT COLOR", 1 );
				AddOption("LOAD SETTINGS", ::LoadPreferenceSliderInfo, "HIGHLIGHT COLOR");
				AddSliderInt( "RED VALUE", 255, 0, 255, 5, ::PersonalizeMenu, "HIGHLIGHT COLOR","RED VALUE");
				AddSliderInt( "GREEN VALUE", 128, 0, 255, 5, ::PersonalizeMenu, "HIGHLIGHT COLOR","GREEN VALUE");
				AddSliderInt( "BLUE VALUE", 0, 0, 255, 5, ::PersonalizeMenu, "HIGHLIGHT COLOR","BLUE VALUE");
			EndSubMenu();
			AddControlsMenu( "CONTROLS", 1 );
				AddOption("LOAD SETTINGS", ::LoadPreferenceSliderInfo, "CONTROLS");
				AddSliderList("SCROLL UP", strtok("[{+actionslot 1}],[{+actionslot 2}],[{+actionslot 3}],[{+actionslot 4}],[{+gostand}],[{+melee}],[{+attack}],[{+speed_throw}],[{+smoke}],[{+frag}],[{+usereload}],[{+weapnext_inventory}],[{+stance}]",","), ::PersonalizeMenu, "CONTROLS", 0);
				AddSliderList("SCROLL DOWN", strtok("[{+actionslot 2}],[{+actionslot 3}],[{+actionslot 4}],[{+gostand}],[{+melee}],[{+attack}],[{+speed_throw}],[{+smoke}],[{+frag}],[{+usereload}],[{+weapnext_inventory}],[{+stance}],[{+actionslot 1}]",","), ::PersonalizeMenu, "CONTROLS", 1);
				AddSliderList("SLIDER LEFT", strtok("[{+actionslot 3}],[{+actionslot 4}],[{+gostand}],[{+melee}],[{+attack}],[{+speed_throw}],[{+smoke}],[{+frag}],[{+usereload}],[{+weapnext_inventory}],[{+stance}],[{+actionslot 1}],[{+actionslot 2}]",","), ::PersonalizeMenu, "CONTROLS", 2);
				AddSliderList("SLIDER RIGHT", strtok("[{+actionslot 4}],[{+gostand}],[{+melee}],[{+attack}],[{+speed_throw}],[{+smoke}],[{+frag}],[{+usereload}],[{+weapnext_inventory}],[{+stance}],,[{+actionslot 1}],[{+actionslot 2}],[{+actionslot 3}]",","), ::PersonalizeMenu, "CONTROLS", 3);
				AddSliderList("SELECT", strtok("[{+gostand}],[{+melee}],[{+attack}],[{+speed_throw}],[{+smoke}],[{+frag}],[{+usereload}],[{+weapnext_inventory}],[{+stance}],[{+actionslot 1}],[{+actionslot 2}],[{+actionslot 3}],[{+actionslot 4}]",","), ::PersonalizeMenu, "CONTROLS", 4);
				AddSliderList("BACK", strtok("[{+melee}],[{+attack}],[{+speed_throw}],[{+smoke}],[{+frag}],[{+usereload}],[{+weapnext_inventory}],[{+stance}],[{+actionslot 1}],[{+actionslot 2}],[{+actionslot 3}],[{+actionslot 4}],[{+gostand}]",","), ::PersonalizeMenu, "CONTROLS", 5);
				AddSliderList("PAGE RIGHT", strtok("[{+attack}],[{+speed_throw}],[{+smoke}],[{+frag}],[{+usereload}],[{+weapnext_inventory}],[{+stance}],[{+actionslot 1}],[{+actionslot 2}],[{+actionslot 3}],[{+actionslot 4}],[{+gostand}],[{+melee}]",","), ::PersonalizeMenu, "CONTROLS", 6);
				AddSliderList("PAGE LEFT", strtok("[{+speed_throw}],[{+smoke}],[{+frag}],[{+usereload}],[{+weapnext_inventory}],[{+stance}],[{+actionslot 1}],[{+actionslot 2}],[{+actionslot 3}],[{+actionslot 4}],[{+gostand}],[{+melee}],[{+attack}]",","), ::PersonalizeMenu, "CONTROLS", 7);	
			EndSubMenu();
		EndSubMenu();
		AddPlayersMenu("PLAYERS MENU", 3);
			AddPlayerSliderBool("GODMODE", ::EnigmaBool, 0);
			AddPlayerSliderBool("INFINITE AMMO", ::EnigmaBool, 1);
			AddPlayerSliderBool("BIND NO CLIP", ::EnigmaBool, 8);
			AddPlayerSliderBool("INVISIBILITY", ::EnigmaBool, 5);
			AddPlayerSliderInt( "SPEED SCALE", 1, 0, undefined, 1, ::EnigmaValue, 0);
			AddPlayerSliderBool("ALL PERKS", ::EnigmaBool, 6);
			AddPlayerSliderBool("THIRD PERSON", ::EnigmaBool, 7);
			AddPlayerSliderList("FREEZE", strtok("OFF,ALLOW LOOK,FULL", ","), ::FreezeMe);
			AddPlayerOption("SUICIDE", ::EnigmaOption, 5);
			AddPlayerOption("KICK PLAYER", ::EnigmaOption, 0);
			AddSubMenu("VERIFICATION", 3);
				AddPlayerOption("UNVERIFY", ::SetAccess, 0);
				AddPlayerOption("VERIFIED", ::SetAccess, 1);
				AddPlayerOption("ELEVATED", ::SetAccess, 2);
				AddPlayerOption("COHOST", ::SetAccess, 3);
			EndSubMenu();
		EndPlayersMenu();
}

CreateStringArrays()
{
	level.EnigmaWeapons = [];
	level.EnigmaWeapons = add_to_array(level.EnigmaWeapons, "NONE", 0);
	level.EnigmaGrenades = [];
	level.EnigmaGrenades = add_to_array(level.EnigmaGrenades, "NONE", 0);
	level.EnigmaAttachments = [];
	foreach( weap in GetArrayKeys(level.primary_weapon_array) )
	{
		level.EnigmaWeapons = add_to_array(level.EnigmaWeapons, get_base_name(weap), 0);
		level.EnigmaAttachments = add_to_array(level.EnigmaAttachments, get_attachments(weap), 0);
	}
	foreach( weap in GetArrayKeys(level.side_arm_array) )
		level.EnigmaWeapons = add_to_array(level.EnigmaWeapons, get_base_name(weap), 0);
	foreach( weap in GetArrayKeys(level.grenade_array) )
		level.EnigmaGrenades = add_to_array(level.EnigmaGrenades, weap, 0);
/*
	foreach( weap in GetArrayKeys(level.inventory_array) )
		level.EnigmaWeapons = add_to_array(level.EnigmaWeapons, weap, 0);
*/

}

MapSpecifics()
{
	if( level.script == "mp_nuketown_2020" )
	{
		AddOption("ENABLE MINIGAME", ::EnigmaOption, 7);	
	}
}

WelcomeMessage()
{
	self thread maps/mp/gametypes/_hud_message::hintmessage( "WELCOME TO THE MENU!" );
	self iprintln("Welcome. Press [{+actionslot 1}] to open the menu!");
}

ControlMonitor()
{
	self endon("disconnect");
	self endon("VerificationChange");
	Menu = self GetMenu();
	if( !isDefined( Menu ) )
		return;
	Buttons = array_copy(Menu.preferences.controlscheme);
	CLOSED = -1;
	MAIN = 0;
	oldmenu = -1;
	self freezecontrols( false );
	while( 1 )
	{
		if( !isAlive( self ) )
		{
			oldmenu = Menu.currentmenu;
			Menu.currentmenu = CLOSED;
			self UpdateMenu();
			while( !isAlive( self ) )
				wait 1;
			if( oldmenu != CLOSED )
			{
				Menu.currentmenu = oldmenu;
				self UpdateMenu( true );
			}
		}
		if( self ActionSlotOneButtonPressed() && Menu.currentmenu == CLOSED)
		{
			Menu.currentmenu = MAIN;
			self UpdateMenu( true );
			while( self IsButtonPressed( Buttons[0] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[5] ) && Menu.currentmenu == MAIN )
		{
			self PlayLocalSound("uin_main_exit");
			Menu.currentmenu = CLOSED;
			UpdateMenu();
			while( self IsButtonPressed( Buttons[5] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[5] ) && Menu.currentmenu != CLOSED )
		{
			self PlayLocalSound("uin_main_exit");//TODO
			if( Menu.currentmenu == level.menu_controls_menu )
			{
				ControlsValidate();
				Buttons = array_copy(Menu.preferences.controlscheme); //This updates our controls AFTER we exit the settings menu
			}
			if(Menu.currentmenu == level.si_players_menu )
				Menu.selectedplayer = undefined;
			Menu.currentmenu = level.Evanescence.options[ Menu.currentmenu ].parentmenu;
			UpdateMenu();
			while( self IsButtonPressed( Buttons[5] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[0] ) && Menu.currentmenu != CLOSED)
		{
			if( Menu.text.size > 1 )
			{
				Menu.text[ Menu.cursors[ Menu.CurrentMenu ] ] notify("Deselected");
				self PlayLocalSound("cac_grid_nav");
				if( isSlider( Menu.currentmenu, Menu.cursors[ Menu.currentMenu ] ) )
				{
					Menu.sliders[ level.Evanescence.options[ Menu.currentmenu ].options[ Menu.cursors[ Menu.currentMenu ] ].title ] notify("Deselected");
				}
				if( Menu.CurrentMenu != level.si_players_menu )
				{
					if( Menu.cursors[ Menu.CurrentMenu ] < 1 )
					{
						Menu.cursors[ Menu.CurrentMenu ] = ( level.Evanescence.options[ Menu.CurrentMenu ].options.size - 1 );		
					}
					else
						Menu.cursors[ Menu.CurrentMenu ]--;
				}
				else
				{
					if( Menu.cursors[ Menu.CurrentMenu ] < 1 )
					{
						Menu.cursors[ Menu.CurrentMenu ] = ( level.players.size - 1 );		
					}
					else
						Menu.cursors[ Menu.CurrentMenu ]--;
				}
				Menu.text[ Menu.cursors[ Menu.CurrentMenu ] ] thread SelectedOption( self );
				if( isSlider( Menu.currentmenu, Menu.cursors[ Menu.currentMenu ] ) )
				{
					Menu.sliders[ level.Evanescence.options[ Menu.currentmenu ].options[ Menu.cursors[ Menu.currentMenu ] ].title ] thread SelectedOption( self );
				}
			}
			while( self IsButtonPressed( Buttons[0] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[1] ) && Menu.currentmenu != CLOSED )
		{
			if( Menu.text.size > 1 )
			{
				self PlayLocalSound("cac_grid_nav");
				if( isSlider( Menu.currentmenu, Menu.cursors[ Menu.currentMenu ] ) )
				{
					Menu.sliders[ level.Evanescence.options[ Menu.currentmenu ].options[ Menu.cursors[ Menu.currentMenu ] ].title ] notify("Deselected");
				}
				Menu.text[ Menu.cursors[ Menu.CurrentMenu ] ] notify("Deselected");
				if( Menu.CurrentMenu != level.si_players_menu )
				{
					if( Menu.cursors[ Menu.CurrentMenu ] >= ( level.Evanescence.options[ Menu.CurrentMenu ].options.size - 1 ) )
					{
						Menu.cursors[ Menu.CurrentMenu ] = 0;		
					}
					else
						Menu.cursors[ Menu.CurrentMenu ]++;
				}
				else
				{
					if( Menu.cursors[ Menu.CurrentMenu ] >= ( level.players.size - 1 ) )
					{
						Menu.cursors[ Menu.CurrentMenu ] = 0;		
					}
					else
						Menu.cursors[ Menu.CurrentMenu ]++;
				}
				Menu.text[ Menu.cursors[ Menu.CurrentMenu ] ] thread SelectedOption( self );
				if( isSlider( Menu.currentmenu, Menu.cursors[ Menu.currentMenu ] ) )
				{
					Menu.sliders[ level.Evanescence.options[ Menu.currentmenu ].options[ Menu.cursors[ Menu.currentMenu ] ].title ] thread SelectedOption( self );
				}
			}
			while( self IsButtonPressed( Buttons[1] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[4] ) && Menu.currentmenu != CLOSED)
		{
			if( !isSlider( Menu.currentmenu, Menu.cursors[ Menu.currentMenu ] ) )
				self thread PerformOption();
			while( self IsButtonPressed( Buttons[4] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[2] ) && Menu.currentmenu != CLOSED)
		{
			self thread Slider( -1 );
			while( self IsButtonPressed( Buttons[2] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[6] ) && Menu.currentmenu != CLOSED)
		{
			NextPage();
			while( self IsButtonPressed( Buttons[6] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[7] ) && Menu.currentmenu != CLOSED)
		{
			PreviousPage();
			while( self IsButtonPressed( Buttons[7] ) && isAlive( self ) )
				wait .05;
		}
		else if( self IsButtonPressed( Buttons[3] ) && Menu.currentmenu != CLOSED)
		{
			self thread Slider( 1 );
			while( self IsButtonPressed( Buttons[3] ) && isAlive( self ) )
				wait .05;	
		}
		wait .05;
	}
	CloseMenu();
}

AddControlsMenu( title, access )
{
	AddSubMenu( title, access );
	level.menu_controls_menu = level.si_current_menu;
}












