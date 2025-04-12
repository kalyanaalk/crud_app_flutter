# ObjectBox As Local Database

| Nama | NRP | Kelas |
| --- | --- | --- |
| Kalyana Putri Al Kanza | 5025211137 | PPB C |

1. Add ObjectBox to project

Use command below to add ObjectBox to the project.

```ssh
flutter pub add objectbox objectbox_flutter_libs:any
flutter pub add --dev build_runner objectbox_generator:any
```

This should add lines like this to `pubspec.yaml`.

```yml
dependencies:
  objectbox: ^4.1.0
  objectbox_flutter_libs: any

dev_dependencies:
  build_runner: ^2.4.15
  objectbox_generator: any
```

2. Define entity class (`data.dart`)

Edit data.dart so that it defines the data model with an ID and import ObjectBox package.

```dart
import 'package:objectbox/objectbox.dart';

@Entity()
class Data {
  @Id()
  int id = 0;
  double height;
  double weight;

  Data({required this.height, required this.weight});
}
```

3. Generate ObjectBox code (`objectbox.g.dart`, `objectbox-model.json`)

This has to be done after defining entity class. Use command below to generate objectbox code.

```ssh
dart run build_runner build
```

It will look for all @Entity annotation in `lib` folder and generate `lib/objectbox-model.json` (a single database definition) and `lib/objectbox.g.dart`.

4. Create a Store (`objectbox.dart`)

Store is the entry point for using ObjectBox. It is the direct interface to the database and manages Boxes. Create a helper class in `objectbox.dart`.

```dart
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`
import 'data.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  late final Box<Data> dataBox;
  
  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    dataBox = Box<Data>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}
```

5. Initialize ObjectBox (`main.dart`)

Edit main function in `main.dart` so that it initialize ObjectBox when app starts.

```dart
late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(MaterialApp(
      home: DataList(),
    ));
}
```

6. Load Data

Load data is using getAll() to fetch all stored data in ObjectBox. It also updates the UI.

```dart
  void loadData() {
    setState(() {
      datas = objectBox.dataBox.getAll();
    });
  }
```

7. Add Data

Add data is using put() to save newData to ObjectBox.

```dart
  void showAddDataModal() {
    showModal(context, onSave: (newData) {
      objectBox.dataBox.put(newData);
      loadData();
    });
  }
```

8. Update Data

Update data is also using put(), but it is keeping the same ID as before.

```dart
  void showEditDataModal(Data data) {
    showModal(context, data: data, onSave: (updatedData) {
      updatedData.id = data.id;
      objectBox.dataBox.put(updatedData);
      loadData();
    });
  }
```

9. Delete Data

Delete data is using remove() based on data's ID.

```dart
  void deletedData(Data data) {
    objectBox.dataBox.remove(data.id);
    loadData();
  }
```

## References

- https://docs.objectbox.io/ 
- https://medium.com/@sarkarsayan198/flutter-objectbox-0efeccce85eb