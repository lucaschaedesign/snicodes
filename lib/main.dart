import 'package:animations/widgets/animatedCheckbox.dart';
import 'package:animations/widgets/animatedStrikethrough.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: Center(child: AnimatedCheckBox()),
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animated Strikethrough',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          AnimatedStrikeThrough(
            title: 'Read The Creative Act',
          ),
          AnimatedStrikeThrough(
            title: 'Manage newsletter subscriptions',
          ),
          AnimatedStrikeThrough(
            title: 'Create custom checklists',
          ),
          AnimatedStrikeThrough(
            title: 'Water the plants',
          ),
          AnimatedStrikeThrough(
            title: 'Run 5k in the morning',
          ),
          AnimatedStrikeThrough(
            title: 'Pick up the new iPhone',
          ),
        ],
      ),
    );
  }
}
