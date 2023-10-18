import 'package:flutter/material.dart';



class CounterApp1 extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp1> {
  int counter = 0;
  int limit = 0;

  void incrementCounter() {
    if (counter < limit) {
      setState(() {
        counter++;
      });
    }
  }

  void setCounterLimit(String text) {
    setState(() {
      limit = int.tryParse(text) ?? 0;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

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
            Text(
              'Counter Value: $counter',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: setCounterLimit,
                decoration: InputDecoration(
                  labelText: 'Set Counter Limit',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: incrementCounter,
                  child: Text('Increment'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: resetCounter,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
