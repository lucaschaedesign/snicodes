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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isStrikedThrough = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 170),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 180),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    );

    _shakeAnimation = CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeOut,
    );
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
                    Future.delayed(Duration(milliseconds: 170), () {
                      _shakeController.forward();
                    });
                    Future.delayed(Duration(milliseconds: 350), () {
                      _shakeController.reverse();
                    });
                  } else {
                    _controller.reverse();
                    _shakeController.forward();
                    _shakeController.reverse();
                  }

                  // _shakeController.repeat(reverse: true);
                });
              },
              child: AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_shakeAnimation.value * 8, 0),
                    child: CustomPaint(
                      painter: StrikethroughPainter(_animation),
                      child: const Text(
                        'Sample Text',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  );
                },
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
    _shakeController.dispose();
    super.dispose();
  }
}

class StrikethroughPainter extends CustomPainter {
  final Animation<double> animation; // Update the parameter type here

  StrikethroughPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double strikeThroughWidth = size.width * animation.value;
    canvas.drawLine(
      Offset(0, size.height / 1.8),
      Offset(strikeThroughWidth, size.height / 1.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
