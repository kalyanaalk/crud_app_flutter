import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'data.dart';

void showModal(BuildContext context, {Data? data, required Function(Data) onSave}) {
  double selectedHeight = data?.height ?? 165;
  double selectedWeight = data?.weight ?? 60;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateModal) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Adjust Height & Weight", style: TextStyle(color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Height: ${selectedHeight.toInt()} cm", style: TextStyle(color: Colors.purple, fontSize: 18)),
                        Container(
                          height: 200,
                          width: 120,
                          child: CupertinoPicker(
                            itemExtent: 30,
                            scrollController: FixedExtentScrollController(initialItem: selectedHeight.toInt() - 100),
                            onSelectedItemChanged: (index) {
                              setStateModal(() => selectedHeight = (index + 100).toDouble());
                            },
                            children: List.generate(121, (index) => Text("${index + 100} cm")),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Weight: ${selectedWeight.toInt()} kg", style: TextStyle(color: Colors.purple, fontSize: 18)),
                        Container(
                          height: 200,
                          width: 120,
                          child: CupertinoPicker(
                            itemExtent: 30,
                            scrollController: FixedExtentScrollController(initialItem: selectedWeight.toInt() - 30),
                            onSelectedItemChanged: (index) {
                              setStateModal(() => selectedWeight = (index + 30).toDouble());
                            },
                            children: List.generate(121, (index) => Text("${index + 30} kg")),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {
                    onSave(Data(height: selectedHeight, weight: selectedWeight));
                    Navigator.pop(context);
                  },
                  child: Text(data != null ? "Edit Data" : "Add Data", style: TextStyle(color: Colors.white, fontSize: 18)),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
