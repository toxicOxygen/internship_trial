import 'package:flutter/material.dart';
import './pages/home_page.dart';
import './pages/invitation_page.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internship Interview',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.pinkAccent
      ),
      routes: {
        HomePage.route:(ctx)=>HomePage(),
        InvitationPage.route:(ctx)=>InvitationPage()
      },
    );
  }
}
