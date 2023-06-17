import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:project_kel_6/config/asset.dart';
import 'package:project_kel_6/event/event_db.dart';
import 'package:project_kel_6/model/mahasiswa.dart';
import 'package:project_kel_6/screen/admin/add_update_mahasiswa.dart';
// import 'package:project_kelas/screen/admin/add_update_mahasiswa.dart';

import '../../model/mahasiswa.dart';

class ListMahasiswa extends StatefulWidget {
  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  List<Mahasiswa> _listMahasiswa = [];

  void getMahasiswa() async {
    _listMahasiswa = await EventDb.getMahasiswa();

    setState(() {});
  }

  @override
  void initState() {
    getMahasiswa();
    super.initState();
  }

  void showOption(Mahasiswa? mahasiswa) async {
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
        Get.to(AddUpdateMahasiswa(mahasiswa: mahasiswa))
            ?.then((value) => getMahasiswa());
        break;
      case 'delete':
        EventDb.deleteMahasiswa(mahasiswa!.mhsNpm!)
            .then((value) => getMahasiswa());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Mahasiswa'),
        backgroundColor: Asset.colorPrimary,
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'No.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Nama Mahasiswa',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'NPM',
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
          rows: _listMahasiswa.map((mahasiswa) {
            int index = _listMahasiswa.indexOf(mahasiswa) + 1;
            return DataRow(
              cells: [
                DataCell(Text(index.toString())),
                DataCell(Text(mahasiswa.mhsNama ?? '')),
                DataCell(Text(mahasiswa.mhsNpm ?? '')),
                DataCell(
                  IconButton(
                    onPressed: () => showOption(mahasiswa),
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
            Get.to(AddUpdateMahasiswa())?.then((value) => getMahasiswa()),
        child: Icon(Icons.add),
        backgroundColor: Asset.colorAccent,
      ),
    );
  }
}
