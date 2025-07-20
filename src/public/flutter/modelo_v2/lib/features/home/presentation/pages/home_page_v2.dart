import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _container1Key = GlobalKey();
  final GlobalKey _container2Key = GlobalKey();

  // Variáveis para armazenar as dimensões do Container 1
  double _container1Width = 0.0;
  double _container1Height = 0.0;

  // Variáveis para armazenar as dimensões do Container 2
  double _container2Width = 0.0;
  double _container2Height = 0.0;
  // --- Fim: Variáveis de Estado ---

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getContainerDimensions(_container1Key, (width, height) {
        setState(() {
          _container1Width = width;
          _container1Height = height;
        });
      });
      _getContainerDimensions(_container2Key, (width, height) {
        setState(() {
          _container2Width = width;
          _container2Height = height;
        });
      });
    });
  }

  void _getContainerDimensions(
    GlobalKey key,
    Function(double, double) onDimensionsReady,
  ) {
    if (key.currentContext != null) {
      final RenderBox renderBox =
          key.currentContext!.findRenderObject() as RenderBox;
      final Size size = renderBox.size;
      onDimensionsReady(size.width, size.height);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home com Dimensões')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    key: _container1Key,
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
                          const Text(
                            'Container 1',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Largura: ${_container1Width.toStringAsFixed(0)} px',
                          ),
                          Text(
                            'Altura: ${_container1Height.toStringAsFixed(0)} px',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    key: _container2Key,
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
                          const Text(
                            'Container 2',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Largura: ${_container2Width.toStringAsFixed(0)} px',
                          ),
                          Text(
                            'Altura: ${_container2Height.toStringAsFixed(0)} px',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _getContainerDimensions(_container1Key, (width, height) {
                    setState(() {
                      _container1Width = width;
                      _container1Height = height;
                    });
                  });
                  _getContainerDimensions(_container2Key, (width, height) {
                    setState(() {
                      _container2Width = width;
                      _container2Height = height;
                    });
                  });
                },
                child: const Text('Recalcular Dimensões'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
