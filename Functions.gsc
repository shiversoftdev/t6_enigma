ANoclipBind( option )
{
	self iprintln("^2Press [{+frag}] ^3to ^2Toggle No Clip");
	normalized = undefined;
	scaled = undefined;
	originpos = undefined;
	self unlink();
	self.originObj delete();
	while( GetCBool(option) )
	{
		if( self fragbuttonpressed())
		{
			self.originObj = spawn( "script_origin", self.origin, 1 );
    		self.originObj.angles = self.angles;
			self playerlinkto( self.originObj, undefined );
			while( self fragbuttonpressed() )
				wait .1;
			self iprintln("No Clip Enabled");
			self enableweapons();
			while( GetCBool(option) )
			{
				if( self fragbuttonpressed() )
					break;
				if( self SprintButtonPressed() )
				{
					normalized = anglesToForward( self getPlayerAngles() );
					scaled = vectorScale( normalized, 60 );
					originpos = self.origin + scaled;
					self.originObj.origin = originpos;
				}
				wait .05;
			}
			self unlink();
			self.originObj delete();
			self iprintln("No Clip Disabled");
			while( self fragbuttonpressed() )
				wait .1;
		}
		wait .1;
	}
}

FreezeMe( value )
{
	if( value == "OFF" )
	{
		self freezecontrols( false );
		self freezecontrolsallowlook( false );
	}
	if( value == "ALLOW LOOK" )
	{
		self freezecontrols( false );
		self freezecontrolsallowlook( true );
	}
	if( value == "FULL" )
	{
		self freezecontrolsallowlook( false );
		self freezecontrols( true );
	}
}

do_vcs()
{
	if( isDefined( level.vcsinprogress ) )
		return;
	level.vcsinprogress = true;
	targettag = getent( "player_tv_position", "targetname" );
	level.vcs_trigger = spawn( "trigger_radius_use", targettag.origin, 0, 64, 64 );
	level.vcs_trigger setcursorhint( "HINT_NOICON" );
	level.vcs_trigger sethintstring( &"MPUI_USE_VCS_HINT" );
	level.vcs_trigger triggerignoreteam();
	screen = getent( "nuketown_tv", "targetname" );
	screen setmodel( "nt_sign_population_vcs" );
	while ( 1 )
	{
		level.vcs_trigger waittill( "trigger", player );
		if ( player isusingremote() || !isalive( player ) )
		{
			continue;
		}
		prevweapon = player getcurrentweapon();
		if ( prevweapon == "none" || maps/mp/killstreaks/_killstreaks::iskillstreakweapon( prevweapon ) )
		{
			continue;
		}
		level.vcs_trigger setinvisibletoall();
		player giveweapon( "vcs_controller_mp" );
		player switchtoweapon( "vcs_controller_mp" );
		player setstance( "stand" );
		placementtag = spawn( "script_model", player.origin );
		placementtag.angles = player.angles;
		player playerlinktoabsolute( placementtag );
		placementtag moveto( targettag.origin, 0.5, 0.05, 0.05 );
		placementtag rotateto( targettag.angles, 0.5, 0.05, 0.05 );
		player enableinvulnerability();
		player openmenu( "vcs" );
		player wait_till_done_playing_vcs();
		if ( !level.gameended )
		{
			if ( isDefined( player ) )
			{
				player disableinvulnerability();
				player unlink();
				player takeweapon( "vcs_controller_mp" );
				player switchtoweapon( prevweapon );
			}
			level.vcs_trigger setvisibletoall();
		}
	}
}

wait_till_done_playing_vcs()
{
	self endon( "disconnect" );
	while ( 1 )
	{
		self waittill( "menuresponse", menu, response );
		return;
	}
}
