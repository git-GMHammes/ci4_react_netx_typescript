import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _HomePageState();
}

/* ALTURA & LARGURA */
class _HomePageState extends State<ContatoPage> {
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
  Widget buildContainer(String label, double width, double height) {
    return Expanded(
      child: Container(
        width: 100,
        height: 220,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _screenWidth > 412 ? Colors.greenAccent : Colors.white,
          border: Border.all(color: Colors.lightGreen),
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

  Widget buildContainerInfinity(String label) {
    return Container(
      width: double.infinity,
      height: 240,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(child: Text(label)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Contatos')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildContainerCollor('1', _screenWidth, _screenHeight),
                buildContainerCollor('2', _screenWidth, _screenHeight),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildContainer('1', _screenWidth, _screenHeight),
                buildContainer('2', _screenWidth, _screenHeight),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildContainerCollor('1', _screenWidth, _screenHeight),
                buildContainerCollor('2', _screenWidth, _screenHeight),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildContainer('1', _screenWidth, _screenHeight),
                buildContainer('2', _screenWidth, _screenHeight),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
