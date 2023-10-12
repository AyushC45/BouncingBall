import 'package:flutter/material.dart';

void main() => runApp(ExplicitAnimationApp());

class ExplicitAnimationApp extends StatefulWidget {
  @override
  _ExplicitAnimationAppState createState() => _ExplicitAnimationAppState();
}

class _ExplicitAnimationAppState extends State<ExplicitAnimationApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ballPosition;

  double _ballSpeed = 1.0;
  Color _ballColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _ballPosition = Tween<double>(begin: -1.5, end: 0.5).animate(_controller);
  }

  void startBouncing() {
    setState(() {
      _controller.forward();
    });
  }

  void pauseBouncing() {
    setState(() {
      _controller.stop();
    });
  }

  void updateAnimationSpeed(double value) {
    _ballSpeed = value;
    _controller.duration = Duration(seconds: value.toInt());
  }

  void changeBallColor(Color color) {
    setState(() {
      _ballColor = color;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ball Bouncing App'),
          backgroundColor: Colors.grey.shade700,
        ),
        backgroundColor: Colors.grey.shade300,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Change ball color",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => changeBallColor(Colors.red),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeBallColor(Colors.deepOrangeAccent),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeBallColor(Colors.yellow),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeBallColor(Colors.blue),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeBallColor(Colors.black),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: Align(
                        alignment: Alignment(0, 0.5 + _ballPosition.value),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _ballColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: startBouncing,
                    child: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: pauseBouncing,
                    child: const Text('Stop'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
