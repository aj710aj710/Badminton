import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';




class CounterApp1 extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp1> {
  final databaseReference = FirebaseDatabase.instance.reference();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter: $counter'),
            TextButton(
              onPressed: () {
                // Increment the counter
                setState(() {
                  counter++;
                });

                // Update the counter in the database
                databaseReference.child('counter').set(counter);
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
