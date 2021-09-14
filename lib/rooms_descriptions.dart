import 'dart:math';

class RoomsDescriptions {
  List<String> roomsDescriptions = [
    'A gloomy dungeon, a bare brick wall, a collapsed ceiling, several doors leading in different directions.',
    'Apparently this is a former armory room. But everything has long been rusted and covered with dust.',
    'It looks like something was kept here, wooden shelves, sacks.',
    'Everything is in a spider web, it is dark and uncomfortable in here.',
    'Drip-drip-drip - the sound of falling drops is heard. this room is damp and disgusting.',
    'A prison cell with bare stone walls and thick prison bars.',
    'It is a comora with almost nothing left in it.',
    'Four walls and dry air, this room is a big house for rats.',
    'An ordinary room four meters by four with nothing special.',
    'This room is larger than usual, appearing to be a dining room.',
    'Broken bones are lying all around the floor. Someone was butchered here...',
    'A long corridor at the end of which you can see doors.',
    'It looks like a guard room, several beds and a broken cauldron in the corner.',
    'An ordinary room, bare walls and a stone underfoot.'
  ];

  String get() {
    return roomsDescriptions
        .removeAt(Random().nextInt(roomsDescriptions.length));
  }
}
