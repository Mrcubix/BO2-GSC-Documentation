waittill_flag_exists( msg )
{
	while ( !flag_exists( msg ) )
	{
		waittillframeend;
		if ( flag_exists( msg ) )
		{
			return;
		}
		else
		{
			wait(0.05);
		}
	}
}

flag_wait( flagname )
{
	level waittill_flag_exists( flagname );
	while ( !level.flag[ flagname ] )
	{
		level waittill( flagname );
	}
}

flag_exists( flagname )
{
	if ( self == level )
	{
		if ( !isDefined( level.flag ) )
		{
			return 0;
		}
		if ( isDefined( level.flag[ flagname ] ) )
		{
			return 1;
		}
	}
	else
	{
		if ( !isDefined( self.ent_flag ) )
		{
			return 0;
		}
		if ( isDefined( self.ent_flag[ flagname ] ) )
		{
			return 1;
		}
	}
	return 0;
}