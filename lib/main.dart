import 'package:animations/widgets/animatedStrikethrough.dart';
import 'package:flutter/material.dart';
import 'widgets/checklist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Checklist Widget'),
      ),
      body: ListView(
        children: <Widget>[
          AnimatedCheckboxListItem(
            color: Colors.blue,
            title: 'Task 1',
          ),
          AnimatedCheckboxListItem(
            color: Colors.green,
            title: 'Task 2',
          ),
          AnimatedCheckboxListItem(
            color: Colors.red,
            title: 'Task 3',
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isStrikedThrough = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ); // Use Curves.easeInOut here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Strikethrough Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  isStrikedThrough = !isStrikedThrough;
                  if (isStrikedThrough) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                });
              },
              child: CustomPaint(
                painter: StrikethroughPainter(
                    _animation), // Pass _animation instead of _controller
                child: const Text(
                  'Sample Text',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
