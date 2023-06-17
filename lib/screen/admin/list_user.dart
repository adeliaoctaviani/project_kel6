import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:project_kel_6/config/asset.dart';
import 'package:project_kel_6/event/event_db.dart';
import 'package:project_kel_6/screen/admin/add_update_user.dart';
import 'package:project_kel_6/widget/obfuscating_text.dart';

import '../../model/user.dart';

class ListUser extends StatefulWidget {
  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<User> _listUser = [];

  void getUser() async {
    _listUser = await EventDb.getUser();

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void showOption(User? user) async {
    var result = await Get.dialog(
      AlertDialog(
        title: Text('Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Get.back(result: 'update');
              },
              title: Text('Update'),
            ),
            ListTile(
              onTap: () {
                Get.back(result: 'delete');
              },
              title: Text('Delete'),
            ),
            ListTile(
              onTap: () => Get.back(),
              title: Text('Close'),
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
    switch (result) {
      case 'update':
        Get.to(AddUpdateUser(user: user))?.then((value) => getUser());
        break;
      case 'delete':
        EventDb.deleteUser(user!.idUser!).then((value) => getUser());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient: LinearGradient(
          colors: [Asset.colorPrimaryDark, Asset.colorPrimary],
        ),
        title: Text('List User'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              // Tambahkan SingleChildScrollView di sini
              scrollDirection:
                  Axis.horizontal, // Atur arah scroll menjadi horizontal
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Flexible(
                        child: Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  DataColumn(
                    label: Flexible(
                        child: Text(
                      'Nama User',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  DataColumn(
                    label: Flexible(
                        child: Text(
                      'Role',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  DataColumn(
                    label: Flexible(
                        child: Text(
                      'Password',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  DataColumn(
                    label: Flexible(
                        child: Text(
                      'Aksi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
                rows: _listUser.map((user) {
                  int index = _listUser.indexOf(user) + 1;
                  String passwordToShow = user.pass ??
                      ''; // Menggunakan password asli dari objek User
                  return DataRow(
                    cells: [
                      DataCell(Text(index.toString())),
                      DataCell(Text(user.name ?? '')),
                      DataCell(Text(user.role ?? '')),
                      DataCell(ObfuscatingText(
                          passwordToShow)), // Menggunakan widget ObfuscatingText
                      DataCell(
                        IconButton(
                          onPressed: () => showOption(user),
                          icon: Icon(Icons.more_vert),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddUpdateUser())?.then((value) => getUser());
        },
        child: Icon(Icons.add),
        backgroundColor: Asset.colorAccent,
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const _defaultHeight = 56.0;

  final double elevation;
  final Gradient gradient;
  final Widget title;
  final double barHeight;

  GradientAppBar({
    this.elevation = 3.0,
    required this.gradient,
    required this.title,
    this.barHeight = _defaultHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, elevation),
            color: Colors.black.withOpacity(0.3),
            blurRadius: 3,
          ),
        ],
      ),
      child: AppBar(
        title: title,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}
