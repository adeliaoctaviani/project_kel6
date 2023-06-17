import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:project_kel_6/config/asset.dart';
import 'package:project_kel_6/event/event_db.dart';
import 'package:project_kel_6/screen/admin/list_user.dart';
import 'package:project_kel_6/widget/info.dart';

import '../../model/user.dart';

class AddUpdateUser extends StatefulWidget {
  final User? user;
  AddUpdateUser({this.user});

  @override
  State<AddUpdateUser> createState() => _AddUpdateUserState();
}

class _AddUpdateUserState extends State<AddUpdateUser> {
  var _formKey = GlobalKey<FormState>();
  var _controllerIdUser = TextEditingController();
  var _controllerName = TextEditingController();
  var _controllerUserName = TextEditingController();
  var _controllerPass = TextEditingController();

  List<String> role = [
    "Admin",
    "Programmer",
    "Direksi",
    "Tester",
  ];

  String _role = "Admin";

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.user != null) {
      _controllerIdUser.text = widget.user!.idUser!;
      _controllerName.text = widget.user!.name!;
      _controllerUserName.text = widget.user!.userName!;
      _controllerPass.text = widget.user!.pass!;
      _role = widget.user!.role!;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GradientAppBar(
        gradient: LinearGradient(
            colors: [Asset.colorPrimaryDark, Asset.colorPrimary]),
        // titleSpacing: 0,
        title: Text('List User'),
        // backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerName,
                  decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerUserName,
                  decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: widget.user == null ? true : false,
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerPass,
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                        child: _isHidden
                            ? Icon(
                                Icons.visibility,
                                color: Colors.blue,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.red,
                              ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  value: _role,
                  decoration: InputDecoration(
                      labelText: "Role",
                      hintText: "Role",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  items: role.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _role = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.user == null) {
                        String message = await EventDb.addUser(
                          _controllerName.text,
                          _controllerUserName.text,
                          _controllerPass.text,
                          _role,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerName.clear();
                          _controllerUserName.clear();
                          _controllerPass.clear();
                          Get.off(
                            ListUser(),
                          );
                        }
                      } else {
                        EventDb.UpdateUser(
                            _controllerIdUser.text,
                            _controllerName.text,
                            _controllerUserName.text,
                            _controllerPass.text,
                            _role);
                      }
                    }
                  },
                  child: Text(
                    widget.user == null ? 'Simpan' : 'Ubah',
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
