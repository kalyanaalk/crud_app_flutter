import 'package:flutter/material.dart';
import 'data.dart';
import 'card.dart';
import 'modal.dart';

defaultData() => Data(height: 165, weight: 60);

void main() => runApp(MaterialApp(
      home: DataList(),
    ));

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  List<Data> datas = [
    Data(height: 170, weight: 65),
    Data(height: 180, weight: 75),
    Data(height: 160, weight: 55),
  ];

  void deletedData(Data data) {
    setState(() {
      datas.remove(data);
    });
  }

  void showAddDataModal() {
    showModal(context, onSave: (newData) {
      setState(() {
        datas.add(newData);
      });
    });
  }

  void showEditDataModal(Data data) {
    showModal(context, data: data, onSave: (updatedData) {
      setState(() {
        data.height = updatedData.height;
        data.weight = updatedData.weight;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text(
          'Height & Weight Tracker',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: datas
                  .map((data) => DataCard(
                        data: data,
                        delete: () => deletedData(data),
                        edit: () => showEditDataModal(data),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDataModal,
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[200],
      ),
    );
  }
}