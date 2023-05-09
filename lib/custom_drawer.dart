import 'package:flutter/material.dart';
import 'package:pricelet_app/lira_rate.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('PRICE APP'),
            accountEmail: Text('pricelete@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'PA',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Items'),
            onTap: () {
              // Handle home route
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              // Handle home route
            },
          ),
          ListTile(
            leading: Icon(Icons.inbox),
            title: Text('Suppliers'),
            onTap: () {
              // Handle home route
            },
          ),
          ListTile(
            leading: Icon(Icons.currency_exchange),
            title: Text('Rate'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyWebView(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle settings route
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              // Handle help route
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Handle about route
            },
          ),
        ],
      ),
    );
  }
}
