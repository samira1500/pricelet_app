// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ItemDao? _itemDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `items` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `barcode` TEXT NOT NULL, `scheduleTime` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }
}

class _$ItemDao extends ItemDao {
  _$ItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _itemInsertionAdapter = InsertionAdapter(
            database,
            'items',
            (Item item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'barcode': item.barcode,
                  'scheduleTime': item.scheduleTime
                },
            changeListener),
        _itemUpdateAdapter = UpdateAdapter(
            database,
            'items',
            ['id'],
            (Item item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'barcode': item.barcode,
                  'scheduleTime': item.scheduleTime
                },
            changeListener),
        _itemDeletionAdapter = DeletionAdapter(
            database,
            'items',
            ['id'],
            (Item item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'barcode': item.barcode,
                  'scheduleTime': item.scheduleTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Item> _itemInsertionAdapter;

  final UpdateAdapter<Item> _itemUpdateAdapter;

  final DeletionAdapter<Item> _itemDeletionAdapter;

  @override
  Future<List<Item>> findAllItems() async {
    return _queryAdapter.queryList('select * from items',
        mapper: (Map<String, Object?> row) => Item(
            row['id'] as int,
            row['name'] as String,
            row['barcode'] as String,
            row['scheduleTime'] as String));
  }

  @override
  Future<Item?> findMaxId() async {
    return _queryAdapter.query('select * from items order by id desc limit 1',
        mapper: (Map<String, Object?> row) => Item(
            row['id'] as int,
            row['name'] as String,
            row['barcode'] as String,
            row['scheduleTime'] as String));
  }

  @override
  Stream<List<Item>> streamedData() {
    return _queryAdapter.queryListStream('select * from items order by id desc',
        mapper: (Map<String, Object?> row) => Item(
            row['id'] as int,
            row['name'] as String,
            row['barcode'] as String,
            row['scheduleTime'] as String),
        queryableName: 'items',
        isView: false);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from items where id= ?1', arguments: [id]);
  }

  @override
  Future<void> insertItem(Item item) async {
    await _itemInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateItem(Item item) async {
    await _itemUpdateAdapter.update(item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAll(List<Item> list) {
    return _itemDeletionAdapter.deleteListAndReturnChangedRows(list);
  }
}
