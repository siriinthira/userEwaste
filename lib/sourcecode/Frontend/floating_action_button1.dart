import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Floating Action Button"),
      ),
      body: ListView(
        children: [
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
          Text('data'),
          SizedBox(height: 200),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Approve'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
