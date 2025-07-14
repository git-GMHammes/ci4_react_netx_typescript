import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(child: Text('1')),
              ),
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(child: Text('2')),
              ),
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(child: Text('3')),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 80,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: const Center(child: Text('4')),
          ),
          Container(
            width: double.infinity,
            height: 240,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: const Center(child: Text('5')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 185,
                height: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(child: Text('6')),
              ),
              Container(
                width: 185,
                height: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(child: Text('7')),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 120,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: const Center(child: Text('8')),
          ),
        ],
      ),
    );
  }
}
