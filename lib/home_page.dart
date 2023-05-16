import 'package:flutter/material.dart';
import 'package:pricelet_app/add_item.dart';
import 'package:pricelet_app/custom_drawer.dart';
import 'package:pricelet_app/dao/item_dao.dart';
import 'package:pricelet_app/database/database.dart';
import 'package:pricelet_app/entity/item_entity.dart';
import 'package:pricelet_app/search_bar.dart';

class HomePage extends StatefulWidget {
  final String homeTitle;

  ItemDao? _itemDao;

  final database = $FloorAppDatabase.databaseBuilder('pricelet.db').build();

  HomePage({super.key, required this.homeTitle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  final List<Item> _searchList = [];

  bool _hasData = false;

  void filterData(List<Item> data) {
    if (_controller.text.isEmpty) {
      _searchList.clear();
      _searchList.addAll(data);
    } else {
      _searchList.clear();
      _searchList.addAll(data
          .where((i) =>
              i.name.toLowerCase().contains(_controller.text.toLowerCase()))
          .toList());
    }
  }

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
                    return const CircularProgressIndicator();
                  } else {
                    final data = snapshot.data!;
                    filterData(data);

                    if (_searchList.isEmpty) {
                      return Column(
                        children: [
                          TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Search For Item...',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _hasData = value.isNotEmpty;
                              });
                            },
                          ),
                          Center(child: Text('No Data Found')),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Search For Item...',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _hasData = value.isNotEmpty;
                            });
                          },
                        ),
                        Visibility(
                          visible: true,
                          child: Expanded(
                            child: ListView.builder(
                                itemCount: _searchList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
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
                                        _searchList[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _searchList[index].barcode,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () {
                                              // Handle edit action
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return AddItem(
                                                    id: _searchList[index].id,
                                                    name:
                                                        _searchList[index].name,
                                                    barcode: _searchList[index]
                                                        .barcode,
                                                    price: _searchList[index]
                                                        .price);
                                              })).then((value) {
                                                setState(() {});
                                              });
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                color: Colors.red),
                                            onPressed: () {
                                              _deleteItem(
                                                  _searchList[index].id);
                                            },
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        // Handle tap on list tile
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    );
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
