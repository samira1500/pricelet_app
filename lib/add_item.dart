import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:pricelet_app/database/database.dart';
import 'package:pricelet_app/entity/item_entity.dart';
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final itemNameController = TextEditingController();
  final serialNoController = TextEditingController();

  @override
  void dispose() {
    itemNameController.dispose();
    serialNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: itemNameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            TextFormField(
              controller: serialNoController,
              decoration: InputDecoration(
                labelText: 'BarCode',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                // Handle form submission
                String firstName = itemNameController.text;
                String lastName = serialNoController.text;
                _save();
                print('First Name: $firstName, Last Name: $lastName');
              },
            ),
          ],
        ),
      ),
    );
  }

  _save() {
    final database = $FloorAppDatabase.databaseBuilder('pricelet.db').build();
    database.then((value) {
      value.itemDao.findMaxId().then((val) {
        int id = 1;
        if (val != null) {
          id = val.id + 1;
        }

        value.itemDao.insertItem(Item(
            id,
            itemNameController.value.text,
            serialNoController.value.text,
            DateFormat('MMMM dd, yyyy').format(DateTime.now())));
      });
    });
    Navigator.pop(context);
  }
}
