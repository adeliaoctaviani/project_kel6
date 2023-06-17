import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:project_kel_6/config/asset.dart';
import 'package:project_kel_6/event/event_db.dart';
import 'package:project_kel_6/screen/admin/list_perlombaan.dart';
import 'package:project_kel_6/widget/info.dart';

import '../../model/perlombaan.dart';

class AddUpdatePerlombaan extends StatefulWidget {
  final Perlombaan? perlombaan;
  AddUpdatePerlombaan({this.perlombaan});

  @override
  State<AddUpdatePerlombaan> createState() => _AddUpdatePerlombaanState();
}

class _AddUpdatePerlombaanState extends State<AddUpdatePerlombaan> {
  var _formKey = GlobalKey<FormState>();
  var _controllerIdLomba = TextEditingController();
  var _controllerNamaLomba = TextEditingController();
  var _controllerDeskripsiLomba = TextEditingController();
  var _controllerKuotaLomba = TextEditingController();

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.perlombaan != null) {
      _controllerIdLomba.text = widget.perlombaan!.idLomba!;
      _controllerNamaLomba.text = widget.perlombaan!.namaLomba!;
      _controllerDeskripsiLomba.text = widget.perlombaan!.deskripsiLomba!;
      _controllerKuotaLomba.text = widget.perlombaan!.kuotaLomba!;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // titleSpacing: 0,
        title: widget.perlombaan != null
            ? Text('Update Perlombaan')
            : Text('Tambah Perlombaan'),
        backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  enabled: widget.perlombaan == null ? true : false,
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerIdLomba,
                  decoration: InputDecoration(
                      labelText: "ID Lomba",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNamaLomba,
                  decoration: InputDecoration(
                      labelText: "Nama Perlombaan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerDeskripsiLomba,
                  decoration: InputDecoration(
                      labelText: "Deskripsi Lomba",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerKuotaLomba,
                  decoration: InputDecoration(
                      labelText: "Kuota Lomba",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.perlombaan == null) {
                        String message = await EventDb.AddPerlombaan(
                          _controllerIdLomba.text,
                          _controllerNamaLomba.text,
                          _controllerDeskripsiLomba.text,
                          _controllerKuotaLomba.text,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerIdLomba.clear();
                          _controllerNamaLomba.clear();
                          _controllerDeskripsiLomba.clear();
                          _controllerKuotaLomba.clear();
                          Get.off(
                            ListPerlombaan(),
                          );
                        }
                      } else {
                        EventDb.UpdatePerlombaan(
                          _controllerIdLomba.text,
                          _controllerNamaLomba.text,
                          _controllerDeskripsiLomba.text,
                          _controllerKuotaLomba.text,
                        );
                      }
                    }
                  },
                  child: Text(
                    widget.perlombaan == null ? 'Simpan' : 'Ubah',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Asset.colorAccent,
                      fixedSize: Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
