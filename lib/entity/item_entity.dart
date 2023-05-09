import 'package:floor/floor.dart';

@Entity(tableName: 'items')
class Item {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String name;

  final String barcode;

  final String scheduleTime;

  @ignore
  bool isSelect = false;

  Item(this.id, this.name, this.barcode, this.scheduleTime);
}
