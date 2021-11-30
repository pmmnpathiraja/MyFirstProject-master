import 'package:flutter/material.dart';

class ManageFeedbacks extends StatefulWidget {
  const ManageFeedbacks({Key key}) : super(key: key);

  @override
  _ManageFeedbacksState createState() => _ManageFeedbacksState();
}

class _ManageFeedbacksState extends State<ManageFeedbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Customer Feedbacks"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Column()]),
          ],
        ),
      ),
    );
  }
}
