import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

/* ALTURA & LARGURA */
class _ProfilePageState extends State<ProfilePage> {
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

  /* COLEÇÃO DE WIDGET */
  Widget buildFullWidthContainer(String label, double width, double height) {
    return Container(
      width: double.infinity,
      height: 440,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 238, 234, 222),
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
    );
  }

  Widget buildContainerCollor(String label, double width, double height) {
    return Expanded(
      child: Container(
        width: 100,
        height: 220,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.lightGreen)),
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

  Widget buildContainerNoInfinity(String label, double width, double height) {
    return Container(
      width: 150,
      height: 230,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          Text('L: ${width.toStringAsFixed(0)} px'),
          Text('A: ${height.toStringAsFixed(0)} px'),
        ],
      ),
    );
  }

  Widget buildContainerInfinity(String label, double width, double height) {
    return Container(
      width: 200,
      height: 240,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          Text('L: ${width.toStringAsFixed(0)} px'),
          Text('A: ${height.toStringAsFixed(0)} px'),
        ],
      ),
    );
  }

  Widget buildExpandedContainer(String label, double width, double height) {
    return Expanded(
      child: Container(
        width: 275,
        height: 230,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_screenWidth > 412)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildContainerNoInfinity('1', _screenWidth, _screenHeight),
                buildExpandedContainer('2', _screenWidth, _screenHeight),
              ],
            ),

            if (_screenHeight > 750)
            Column(
              children: [
                buildContainerNoInfinity('1', _screenWidth, _screenHeight),
                buildFullWidthContainer('4', _screenWidth, _screenHeight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
