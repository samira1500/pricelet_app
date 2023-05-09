import 'package:floor/floor.dart';
import 'package:pricelet_app/entity/item_entity.dart';

@dao
abstract class ItemDao {
  @Query('select * from items')
  Future<List<Item>> findAllItems();

  @Query('select * from items order by id desc limit 1')
  Future<Item?> findMaxId();

  @Query('select * from items order by id desc')
  Stream<List<Item>> streamedData();

  @insert
  Future<void> insertItem(Item item);

  @update
  Future<void> updateItem(Item item);

  @Query('delete from items where id= :id')
  Future<void> deleteById(int id);

  @delete
  Future<int> deleteAll(List<Item> list);
}
