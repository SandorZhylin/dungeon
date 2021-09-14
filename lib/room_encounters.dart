import 'dart:math';

class RoomEncounterParameters {
  String textEncounter;
  int livesImpact;
  int openedRoomsImpact;
  RoomEncounterParameters(
      this.textEncounter, this.livesImpact, this.openedRoomsImpact);
}

RoomEncounterParameters RoomEncounters() {
  List<RoomEncounterParameters> encounterType = [
    RoomEncounterParameters('There is nothing useful in this room.', 0, 0),
    RoomEncounterParameters(
        'There is a small fountain with healing water in the room. (Restores 1 health).',
        1,
        0),
    RoomEncounterParameters(
        'There is a creepy skeleton in the room. Suddenly it stretches his arm with a rusty sword to you, leaving a deep cut in your chest, right before you bash it with yours sword to pieces (Deals 1 damage to you).',
        -1,
        0),
    RoomEncounterParameters(
        'Suddenly a large fat zombie appears from the dark corner! It hits you with great force, sending you flying across whole room (Deals 2 damage to you).',
        -2,
        0),
    RoomEncounterParameters(
        'There is a lone adventurer in the room, who is stuck in here just like you. He has some experience and is ready to show you how to pass the next room unharmed (+ 1 successfully passed room).',
        0,
        1),
  ];

  return encounterType[Random().nextInt(5)];
}
