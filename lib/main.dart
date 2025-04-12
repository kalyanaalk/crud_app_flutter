import 'package:flutter/material.dart';
import 'data.dart';
import 'card.dart';
import 'modal.dart';
import 'objectbox.dart';

defaultData() => Data(height: 165, weight: 60);
late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(MaterialApp(
      home: DataList(),
    ));
}

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  List<Data> datas = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    setState(() {
      datas = objectBox.dataBox.getAll();
    });
  }

  void deletedData(Data data) {
    objectBox.dataBox.remove(data.id);
    loadData();
  }

  void showAddDataModal() {
    showModal(context, onSave: (newData) {
      objectBox.dataBox.put(newData);
      loadData();
    });
  }

  void showEditDataModal(Data data) {
    showModal(context, data: data, onSave: (updatedData) {
      updatedData.id = data.id;
      objectBox.dataBox.put(updatedData);
      loadData();
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