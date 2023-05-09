import 'package:flutter/material.dart';
import 'package:pricelet_app/add_item.dart';
import 'package:pricelet_app/dao/item_dao.dart';
import 'package:pricelet_app/database/database.dart';
import 'package:pricelet_app/entity/item_entity.dart';

class HomePage extends StatefulWidget {
  final String homeTitle;

  ItemDao? _itemDao;
  List<Item> itemList = [];
  final database = $FloorAppDatabase.databaseBuilder('pricelet.db').build();

  HomePage({super.key, required this.homeTitle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.homeTitle),
      ),
      body: FutureBuilder(
          future: _callItem(),
          builder: (BuildContext context, AsyncSnapshot<ItemDao> snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.none) {
              return CircularProgressIndicator();
            } else {
              return StreamBuilder(
                stream: snapshot.data!.streamedData(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.none) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return Center(child: Text('No Data Found'));
                    }

                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name),
                          );
                        });
                  }
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openAddItem();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _openAddItem() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AddItem();
    })).then((value) {
      setState(() {});
    });
  }

  Future<ItemDao> _callItem() async {
    AppDatabase appDatabase = await widget.database;
    widget._itemDao = appDatabase.itemDao;

    return appDatabase.itemDao;
  }
}
