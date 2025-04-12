import 'package:objectbox/objectbox.dart';

@Entity()
class Data {
  @Id()
  int id = 0;
  double height;
  double weight;

  Data({required this.height, required this.weight});
}