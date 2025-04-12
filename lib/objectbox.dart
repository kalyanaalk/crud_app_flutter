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