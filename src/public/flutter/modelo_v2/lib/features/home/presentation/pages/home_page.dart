import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* LARGURA E ALTURA*/
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

  Widget buildContainer(String label, double width, double height) {
    return Expanded(
      child: Container(
        width: 100,
        height: 220,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _screenWidth > 412 ? const Color.fromARGB(255, 194, 230, 194) : Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label),
              Text('L: ${width.toStringAsFixed(0)} px'),
              Text('A: ${height.toStringAsFixed(0)} px'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainerInfinity(String label, double width, double height) {
    return Container(
      width: double.infinity,
      height: 440,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            Text('L: ${width.toStringAsFixed(0)} px'),
            Text('A: ${height.toStringAsFixed(0)} px'),
          ],
        ),
      ),
    );
  }

  Widget buildContainerCollor(String label, double width, double height) {
    return Expanded(
      child: Container(
        width: 100,
        height: 220,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label),
              Text('L: ${width.toStringAsFixed(0)} px'),
              Text('A: ${height.toStringAsFixed(0)} px'),
            ],
          ),
        ),
      ),
    );
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
                if (_screenHeight > 900)
                  buildContainerCollor('1', _screenWidth, _screenHeight),

                if (_screenHeight > 900)
                  buildContainerCollor('2', _screenWidth, _screenHeight),

                if (_screenWidth > 412)
                  buildContainer('1', _screenWidth, _screenHeight),

                if (_screenWidth > 412)
                  buildContainer('2', _screenWidth, _screenHeight),

                if (_screenWidth > 412)
                  buildContainer('3', _screenWidth, _screenHeight),

                if (_screenWidth > 412)
                  buildContainer('4', _screenWidth, _screenHeight),
              ],
            ),
            if (_screenHeight > 900)
              buildContainerInfinity('3', _screenWidth, _screenHeight),
          ],
        ),
      ),
    );
  }
}
