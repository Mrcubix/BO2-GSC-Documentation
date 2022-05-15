# Replacing functions

## Premise

Replacing `level.callbackactordamage` seem to behave differently depending on the machine the script is ran on.

Therefore, here are different ways people use to replace a callback such as `callbackactordamage` and their effects.

## Intro

We will take a look at 6 differents scripts.

These 6 scripts have one goal: replacing `callbackactordamage` with another function.

Here, our custom callback named `actordamage` do the following:

- Print the filename,
- Call the original damage callback function,
- return the amount of damage inflicted.

Here is the process on how i'm going to test these scripts:

- Place a single script in `t6/scripts/zm`,
- Start a custom game of zombie on Tranzit or use `map_restart`,
- Kill the 4 zombies that appear in the lobby,
- Check the output given by the console since load,

## Results

### main_callbackdamageactor.gsc

```gsc
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
```

And here is the output of the console since load:

![main_callbackactordamage](/behavior/replace/functions/img/main_callbackactordamage.png)

As you can see, nothing is printed, which mean `actordamage()` was never called.
This apparently can differ between people as some say it does work.

### init_callbackdamageactor.gsc

```gsc
init()
{
    level.originalcallbackactordamage = level.callbackactordamage;
    level.callbackactordamage = ::actordamage;
    printf("init_callbackactordamage loaded");
}

actordamage (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index) 
{
    printf("init_callbackactordamage actordamage() called");
    
    damage = [[level.originalcallbackactordamage]] (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index);

    // do stuff here, if the first function print doesn't appear then it doesn't work for you

    return damage ;
}
```

And here is the output of the console since load:

![init_callbackactordamage](/behavior/replace/functions/img/init_callbackactordamage.png)

As you can see, nothing is printed, which mean `actordamage()` was never called.
This apparently can differ between people as some say it does work.

## main_replaceFunc

```gsc
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
```

And here is the output of the console since load:

![main_replaceFunc](/behavior/replace/functions/img/main_replaceFunc.png)

As you can see, nothing is printed, which mean `actordamage()` was never called.
This apparently wouldn't work as the original callback is said to be set later on in the execution cycle.

### init_replaceFunc

```gsc
main()
{
    level.originalcallbackactordamage = level.callbackactordamage;
    replaceFunc(level.callbackactordamage, ::actordamage);
    printf("init_replaceFunc loaded");
}

actordamage (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index) // this get called for me at least
{
    printf("init_replaceFunc actordamage() called");

    damage = [[level.originalcallbackactordamage]] (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index);

    // do stuff here, if the first function print doesn't appear then it doesn't work for you

    return damage ;
}
```

And here is the output of the console since load:

![init_replaceFunc](/behavior/replace/functions/img/init_replaceFunc.png)

As you can see, nothing is printed, which mean `actordamage()` was never called.
This is a surprising outcome as this would work on my Windows 10 machine,
however, it doesn't seem to work on my Windows 8.1 machine.

### main_waitflag_callbackactoradamage

```gsc
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
```

And here is the output of the console since load:

![main_waitflag_callbackactoradamage](/behavior/replace/functions/img/main_waitflag_callbackactordamage.png)

As you can see, nothing is printed, which mean `actordamage()` is called 4 times, since 4 zombies have been damaged.
This work consistantly on my windows 8.1 machine.
This is also consisdered one of the recommended approach to replacing function.

### init_wait_flag_callbackactoradamage

```gsc
#include common_scripts\utility;

init()
{
    level thread initialize_actor_callback();
    printf("init_waitflag_callbackactordamage loaded");
}

initialize_actor_callback()
{
    flag_wait("initial_blackscreen_passed");
    level.originalcallbackactordamage = level.callbackactordamage;
    level.callbackactordamage = ::actordamage;
}

actordamage (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index) // this get called for me at least
{
    printf("init_waitflag_callbackactordamage actordamage() called");

    damage = [[level.originalcallbackactordamage]] (inflictor, attacker, damage, flags, mod, weapon, point, dir, hitloc, offset, index);

    // do stuff here, if the first function print doesn't appear then it doesn't work for you

    return damage ;
}
```

And here is the output of the console since load:

![init_waitflag_callbackactordamage](/behavior/replace/functions/img/init_waitflag_callbackactordamage.png)

As you can see, nothing is printed, which mean `actordamage()` is called 4 times, since 4 zombies have been damaged.
This work consistantly on my windows 8.1 machine.
This is also consisdered one of the recommended approach to replacing function.

## Conclusion

The results given by simple assignement apparently depend between users.
The results given by replaceFunc may depend on the machine the script is run on.
The results given by waiting for a flag are consistant and should be the recommended way of replacing functions.