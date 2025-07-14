import 'package:flutter/material.dart';

class ContatoPage extends StatelessWidget {
  const ContatoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Center(child: Text('1')),
              ),
              Container(
                width: 275,
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Center(child: Text('2')),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Center(child: Text('1')),
              ),
              Container(
                width: 275,
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Center(child: Text('2')),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Center(child: Text('1')),
              ),
              Container(
                width: 275,
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Center(child: Text('2')),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Center(child: Text('1')),
              ),
              Container(
                width: 275,
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Center(child: Text('2')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
