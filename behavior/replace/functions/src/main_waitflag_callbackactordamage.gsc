#include common_scripts\utility;

main()
{
    level thread initialize_actor_callback();
    printf("main_waitflag_callbackactordamage loaded");
}

initialize_actor_callback()
{
    flag_wait("initial_blackscreen_passed");
    level.originalcallbackactordamage = level.callbackactordamage;
    level.callbackactordamage = ::actordamage;
}

actordamage (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index) // this get called for me at least
{
    printf("main_waitflag_callbackactordamage actordamage() called");

    damage = [[level.originalcallbackactordamage]] (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index);

    // do stuff here, if the first function print doesn't appear then it doesn't work for you

    return damage ;
}