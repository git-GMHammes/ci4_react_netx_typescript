import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Import necessário para SchedulerBinding

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey _container1Key = GlobalKey();
  final GlobalKey _container2Key = GlobalKey();

  double _container1Width = 0.0;
  double _container1Height = 0.0;

  double _container2Width = 0.0;
  double _container2Height = 0.0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _updateContainerDimensions();
    });
  }

  void _updateContainerDimensions() {
    if (_container1Key.currentContext != null) {
      final RenderBox renderBox1 =
          _container1Key.currentContext!.findRenderObject() as RenderBox;
      final Size size1 = renderBox1.size;
      setState(() {
        _container1Width = size1.width;
        _container1Height = size1.height;
      });
    }
    
    if (_container2Key.currentContext != null) {
      final RenderBox renderBox2 =
          _container2Key.currentContext!.findRenderObject() as RenderBox;
      final Size size2 = renderBox2.size;
      setState(() {
        _container2Width = size2.width;
        _container2Height = size2.height;
      });
    }
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
                    key:
                        _container1Key,
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
                          Text(
                            'L: ${_container1Width.toStringAsFixed(0)}',
                          ),
                          Text(
                            'A: ${_container1Height.toStringAsFixed(0)}',
                          ), // Exibe a altura
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    key:
                        _container2Key,
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
                          Text(
                            'L: ${_container2Width.toStringAsFixed(0)}',
                          ),
                          Text(
                            'A: ${_container2Height.toStringAsFixed(0)}',
                          ),
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
