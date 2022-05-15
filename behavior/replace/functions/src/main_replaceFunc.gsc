main()
{
    level.originalcallbackactordamage = level.callbackactordamage;
    replaceFunc(level.callbackactordamage, ::actordamage);
    printf("main_replaceFunc loaded");
}

actordamage (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index) // this get called for me at least
{
    printf("main_replaceFunc actordamage() called");

    damage = [[level.originalcallbackactordamage]] (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index);

    // do stuff here, if the first function print doesn't appear then it doesn't work for you

    return damage ;
}