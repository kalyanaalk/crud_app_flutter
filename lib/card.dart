import 'package:flutter/material.dart';
import 'data.dart';

class DataCard extends StatelessWidget {
  final Data data;
  final VoidCallback delete;
  final VoidCallback edit;
  DataCard({required this.data, required this.delete, required this.edit});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Height: ${data.height.toStringAsFixed(1)} cm',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.0),
            Text(
              'Weight: ${data.weight.toStringAsFixed(1)} kg',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: delete,
                  label: Text('Delete', style: TextStyle(color: Colors.red)),
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
                TextButton.icon(
                  onPressed: edit,
                  label: Text('Edit', style: TextStyle(color: Colors.blue)),
                  icon: Icon(Icons.edit, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}