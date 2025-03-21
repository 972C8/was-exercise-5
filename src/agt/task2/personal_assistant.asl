// personal assistant agent 

/* Task 2 Start of your solution */

/*
3a) Update the agent program so that, when initialized, the assistant holds beliefs about how the
user prefers to be woken up
*/
artificial_light(2).
natural_light(1).
mattress_vibration(0).

/*
3b) Additionally, write an inference rule that enables the assistant to infer what is the
best_option(Option) for waking up the user based on the available rankings
*/
best_option(Number) :- Number = 0.

/*
1) Write plans so that the assistant prints relevant messages when a belief about the states of
devices (lights, blinds, mattress) or the owner (reported by the wristband) is added or deleted.
*/
+lights(State)
    :   true
    <-
        .print("Lights are ", State);
    .

-lights(State)
    :   true
    <-
        .print("Lights are ", State);
    .

+blinds(State)
    :   true
    <-
        .print("Blinds are ", State);
    .

-blinds(State)
    :   true
    <-
        .print("Blinds are ", State);
    .

+mattress(State)
    :   true
    <-
        .print("Mattress is ", State);
    .

-mattress(State)
    :   true
    <-
        .print("Mattress is ", State);
    .

+wristband(State)
    :   true
    <-
        .print("Wristband is ", State);
    .

-wristband(State)
    :   true
    <-
        .print("Wristband is ", State);
    .

/*
2) Write plans so that the assistant reacts to the addition of the belief upcoming_event("now").
If the user is awake, the assistant should print “Enjoy your event”. If the user is asleep, the
assistant should print “Starting wake-up routine”.
*/
+upcoming_event("now")
    :   owner_state("awake")
    <-
        .print("Enjoy your event.");
    .
   
+upcoming_event("now")
    :   owner_state("asleep")
    <-
        .print("Starting wake-up routine.");
        !wake_up;
    .


/*
4) Write plans that enable the assistant to achieve the goal of waking up the user. The agent
should wake up the user based on the current best_option
*/
+!wake_up
    :   owner_state("asleep") & mattress_vibration(Number) & best_option(Number)
    <-
        .print("Wake up with mattress vibration.");
        setVibrationsMode;
        // Update beliefs with new order of best options (mattress vibration moved to end)
        -+mattress_vibration(2);
        -+artificial_light(1);
        -+natural_light(0);
        !wake_up;
    .

+!wake_up : owner_state("asleep") & natural_light(Number) & best_option(Number) <-
   .print("Wake up with natural light.");
   raiseBlinds;
    // Update beliefs with new order of best options (natural light moved to end)
   -+natural_light(2);
   -+mattress_vibration(1);
   -+artificial_light(0);
   !wake_up.

+!wake_up : owner_state("asleep") & artificial_light(Number) & best_option(Number) <-
   .print("Wake up with artificial light.");
   turnOnLights;
    // Update beliefs with new order of best options (artificial light moved to end)
   -+artificial_light(2);
   -+natural_light(1);
   -+mattress_vibration(0);
   !wake_up.

+!wake_up : true <-
   .print("Design objective has been achieved.").
/* Task 2 End of your solution */

/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }