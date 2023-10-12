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
  bool _sliderStatus = true;

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
      _sliderStatus = false;
    });
  }

  void pauseBouncing() {
    setState(() {
      _controller.stop();
      _sliderStatus = true;
    });
  }

  void updateAnimationSpeed(double value) {
    _ballSpeed = value;
    _controller.duration = Duration(seconds: value.toInt());
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
          title: const Text('Explicit Animation Demo'),
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
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _ballColor = Colors.pink;
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _ballColor = Colors.lightBlue.shade400;
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          shape: BoxShape.circle,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _ballColor = Colors.amber;
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _ballColor = Colors.green.shade400;
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _ballColor = Colors.red;
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        )),
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
                    decoration:
                    BoxDecoration(border: Border.all(color: _ballColor)),
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
                        backgroundColor: Colors.blueGrey),
                  ),
                  ElevatedButton(
                    onPressed: pauseBouncing,
                    child: const Text('Stop'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ball Speed: ${_ballSpeed.toInt()}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Slider(
                value: _ballSpeed,
                onChanged: !_sliderStatus
                    ? null
                    : (value) {
                  setState(() {
                    _ballSpeed = value;
                  });
                  updateAnimationSpeed(value);
                },
                min: 1.0,
                max: 10.0,
                activeColor: Colors.grey,
                inactiveColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
