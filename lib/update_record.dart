import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateRecord extends StatefulWidget {

  const UpdateRecord({Key? key, required this.studentKey}) : super(key: key);

  final String studentKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  String player1Name = "Player 1";
  String player2Name = "Player 2";

  bool isSwitched = false;

  final  player1NameController = TextEditingController();
  final  player2NameController = TextEditingController();
  final  player1pointController = TextEditingController();
  final  player2pointController =TextEditingController();
  final  player1setscoreController = TextEditingController();
  final  player2setscoreController =TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Matches');
    getStudentData();

  }


  void getStudentData() async {
    DataSnapshot snapshot = await dbRef.child(widget.studentKey).get();

    Map student = snapshot.value as Map;
    player1NameController.text = student['player1'];
    player2NameController.text = student['player2'];
    player1pointController.text = student['player1point'];
    player2pointController.text = student['player2point'];
    player1setscoreController.text = student['player1setscore'];
    player2setscoreController.text = student['player2setscore'];
    setState(() {
      playerName();
      _counter1 = int.parse(player1pointController.text);
      _counter2 = int.parse(player2pointController.text);
      subCounter1 = int.parse(player1setscoreController.text);
      subCounter2 = int.parse(player2setscoreController.text);
    });

  }
  int _counter1 = 0;
  int _counter2 = 0;
  int subCounter1 = 0;
  int subCounter2 = 0;

  Color _counter1Color = Colors.white; // Default color
  Color _counter2Color = Colors.white; // Default color


  void changePlayerName(int playerNumber, String newName) {
    setState(() {
      if (playerNumber == 1) {
        player1Name = newName;
      } else if (playerNumber == 2) {
        player2Name = newName;
      }
    });
  }

  void playerName(){
    setState(() {
      player1Name = player1NameController.text;
      player2Name = player2NameController.text;
    });
  }

  void _incrementCounter1() {
    setState(() {
      _counter1++;
      _checkWinner();
    });
  }

  void _incrementCounter2() {
    setState(() {
      _counter2++;
      _checkWinner();
    });
  }

  void _decrementCounter1() {
    setState(() {
      if (_counter1 > 0) {
        _counter1--;
        _checkWinner();
      }
    });
  }

  void _decrementCounter2() {
    setState(() {
      if (_counter2 > 0) {
        _counter2--;
        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    if (_counter1 > 20 && (_counter1 - _counter2) >= 2) {
      _counter1Color = Colors.green;
      _counter2Color = Colors.white;
      counter1alert();
    }
    else
    if (_counter2 > 20 && (_counter2 - _counter1) >= 2) {
      _counter2Color = Colors.green;
      _counter1Color = Colors.white;
      counter2alert();
    }
    else if (_counter1 == _counter2) {
      _counter1Color = Colors.white;
      _counter2Color = Colors.white;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text('Flutter Firebase'),
          actions: <Widget>[
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  // Add your switch logic here
                });
              },
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 37.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(height: 13),
                    Padding(
                      padding: const EdgeInsets.only(right:5.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                onWillPop: () async {
                                  // Return false to prevent closing the dialog when tapping outside
                                  return false;
                                },
                                child: AlertDialog(
                                  title: Text('Change Player 1 Name'),
                                  content: TextField(
                                    onChanged: (text) {
                                      // Update the new name as it's being typed
                                      player1Name = text;
                                    },
                                    controller: player1NameController,
                                    decoration: InputDecoration(labelText: 'New Name'),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Save the new name
                                        changePlayerName(1, player1Name);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: 165,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '$player1Name',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: GestureDetector(

                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                onWillPop: () async {
                                  // Return false to prevent closing the dialog when tapping outside
                                  return false;
                                },
                                child: AlertDialog(
                                  title: Text('Change Player 2 Name'),
                                  content: TextField(
                                    onChanged: (text) {
                                      // Update the new name as it's being typed
                                      player2Name = text;
                                    },
                                    controller: player2NameController,
                                    decoration: InputDecoration(labelText: 'New Name'),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Save the new name
                                        changePlayerName(2, player2Name);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: 165,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '$player2Name',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _incrementCounter1();
                        });

                        player1pointController.text = '$_counter1';

                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 165,
                            height: 275,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                  '$_counter1',
                                    style: TextStyle(
                                      color: _counter1Color, // Use the dynamic color here
                                      fontSize: 100,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _incrementCounter2();
                        });
                        player2pointController.text = '$_counter2';
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 165,
                            height: 275,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                 '$_counter2',
                                    style: TextStyle(
                                      color: _counter2Color, // Use the dynamic color here
                                      fontSize: 100,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 53),
                    child:GestureDetector(
                      onTap: () {
                        setState(() {
                          _decrementCounter1();
                        });
                        player1pointController.text = '$_counter1';
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded, // You can change this to any other icon
                        size: 50,
                        color: Colors.black, // Change the color as needed
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 53),
                    child:GestureDetector(
                      onTap: () {
                        setState(() {
                          _decrementCounter2();
                        });
                        player2pointController.text = '$_counter2';
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded, // You can change this to any other icon
                        size: 50,
                        color: Colors.black, // Change the color as needed
                      ),
                    ),
                  ),
                ],
              ),

              const Divider( // Add a Divider between the two counters
                color: Colors.black, // Customize the color of the divider
                thickness: 3, // Customize the thickness of the divider
                height: 20, // Customize the height of the divider
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(height: 13),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '$subCounter1',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '$subCounter2',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 13),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                  _counter2 = 0;_counter1 = 0;subCounter1 = 0;subCounter2 = 0;
                  });
                  player1pointController.text = '';
                  player2pointController.text = '';
                  player1setscoreController.text = '';
                  player2setscoreController.text = '';
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black), // Set the background color to black
                  minimumSize: MaterialStateProperty.all(Size(150, 50)),    // Set the button's size
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),   // Set the border radius
                  )),
                ),
                child: const Text('Reset',style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 19,         // Font size
                  fontWeight: FontWeight.bold, // Font weight
                ),),
              ),
              SizedBox(height: 13),
              ElevatedButton(
                onPressed: () {

                  Map<String, dynamic> students = {
                    'player1': player1NameController.text,
                    'player2': player2NameController.text,
                    'player1point': player1pointController.text,
                    'player2point': player2pointController.text,
                    'player1setscore': player1setscoreController.text,
                    'player2setscore': player2setscoreController.text,
                  };

                  dbRef.child(widget.studentKey).update(students)
                      .then((value) => {
                    Navigator.pop(context)
                  });

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black), // Set the background color to black
                  minimumSize: MaterialStateProperty.all(Size(150, 50)),    // Set the button's size
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),   // Set the border radius
                  )),
                ),
                child: const Text('Update Match',style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 19,         // Font size
                  fontWeight: FontWeight.bold, // Font weight
                ),),
              ),

            ],
          ),
        ),
      ),
    );
  }
  void counter1alert(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              // Return false to prevent closing the dialog when tapping outside
              return false;
            },
            child: AlertDialog(

              content: Text('Do you want to end this game?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    setState(() {
                      _counter1--;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    setState(() {
                      _counter1 = 0;_counter2 = 0;subCounter1++;
                      _counter1Color = Colors.white; // Reset color to white
                    });
                    player1setscoreController.text = '$subCounter1';
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        );
      },
    );
  }
  void counter2alert(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              // Return false to prevent closing the dialog when tapping outside
              return false;
            },
            child: AlertDialog(

              content: Text('Do you want to end this game?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    setState(() {
                      _counter2--;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    setState(() {
                      _counter2 = 0;_counter1 = 0;subCounter2++;
                      _counter2Color = Colors.white; // Reset color to white
                    });
                    player2setscoreController.text = '$subCounter2';
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        );
      },
    );
  }
}