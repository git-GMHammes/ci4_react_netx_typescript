import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateScreenDimensions();
  }

  void _updateScreenDimensions() {
    setState(() {
      _screenWidth = MediaQuery.of(context).size.width;
      _screenHeight = MediaQuery.of(context).size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    height: 220,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          _screenWidth > 412
                              ? Colors.greenAccent
                              : Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('1'),
                          Text('L: ${_screenWidth.toStringAsFixed(0)} px'),
                          Text('A: ${_screenHeight.toStringAsFixed(0)} px'),
                        ],
                      ),
                    ),
                  ),
                ),

                if (_screenWidth > 412)
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 220,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('1'),
                            Text('L: ${_screenWidth.toStringAsFixed(0)} px'),
                            Text('A: ${_screenHeight.toStringAsFixed(0)} px'),
                          ],
                        ),
                      ),
                    ),
                  ),

                if (_screenWidth > 412)
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 220,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('1'),
                            Text('L: ${_screenWidth.toStringAsFixed(0)} px'),
                            Text('A: ${_screenHeight.toStringAsFixed(0)} px'),
                          ],
                        ),
                      ),
                    ),
                  ),

                Expanded(
                  child: Container(
                    width: 100,
                    height: 220,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('2'),
                          Text('L: ${_screenWidth.toStringAsFixed(0)} px'),
                          Text('A: ${_screenHeight.toStringAsFixed(0)} px'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
