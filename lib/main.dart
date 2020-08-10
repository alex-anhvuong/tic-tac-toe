import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/checker_brain_provider.dart';
import 'package:tic_tac_toe/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckerBrainProvider(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
