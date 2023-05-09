import 'package:flutter/material.dart';
import 'package:pricelet_app/add_item.dart';
import 'package:pricelet_app/custom_drawer.dart';
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
      drawer: MyDrawer(),
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
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  'I',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                snapshot.data![index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data![index].barcode,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.0,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      // Handle edit action
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return AddItem(
                                            id: snapshot.data![index].id,
                                            name: snapshot.data![index].name,
                                            barcode:
                                                snapshot.data![index].barcode);
                                      })).then((value) {
                                        setState(() {});
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_forever,
                                        color: Colors.red),
                                    onPressed: () {
                                      _deleteItem(snapshot.data![index].id);
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                // Handle tap on list tile
                              },
                            ),
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

  void _deleteItem(int id) {
    widget._itemDao!.deleteById(id);
    setState(() {});
  }

  _openAddItem() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddItem();
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
