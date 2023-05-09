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
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'BarCode',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                // Handle form submission
                String firstName = firstNameController.text;
                String lastName = lastNameController.text;
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
            firstNameController.value.text,
            lastNameController.value.text,
            DateFormat('MMMM dd, yyyy').format(DateTime.now())));
      });
    });
    Navigator.pop(context);
  }
}
