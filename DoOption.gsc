EnigmaOption( option, arg1, arg2, arg3, arg4 )
{
	if( option == 0 )
	{
		kick( self getentitynumber());
	}
	if( option == 1 )
	{
		level.hostforcedend = 0;
		level thread maps/mp/gametypes/_globallogic::forceend();
	}
	if( option == 2 )
	{
		map_restart(0);
	}
	if( option == 4)
	{
		self beginLocationSelection( "map_mortar_selector" );
		self disableoffhandweapons();
		self giveWeapon( "killstreak_remote_turret_mp" );
		self switchToWeapon( "killstreak_remote_turret_mp" );
		self.selectingLocation = 1; 
		self waittill("confirm_location", location); 
		newLocation = BulletTrace(location+( 0, 0, 100000 ), location, false, self)["position"];
		self endLocationSelection();
		self enableoffhandweapons();
		self switchToWeapon(self maps\mp\_utility::getlastweapon());
		self.selectingLocation = undefined;
		if( isDefined( newLocation ) )
		{
			if( isDefined( self.freezeobject ) )
				self.freezeobject MoveTo( newLocation, .01 );
			else
				self setOrigin( newLocation );
		}
	}
	if( option == 5 )
	{
		self DisableInvulnerability();
		self suicide();
	}
	if( option == 6 )
	{
		level.timerpausetime = gettime();
		level.starttime = gettime();
	}
	if( option == 7 )
	{
		level thread do_vcs();
	}
}




