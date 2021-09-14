import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'room_encounters.dart';
import 'rooms_descriptions.dart';

void main() {
  runApp(Dungeon());
}

class Dungeon extends StatefulWidget {
  DungeonState createState() => DungeonState();
}

class DungeonState extends State<Dungeon> {
  @override
  bool isButtonDisabled = false;
  RoomsDescriptions roomsDescriptions = RoomsDescriptions();
  String textWayDescription = 'Which way you would like to go?';
  String textRoomDescription =
      'So, your journey through the dungeon begins! You have to walk through 10 doors and stay alive! Simple as that! There are four doors in front of you: North, South, East and West...';
  int lives = 6;
  int livesImpact = 0;
  int roomsToOpen = 10;
  int openedRooms = 0;
  int openedRoomsImpact = 0;
  String textEncounter = '';

  void journey() {
    RoomEncounterParameters roomEncounters = RoomEncounters();
    livesImpact = roomEncounters.livesImpact;
    openedRoomsImpact = roomEncounters.openedRoomsImpact;
    textEncounter = roomEncounters.textEncounter;
    textRoomDescription = roomsDescriptions.get();
    lives += livesImpact;
    openedRooms++;
    openedRooms += openedRoomsImpact;

    setState(
      () {
        if (openedRooms > 10) {
          openedRooms = 10;
        }
        if (lives > 6) {
          lives = 6;
          textEncounter =
              textEncounter + 'Unfortunately, you already have maximum health.';
        }
        if (lives < 1) {
          isButtonDisabled = true;
          lives = 0;
          textEncounter =
              textEncounter + ' YOU DIED... PRESS NEW GAME TO TRY AGAIN.';
        }
        if (openedRooms == 10 && lives > 1) {
          isButtonDisabled = true;
          textEncounter = textEncounter +
              ' CONGRATS! YOU HAVE MANAGED TO WALK THROUGH THE DUNGEON AND STAY ALIVE! PRESS NEW GAME TO TRY AGAIN.';
        }
      },
    );
  }

  newGame() {
    setState(() {
      isButtonDisabled = false;
      textWayDescription = 'Which way you would like to go?';
      textRoomDescription =
          'So, your journey through the dungeon begins! You have to walk through 10 doors and stay alive! Simple as that! There are four doors in front of you: North, South, East and West...';
      lives = 6;
      livesImpact = 0;
      roomsToOpen = 10;
      openedRooms = 0;
      openedRoomsImpact = 0;
      textEncounter = '';
      roomsDescriptions = RoomsDescriptions();
    });
  }

  Function buttonPress(String chosenWay) {
    isButtonDisabled ? null : journey();
    isButtonDisabled
        ? textWayDescription = 'This game is over'
        : textWayDescription = chosenWay;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              buildTopBar(),
              buildRoomText(context),
              buildLivesAndRooms(context),
              buildMovementButtons(context),
              buildMovementText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopBar() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/bg_icon.png'),
        ),
      ),
      child: Center(
        child: Text(
          'Dungeon',
          style: TextStyle(
            fontFamily: 'Bloody',
            color: Colors.red,
            fontSize: 130,
          ),
        ),
      ),
    );
  }

  Widget buildRoomText(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade600,
          width: 8,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Center(
        child: Text(
          '$textRoomDescription' + '$textEncounter',
          style: TextStyle(
            fontFamily: 'NewTegomin',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildLivesAndRooms(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30.0,
              ),
              Text(
                lives.toString() + '/6',
                style: TextStyle(
                  fontFamily: 'NewTegomin',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
            width: 150,
            child: FloatingActionButton(
              child: Text(
                'NEW GAME',
                style: TextStyle(
                  fontFamily: 'NewTegomin',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Colors.grey.shade600,
              onPressed: () {
                newGame();
              },
            ),
          ),
          Row(
            children: [
              Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icon_door.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                openedRooms.toString() + '/10',
                style: TextStyle(
                  fontFamily: 'NewTegomin',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMovementButtons(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 20.0,
          ),
          child: SizedBox(
            height: 80,
            width: 80,
            child: FloatingActionButton(
              child: Icon(
                Icons.arrow_upward_outlined,
                size: 35,
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Colors.grey.shade600,
              onPressed: () {
                setState(
                  () {
                    buttonPress('You went North.');
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.arrow_back_outlined,
                    size: 35,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  backgroundColor: Colors.grey.shade600,
                  onPressed: () {
                    setState(
                      () {
                        buttonPress('You went West.');
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icon_knight.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                width: 80,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    size: 35,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  backgroundColor: Colors.grey.shade600,
                  onPressed: () {
                    setState(
                      () {
                        buttonPress('You went East.');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            child: Icon(
              Icons.arrow_downward_outlined,
              size: 35,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Colors.grey.shade600,
            onPressed: () {
              setState(
                () {
                  buttonPress('You went South.');
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildMovementText(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          top: 30,
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade600,
              width: 8,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Center(
            child: Text(
              '$textWayDescription',
              style: TextStyle(
                fontFamily: 'NewTegomin',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
