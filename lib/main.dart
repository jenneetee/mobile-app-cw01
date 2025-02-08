import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink, // Change the primary theme color
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 236, 170, 170), // Change background color
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink, // Button color
            foregroundColor: Colors.white, // Button text color
          ),
        ),
      ),
      home: CounterAndImageToggleScreen(),
    );
  }
}

class CounterAndImageToggleScreen extends StatefulWidget {
  @override
  _CounterAndImageToggleScreenState createState() =>
      _CounterAndImageToggleScreenState();
}

class _CounterAndImageToggleScreenState
    extends State<CounterAndImageToggleScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isFirstImage = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    _controller.forward(from: 0.0);
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CW01 - Counter & Image Toggle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Times You\'ve Clicked: $_counter',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text("Increment"),
            ),
            SizedBox(height: 30),
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                _isFirstImage ? 'assets/img1.png' : 'assets/img2.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _toggleImage,
              child: Text("Toggle Image"),
            ),
          ],
        ),
      ),
    );
  }
}
