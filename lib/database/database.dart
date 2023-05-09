import 'package:floor/floor.dart';
import 'package:pricelet_app/dao/itemDao.dart';
import 'package:pricelet_app/entity/item_entity.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import 'package:floor/floor.dart';
import 'dart:async';

part 'database.g.dart';

@Database(version: 1, entities: [Item])
abstract class AppDatabase extends FloorDatabase {
  ItemDao get itemDao;
}
