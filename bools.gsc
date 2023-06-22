EnigmaBool( option, arg1, arg2, arg3, arg4 )
{
	result = self Toggle( option );
	if( option == 0 )
	{
		if( result )
		{
			self EnableInvulnerability();
		}
		else
		{
			self DisableInvulnerability();
		}
	}
	if( option == 1 )
	{
		if( result )
			self thread EnigmaLoop(option);
	}
	if( option == 2 )
	{
		if( result )
		{
			setDvar("party_connectToOthers" , "0");
			setDvar("partyMigrate_disabled" , "1");
			setDvar("party_mergingEnabled" , "0");
		}
		else
		{
			setDvar("party_connectToOthers" , "1");
			setDvar("partyMigrate_disabled" , "0");
			setDvar("party_mergingEnabled" , "1");
		}
	}
	if( option == 3 )
	{
		if( result )
			self thread EnigmaLoop(option);
	}
	if( option == 4 )
	{
		if( result )
		{
			self enableweapons();
			self.ghornrocketout = false;
			weap = self getCurrentWeapon();
			self takeWeapon(weap);
			self giveWeapon( "fhj18_mp",0,true(39,0,0,0,0));
			self giveMaxAmmo("fhj18_mp");
			self switchtoweapon("fhj18_mp");
			self thread EnigmaLoop(option);
		}
	}
	if( option == 5 )
	{
		if( result )
		{
			self hide();
		}
		else
		{
			self show();
		}
	}
	if( option == 6 )
	{
		perks = strtok("specialty_additionalprimaryweapon,specialty_armorpiercing,specialty_armorvest,specialty_bulletaccuracy,specialty_bulletdamage,specialty_bulletflinch,specialty_bulletpenetration,specialty_deadshot,specialty_delayexplosive,specialty_detectexplosive,specialty_disarmexplosive,specialty_earnmoremomentum,specialty_explosivedamage,specialty_extraammo,specialty_fallheight,specialty_fastads,specialty_fastequipmentuse,specialty_fastladderclimb,specialty_fastmantle,specialty_fastmeleerecovery,specialty_fastreload,specialty_fasttoss,specialty_fastweaponswitch,specialty_finalstand,specialty_fireproof,specialty_flakjacket,specialty_flashprotection,specialty_gpsjammer,specialty_grenadepulldeath,specialty_healthregen,specialty_holdbreath,specialty_immunecounteruav,specialty_immuneemp,specialty_immunemms,specialty_immunenvthermal,specialty_immunerangefinder,specialty_killstreak,specialty_longersprint,specialty_loudenemies,specialty_marksman,specialty_movefaster,specialty_nomotionsensor,specialty_noname,specialty_nottargetedbyairsupport,specialty_nokillstreakreticle,specialty_nottargettedbysentry,specialty_pin_back,specialty_pistoldeath,specialty_proximityprotection,specialty_quickrevive,specialty_quieter,specialty_reconnaissance,specialty_rof,specialty_scavenger,specialty_showenemyequipment,specialty_stunprotection,specialty_shellshock,specialty_sprintrecovery,specialty_showonradar,specialty_stalker,specialty_twogrenades,specialty_twoprimaries,specialty_unlimitedsprint", ",");
		foreach( perk in perks )
		{
			if( result )
				self setperk( perk );
			else
				self unsetperk( perk );
		}
	}
	if( option == 7 )
	{
		self setclientthirdperson( result );
	}
	if( option == 8 )
	{
		if( result )
			self thread ANoclipBind( option );
	}
	if( option == 9 )
	{
		if( result )
		{
			maps\mp\gametypes\_globallogic_utils::pausetimer();
			setDvar("scr_" + level.gametype + "_scorelimit",0);
			setDvar("scr_" + level.gametype + "_numlives",0);
			setDvar("scr_player_forcerespawn",1);
		}
		else
		{
			maps\mp\gametypes\_globallogic_utils::resumetimer();
			setDvar("scr_" + level.gametype + "_scorelimit",100);
			if( level.gametype == "sd" )
				setDvar("scr_" + level.gametype + "_numlives",1);
			setDvar("scr_player_forcerespawn",1);
		}
	}
	if( option == 10 )
	{
		if( result )
			self thread TomahawkAimbot( option );
	}
	if( option == 11 )
	{
		if( result )
			self thread EnigmaLoop( option );
	}
	if( option == 12 )
	{
		if( result )
			self thread EnigmaLoop( option );
	}
	if( option == 13 )
	{
		if( result )
			self thread EnigmaLoop( option );
	}
	if( option == 14 )
	{
		if( result )
			self thread EnigmaLoop( option );
	}
	if( option == 15 )
	{
		if( result )
			self thread EnigmaLoop( option );
	}
	if( option == 16 )
	{
		if( result )
			self thread EnigmaLoop( option );
	}
	return result;
}


EnigmaLoop( option, arg1, arg2, arg3, arg4 )
{
	if( option == 1 )
	{
		while( GetCBool(option) )
		{
			weapon = self getcurrentweapon();
			if(weapon != "none")
			{
				self setWeaponAmmoClip(weapon, weaponClipSize(weapon));
				self giveMaxAmmo(weapon);
			}
			if(self getCurrentOffHand() != "none")
				self giveMaxAmmo(self getCurrentOffHand());
			self waittill_any("weapon_fired", "grenade_fire", "missile_fire");
		}
	}
	if( option == 3 )
	{
		ent = undefined;
		while( GetCBool(option) )
		{
			while( !isAlive( self  ) )
				wait 1;
			while( level.missileentities.size < 1 )
				wait .05;
			for( i = 0; i < level.missileentities.size; i++ )
			{
				wait .05;
				ent = level.missileentities[ i ];
				if( !isDefined( ent ) )
					continue;
				if ( !isDefined( ent.owner ) )
				{
					ent.owner = getmissileowner( ent );
				}
				if( isDefined( ent.owner ) && level.teambased && ent.owner.team == self.team)
					continue;
				if( isDefined( ent.owner ) && ent.owner == self )
					continue;
				if( isDefined( ent.weaponname ) )
				{
					if( ent.weaponname == "claymore_mp")
						continue;
				}
				if( isDefined( ent.model ) && ent.model == "t6_wpn_grenade_supply_projectile" )
					continue;
				if( Distance( ent GetOrigin(), self GetOrigin() ) <= 512 )
				{
					if ( bullettracepassed( ent.origin, self.origin + vectorScale( ( 0, 0, 1 ), 29 ), 0, self ) )
					{
						playfx( level.trophylongflashfx, self.origin + vectorScale( ( 0, 0, 1 ), 15 ), ent.origin - self.origin, anglesToUp( self.angles ) );
						self thread projectileexplode( ent, self );
						self playsound( "wpn_trophy_alert" );
						i--;
					}
				}
			}
			wait .05;
		}
	}
	if( option == 4)
	{
		self thread Gjallarhorn( option );
		while( GetCBool(option) )
		{
			self waittill( "missile_fire", missile, weapon_name );
			if( weapon_name == "fhj18_mp" )
				missile thread GHornRocket( self );
		}
		self takeWeapon("fhj18_mp");
	}
	if( option == 11 )
	{
		Viable_Targets = []; //Allocate Memory
		enemy = self; //Allocate Memory
		time_to_target = 0; //Allocate Memory
		velocity = 500; //g_units per second
		while( GetCBool( option ) )
		{
			self waittill( "missile_fire", missile, weapon_name );
			wait .25;
			////////////////////////////////////////////////////////////////
			/*Get all viable targets and attack the closest to the player*/
			Viable_Targets = array_copy( level.players );
			arrayremovevalue( Viable_Targets, self );
			if( level.teambased )
				foreach( player in level.players )
					if( player.team == self.team || !bullettracepassed( missile GetOrigin(), player.origin, 0, missile ))
						arrayremovevalue( Viable_Targets, player );
			enemy = getClosest( missile getOrigin(), Viable_Targets );
			missile thread PTrackPlayer( enemy, self, weapon_name );
			////////////////////////////////////////////////////////////////
		}
	}
	if( option == 12 )
	{
		Viable_Targets = []; //Allocate Memory
		enemy = self; //Allocate Memory
		while( GetCBool( option ) )
		{
			self waittill("grenade_fire", grenade );
			Viable_Targets = array_copy( level.players );
			arrayremovevalue( Viable_Targets, self );
			if( level.teambased )
				foreach( player in level.players )
					if( player.team == self.team || !bullettracepassed( grenade GetOrigin(), player.origin, 0, grenade ))
						arrayremovevalue( Viable_Targets, player );
			enemy = getClosest( grenade getOrigin(), Viable_Targets );
			if( isDefined( enemy ) )
			{
				grenade thread trackerV3(enemy, self);
			}
		}
	}
	if( option == 13 )
	{
		destructibles = getentarray( "destructible", "targetname" );
		mannequins = nuked_mannequin_filter( destructibles );
		target = undefined;
		while( GetCBool( option ) )
		{
			while( !isAlive( self  ) )
				wait 1;
			while( self adsButtonPressed() )
			{
				target = getClosest( self GetOrigin(), mannequins );
				if(isDefined(target)) 
				{
					self setplayerangles(VectorToAngles((target GetOrigin() + (0,0,65)) - (self getTagOrigin("j_head")))); 
					if(self attackbuttonpressed())
					{
						arrayRemoveValue(mannequins, target);
						self thread AnnihilateMannequin( target );
						MagicBullet( self GetCurrentWeapon(), (target GetOrigin() + (0,0,80)), (target GetOrigin() + (0,0,60)), self );
						while( self attackbuttonpressed())
							wait .05;
					}
				}
				wait .05;
			}
			wait 0.1;
		
		}
	}
	if( option == 14 )
	{
		dogs = getentarray( "attack_dog", "targetname" );
		while( GetCBool( option ) )
		{
			while( !isAlive( self  ) )
				wait 1;
			while( self adsButtonPressed() )
			{
				dogs = getentarray( "attack_dog", "targetname" );
				target = getClosest( self GetOrigin(), dogs );
				if(isDefined(target)) 
				{
					self setplayerangles(VectorToAngles((target GetOrigin()) - (self getTagOrigin("j_head")))); 
					if(self attackbuttonpressed())
					{
						target dodamage( 99999, target GetOrigin(), self );
					}
				}
				wait .05;
			}
			wait 0.1;
		}
	}
	if( option == 15 )
	{
		missiles = getentarray( "swarm_missile", "targetname" );
		while( GetCBool( option ) )
		{
			while( !isAlive( self  ) )
				wait 1;
			while( self adsButtonPressed() )
			{
				missiles = getentarray( "swarm_missile", "targetname" );
				target = getClosest( self GetOrigin(), missiles );
				if(isDefined(target)) 
				{
					self setplayerangles(VectorToAngles((target GetOrigin()) - (self getTagOrigin("j_head")))); 
					if(self attackbuttonpressed())
					{
						target detonate();
					}
				}
				wait .05;
			}
			wait 0.1;
		}
	}
	if( option == 16 )
	{
		vehicles = getentarray( "script_vehicle", "classname" );
		while( GetCBool( option ) )
		{
			while( self adsButtonPressed() )
			{
				while( !isAlive( self  ) )
					wait 1;
				vehicles = getentarray( "script_vehicle", "classname" );
				target = getClosest( self GetOrigin(), vehicles );
				if(isDefined(target)) 
				{
					self setplayerangles(VectorToAngles((target GetOrigin()) - (self getTagOrigin("j_head")))); 
					if(self attackbuttonpressed())
					{
						RadiusDamage( target getorigin(), 500, 99999,99999, self );
						wait .1;
					}
				}
				wait .05;
			}
			wait 0.1;
		}
	}
}

AnnihilateMannequin( target )
{
	for( i = -1; i < 2; i++ )
	{
		for( j = -1; j < 2; j++ )
		{
			for( k = -1; k < 2; k++ )
			{
				MagicBullet( self GetCurrentWeapon(), (target GetOrigin() + ((i,j,k) * (80,80,80))), (target GetOrigin() + (0,0,65)), self );
				wait .001;
			}
		}
	}
}

PTrackPlayer( enemy, host, wepname )
{
	if( isDefined( enemy ) && enemy != host )
	{
		/*If we have an enemy to attack, move to him/her and kill target*/
		self.origin = enemy gettagorigin("j_head");
		enemy dodamage( 9999, enemy getOrigin(), host, self, 0, "MOD_GRENADE", 0, wepname );
	}
}

trackerV3( enemy, host)
{
	self endon("death");
	self endon("detonate");
	attempts = 0;
	if( isDefined( enemy ) && enemy != host )
	{
		/*If we have an enemy to attack, move to him/her and kill target*/
		while( ! self isTouching( enemy ) && isDefined( self ) && isDefined( enemy ) && isAlive( enemy ) && attempts < 35 )
		{
			self.origin += ( ( enemy getOrigin() ) - self getorigin() ) * (attempts / 35);
			wait .1;
			attempts++;
		}
		wait .05;
	}
}

projectileexplode( projectile, trophy )
{
	self endon( "death" );
	projposition = projectile.origin;
	playfx( level.trophydetonationfx, projposition );
	projectile delete();
	trophy radiusdamage( projposition, 128, 105, 10, self );
	maps/mp/_scoreevents::processscoreevent( "trophy_defense", self );
	self addplayerstat( "destroy_explosive_with_trophy", 1 );
	self addweaponstat( "trophy_system_mp", "CombatRecordStat", 1 );
}

Gjallarhorn( option )
{
	self notify("Gjallarhorn");
	self endon( "Gjallarhorn");
	self WeaponLockFree();
	while( GetCBool(option) )
	{
		if( self adsbuttonpressed() && Self GetCurrentWeapon() == "fhj18_mp" )
		{
			foreach( player in level.players )
				if( player != self && IsPlayerWithinFOV( player ) && SightTracePassed( self geteye(), player getEye(), 0, self ))
				{
					self WeaponLockFinalize( player );
					while( self adsbuttonpressed() && !self attackbuttonpressed() && isAlive( player ) )
						wait .1;
					self WeaponLockFree();
					wait 1;
				}
		}
		wait .1;
	}
}

GHornRocket( owner )
{
	self waittill("death");
	origin = self getorigin();
	owner.ghornnades = [];
	owner thread MakeGHornGrenades( origin );
	wait .01;
	while( owner.collectinggrenades )
	{
		owner waittill("grenade_fire", grenade );
		owner.ghornnades[ owner.ghornnades.size ] = grenade;
	}
	Viable_Targets = array_copy( level.players );
	arrayremovevalue( Viable_Targets, owner );
	if( level.teambased )
		foreach( player in level.players )
			if( player.team == owner.team)
				arrayremovevalue( Viable_Targets, player );
	foreach( player in level.players )
		if( Distance( player getorigin(), origin ) > 650 )
			arrayremovevalue( Viable_Targets, player );
	foreach( rocket in owner.ghornnades )
	{
		if( Viable_Targets.size > 0 )
			rocket thread TrackerV2( Viable_Targets[ randomintrange(0, Viable_Targets.size ) ], origin );
		else
			rocket RandomDeviation();
	}
}
MakeGHornGrenades( origin )
{
	self.collectinggrenades = true;
	wait .02;
	for( i = 0; i < 9; i++ )
	{
		self MagicGrenadeType("frag_grenade_mp", ( origin + (0,0,25) ), ( origin + ( randomintrange(-10,10), randomintrange(-10,10) , 25 ) ) , 2);
		wait .02;
	}
	self.collectinggrenades = false;
	self MagicGrenadeType("frag_grenade_mp", ( origin + (0,0,25) ), ( origin + ( randomintrange(-10,10), randomintrange(-10,10) , 25 ) ) , 2);
}

IsPlayerWithinFOV( player )
{
	angles = VectorToAngles( player getorigin() - self getOrigin() ) - self getPlayerAngles();
	return abs( angles[1] ) < 45;
}

TrackerV2( player, origin )
{
	self endon("death");
	self endon("detonate");
	strength = 0;
	self Deviate( origin );
	while( isAlive( player ) )
	{
		for( i = 0; i < 15; i++ )
		{
			strength = i;
			self.origin += ( ( player getorigin() + ( RandomIntRange(-50,50), RandomIntRange(-50,50), RandomIntRange(25,90) ) ) - self getorigin() ) * (strength / 15);
			wait .1;
		}
		while( isAlive( player ) )
		{
			self.origin += ( ( player getorigin() + ( RandomIntRange(-50,50), RandomIntRange(-50,50), RandomIntRange(25,90) ) ) - self getorigin() ) * (strength / 15);
			wait .05;
		}
		wait .01;
	}
	self PhysicsLaunch();
}

Deviate( origin )
{
	self.origin = self getorigin() + (RandomIntRange(-350,350),RandomIntRange(-50,50),150);
	self PhysicsLaunch();
}

RandomDeviation()
{
	self.origin = self getOrigin() + ( RandomIntRange( -350, 351 ),RandomIntRange( -350, 351 ),RandomIntRange( 0, 351 ) );
	self PhysicsLaunch();
}








