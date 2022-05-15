main()
{
    level.originalcallbackactordamage = level.callbackactordamage;
    level.callbackactordamage = ::actordamage;
    printf("main_callbackactordamage loaded");
}

actordamage (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index) // never get called for some people
{
    printf("main_callbackactordamage actordamage() called");

    damage = [[level.originalcallbackactordamage]] (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index);

    // do stuff here, if the first function print doesn't appear then it doesn't work for you

    return damage ;
}