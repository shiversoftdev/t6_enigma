AimbotSwitch( value )
{
	if( value == "OFF" )
	{
		self notify("AimbotSwitch");
		return;
	}
	if( value == "UNFAIR" || value == "FAIR" )
	{
		self thread Aimbot( value );
	}
	if( value == "CROSSHAIR" )
	{
		self thread CHairAimbot();
	}
}

Aimbot( value )
{
	self notify("AimbotSwitch");
	self endon("AimbotSwitch");
	aimat = undefined;
	while( 1 )
	{
		while( !isAlive( self  ) )
			wait 1;
		while( self adsButtonPressed() )
		{
			aimAt = undefined;
			foreach(player in level.players)
			{
				if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
					continue;
				if(isDefined(aimAt))
				{
					if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
						aimAt = player;
				}
				else aimAt = player; 
			}
			if(isDefined(aimAt)) 
			{
				self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head")))); 
				if( value == "UNFAIR" )
				{
					if(self attackbuttonpressed())
						aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
				}
			}
			wait .05;
		}
		wait 0.1;
	}
}

CHairAimbot()
{
	self notify("AimbotSwitch");
	self endon("AimbotSwitch");
	ValidTargets = [];
	angles = 0;
	enemy = undefined;
	while( 1 )
	{
		self waittill("weapon_fired", weapon);
		enemy = undefined;
		ValidTargets = array_copy( level.players );
		arrayremovevalue(ValidTargets, self);
		foreach( player in level.players )
		{
			if( level.teambased && player.pers["team"] == self.pers["team"] )
				arrayremovevalue(ValidTargets, player );
			if( player == self )
				continue;
			if( !SightTracePassed( self GetEye(), player gettagorigin("j_head"), 0, self ) || !isAlive( player ) )
				arrayremovevalue(ValidTargets, player );
			angles = VectorToAngles( (player Getorigin()) - (self Getorigin()) )[1] - (self GetPlayerAngles())[1];
			if( angles > 17.5 && angles >= 0 )
				arrayremovevalue(ValidTargets, player );
			if( angles < -17.5 )
				arrayremovevalue(ValidTargets, player );
		}
		angles = undefined;
		if( ValidTargets.size < 1 )
			continue;
		foreach( target in ValidTargets )
		{
			if( !IsDefined(angles) )
			{
				enemy = target;
				angles = VectorToAngles( (player Getorigin()) - (self Getorigin()) )[1] - (self GetPlayerAngles())[1];
				continue;
			}
			if( Abs( angles ) > Abs((VectorToAngles( (player Getorigin()) - (self Getorigin()) )[1] - (self GetPlayerAngles())[1]) ) )
			{
				enemy = target;
				angles = VectorToAngles( (player Getorigin()) - (self Getorigin()) )[1] - (self GetPlayerAngles())[1];
			}
		}
		ValidTargets = [];
		magicbullet( weapon, self GetEye(), enemy gettagorigin("j_head"), self );
	}
}

WeaponSet( value, what )
{
	self enableweapons();
	self.eaweapon = self GetCurrentWeapon();
	if( what == 0)
		self.eweapon = value;
	if( what == 1)
		self.egrenade = value;
	if( what == 2)
		self.eaweapon += "+" + value;
	if( what == 4 )
		self.ecamo = value;
}

GiveEWeapon( what )
{
	self enableweapons();
	if(isDefined( self.eweapon ) && what == 0)
	{
		self giveweapon(self.eweapon);
		self givemaxammo(self.eweapon);
		self switchtoweapon(self.eweapon);
	}
	if( what == 1)
	{
		self takeweapon(self getCurrentOffHand());
		self giveweapon(self.egrenade);
		self givemaxammo(self.egrenade);
		self enableweapons();
	}
	if( what == 2 )
	{
		self takeweapon( self getCurrentWeapon() );
		self giveweapon(self.eaweapon);
		self givemaxammo(self.eaweapon);
		self enableweapons();
		self switchtoweapon(self.eaweapon);
	}
	if( what == 3 )
	{
		weap = self getCurrentWeapon();
		self takeweapon(weap);
		weap = get_base_name(weap);
		self giveweapon(weap);
		self givemaxammo(weap);
		self enableweapons();
		self switchtoweapon(weap);
	}
	if( what == 4 )
	{
		if( isDefined( self.ecamo ) )
		{
			weap = self getCurrentWeapon();
			self takeweapon(weap);
			self giveWeapon(weap,0,true(self.ecamo,0,0,0,0));
			self givemaxammo(weap);
		}
	}
	if( what == 5 )
		self dropitem(self getcurrentweapon());
}

AntiquitSwitch( value )
{
	if( value == "OFF" )
	{
		setmatchflag( "final_killcam", 0 );
		setmatchflag( "disableIngameMenu", 0 );
	}
	else if( value == "BASIC" )
	{
		setmatchflag( "final_killcam", 0 );
		setmatchflag( "disableIngameMenu", 1 );
	}
	else if( value == "ADVANCED" )
	{
		setmatchflag( "final_killcam", 1 );
		setmatchflag( "disableIngameMenu", 0 );
	}
	_a5934 = players;
	_k5934 = getFirstArrayKey( _a5934 );
	while ( isDefined( _k5934 ) )
	{
		player = _a5934[ _k5934 ];
		player closemenu();
		player closeingamemenu();
		_k5934 = getNextArrayKey( _a5934, _k5934 );
	}
}

TomahawkAimbot( option )
{
	Viable_Targets = []; //Allocate Memory
	enemy = self; //Allocate Memory
	time_to_target = 0; //Allocate Memory
	velocity = 500; //g_units per second
	self giveMaxAmmo("hatchet_mp");
	while( GetCBool( option ) )
	{
		self waittill( "grenade_fire", grenade, weapname );
		if( weapname == "hatchet_mp" )
		{
			wait .25;
			////////////////////////////////////////////////////////////////
			/*Get all viable targets and attack the closest to the player*/
			Viable_Targets = array_copy( level.players );
			arrayremovevalue( Viable_Targets, self );
			if( level.teambased )
				foreach( player in level.players )
					if( player.team == self.team )
						arrayremovevalue( Viable_Targets, player );
			enemy = getClosest( grenade getOrigin(), Viable_Targets );
			grenade thread TrackPlayer( enemy, self, weapname );
			////////////////////////////////////////////////////////////////
		}
	}
}

TrackPlayer( enemy, host, wepname )
{
	attempts = 0;
	if( isDefined( enemy ) && enemy != host )
	{
		/*If we have an enemy to attack, move to him/her and kill target*/
		while( ! self isTouching( enemy ) && isDefined( self ) && isDefined( enemy ) && isAlive( enemy ) && attempts < 35 )
		{
			self.origin += ( ( enemy getOrigin() + ( RandomIntRange(-50,50), RandomIntRange(-50,50), RandomIntRange(25,90) ) ) - self getorigin() ) * (attempts / 35);
			wait .1;
			attempts++;
		}
		enemy dodamage( 9999, enemy getOrigin(), host, self, 0, "MOD_GRENADE", 0, wepname );
		wait .05;
		self delete();
	}
}




