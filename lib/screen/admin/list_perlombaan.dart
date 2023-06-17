import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:project_kel_6/config/asset.dart';
import 'package:project_kel_6/event/event_db.dart';
import 'package:project_kel_6/model/perlombaan.dart';
import 'package:project_kel_6/screen/admin/add_update_perlombaan.dart';
// import 'package:project_kelas/screen/admin/add_update_perlombaan.dart';

import '../../model/perlombaan.dart';

class ListPerlombaan extends StatefulWidget {
  @override
  State<ListPerlombaan> createState() => _ListPerlombaanState();
}

class _ListPerlombaanState extends State<ListPerlombaan> {
  List<Perlombaan> _listPerlombaan = [];

  void getPerlombaan() async {
    _listPerlombaan = await EventDb.getPerlombaan();

    setState(() {});
  }

  @override
  void initState() {
    getPerlombaan();
    super.initState();
  }

  void showOption(Perlombaan? perlombaan) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'update'),
              title: Text('Update'),
            ),
            ListTile(
              onTap: () => Get.back(result: 'delete'),
              title: Text('Delete'),
            ),
            ListTile(
              onTap: () => Get.back(),
              title: Text('Close'),
            )
          ],
        ),
        barrierDismissible: false);
    switch (result) {
      case 'update':
        Get.to(AddUpdatePerlombaan(perlombaan: perlombaan))
            ?.then((value) => getPerlombaan());
        break;
      case 'delete':
        EventDb.deletePerlombaan(perlombaan!.idLomba!)
            .then((value) => getPerlombaan());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List perlombaan'),
        backgroundColor: Asset.colorPrimary,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'ID Lomba',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Nama Perlombaan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Aksi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _listPerlombaan.map((perlombaan) {
            return DataRow(
              cells: [
                DataCell(Text(perlombaan.idLomba ?? '')),
                DataCell(Text(perlombaan.namaLomba ?? '')),
                DataCell(
                  IconButton(
                    onPressed: () => showOption(perlombaan),
                    icon: Icon(Icons.more_vert),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.to(AddUpdatePerlombaan())?.then((value) => getPerlombaan()),
        child: Icon(Icons.add),
        backgroundColor: Asset.colorAccent,
      ),
    );
  }
}
