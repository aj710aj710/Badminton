import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'update_record.dart';
import 'display.dart';
class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Matches');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Matches');

  Widget listItem({required Map student}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(studentKey: student['key'])));

      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        student['player1'],
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Point: ${student['player1point']}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Set Score: ${student['player1setscore']}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  Column(
                    children: [
                      Text(
                        student['player2'],
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Point: ${student['player2point']}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Set Score: ${student['player2setscore']}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      reference.child(student['key']).remove();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red[700],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetching data'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            Map student = snapshot.value as Map;
            student['key'] = snapshot.key;
            return listItem(student: student);
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  CounterApp()));
              },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
