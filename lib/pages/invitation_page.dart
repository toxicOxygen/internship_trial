import 'package:flutter/material.dart';

class InvitationPage extends StatelessWidget {
  //a route name to help navigate to this screen
  static const route = "/invitation-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),

      body: Center(
        child: Text(
          'Invitation page',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
