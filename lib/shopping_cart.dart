import 'package:flutter/material.dart';
import 'package:pricelet_app/custom_drawer.dart';
import 'package:pricelet_app/database/database.dart';
import 'package:pricelet_app/entity/item_entity.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ShoppingCard extends StatefulWidget {
  const ShoppingCard({super.key});

  @override
  State<ShoppingCard> createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  List<Item> items = [Item(1, 'name', 'barcode', 'scheduleTime', 'price')];
  String _barcode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Shopping cart'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('\$${item.price}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _scanBarcode();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Color of the scanner line
      'Cancel', // Text for the cancel button
      true, // Use the flash if available
      ScanMode.BARCODE, // Scan mode (Barcode, QRCode, or both)
    );

    setState(() {
      _barcode = barcode;
    });

    final item = await _searchItem();
    if (item != null) {
      setState(() {
        items.add(item);
      });
    }
  }

  Future<Item?> _searchItem() async {
    final database = $FloorAppDatabase.databaseBuilder('pricelet.db').build();
    database.then((value) {
      value.itemDao.findItemByBarcode(_barcode).then((val) {
        if (val != null) {
          return val;
        }
      });
    });
    return null;
  }
}
