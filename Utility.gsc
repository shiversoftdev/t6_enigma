getName()
{
	nT=getSubStr(self.name,0,self.name.size);
	for(i=0;i<nT.size;i++)
	{
		if(nT[i]=="]")
			break;
	}
	if(nT.size!=i)
		nT=getSubStr(nT,i+1,nT.size);
	return nT;
}

getPlayerFromName( name )
{
	foreach(player in level.players)
	{
		if(player GetName() == name)
		return player;
	}
	return undefined;
}

get_base_name( weaponname )
{
	split = strtok( weaponname, "_" );
	if( split[0] == "knife" )
	{
		if( split[1] == "_mp" )
			return weaponname;
		return split[0] + "_" + split[1] + "_mp";
	}
	if ( split.size > 1 )
	{
		return split[ 0 ] + "_mp";
	}
	return weaponname;
}

get_attachments( weaponname )
{
	split = strtok( weaponname, "_" );
	if( split.size < 3 )
		return "NONE";
	if( split[0] == "knife" )
		return "NONE";
	value = "";
	for( i = 1; i < (split.size - 2); i++ )
		value += split[i] + "_";
	value += split[ split.size - 2 ];
	return value;
}

nuked_mannequin_filter( destructibles )
{
	mannequins = [];
	i = 0;
	while ( i < destructibles.size )
	{
		destructible = destructibles[ i ];
		if ( issubstr( destructible.destructibledef, "male" ) )
		{
			mannequins[ mannequins.size ] = destructible;
		}
		i++;
	}
	return mannequins;
}
