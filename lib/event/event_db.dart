import 'dart:convert';
import 'package:get/get.dart';
import 'package:project_kel_6/config/api.dart';
import 'package:project_kel_6/event/event_pref.dart';
import 'package:project_kel_6/model/mahasiswa.dart';
import 'package:project_kel_6/model/perlombaan.dart';
import 'package:project_kel_6/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:project_kel_6/screen/admin/add_update_mahasiswa.dart';
import 'package:project_kel_6/screen/admin/add_update_perlombaan.dart';
import 'package:project_kel_6/screen/admin/list_perlombaan.dart';
import 'package:project_kel_6/screen/login.dart';
import 'package:project_kel_6/widget/info.dart';

class EventDb {
  static Future<User?> login(String username, String pass) async {
    User? user;

    try {
      var response = await http.post(Uri.parse(Api.login), body: {
        'username': username,
        'pass': pass,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);

        if (responBody['success']) {
          user = User.fromJson(responBody['user']);
          EventPref.saveUser(user);
          Info.snackbar('Login Berhasil');
          Future.delayed(Duration(milliseconds: 1700), () {
            Get.off(
              Login(),
            );
          });
        } else {
          Info.snackbar('Login Gagal');
        }
      } else {
        Info.snackbar('Request Login Gagal');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

//Event DB User
  static Future<List<User>> getUser() async {
    List<User> listUser = [];

    try {
      var response = await http.get(Uri.parse(Api.getUsers));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var users = responBody['user'];

          users.forEach((user) {
            listUser.add(User.fromJson(user));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listUser;
  }

  static Future<String> addUser(
      String name, String username, String pass, String role) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addUser), body: {
        'name': name,
        'username': username,
        'pass': pass,
        'role': role
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add User Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdateUser(
    String id,
    String name,
    String username,
    String pass,
    String role,
  ) async {
    try {
      var response = await http.post(Uri.parse(Api.updateUser), body: {
        'id': id,
        'name': name,
        'username': username,
        'pass': pass,
        'role': role
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update User');
        } else {
          Info.snackbar('Gagal Update User');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteUser(String id) async {
    try {
      var response =
          await http.post(Uri.parse(Api.deleteUser), body: {'id': id});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete User');
        } else {
          Info.snackbar('Gagal Delete User');
        }
      }
    } catch (e) {
      print(e);
    }
  }

//Event DB Mahasiswa
  static Future<List<Mahasiswa>> getMahasiswa() async {
    List<Mahasiswa> listMahasiswa = [];

    try {
      var response = await http.get(Uri.parse(Api.getMahasiswa));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var mahasiswa = responBody['mahasiswa'];

          mahasiswa.forEach((mahasiswa) {
            listMahasiswa.add(Mahasiswa.fromJson(mahasiswa));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listMahasiswa;
  }

  static Future<String> AddMahasiswa(String mhsNpm, String mhsNama,
      String mhsAlamat, String mhsFakultas, String MhsProdi) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addMahasiswa), body: {
        'mhsNpm': mhsNpm,
        'mhsNama': mhsNama,
        'mhsAlamat': mhsAlamat,
        'mhsFakultas': mhsFakultas,
        'MhsProdi': MhsProdi,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Mahasiswa Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdateMahasiswa(String mhsNpm, String mhsNama,
      String mhsAlamat, String mhsFakultas, String MhsProdi) async {
    try {
      var response = await http.post(Uri.parse(Api.updateMahasiswa), body: {
        'mhsNpm': mhsNpm,
        'mhsNama': mhsNama,
        'mhsAlamat': mhsAlamat,
        'mhsFakultas': mhsFakultas,
        'MhsProdi': MhsProdi
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Mahasiswa');
        } else {
          Info.snackbar('Gagal Update Mahasiswa');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteMahasiswa(String mhsNpm) async {
    try {
      var response = await http
          .post(Uri.parse(Api.deleteMahasiswa), body: {'mhsNpm': mhsNpm});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Mahasiswa');
        } else {
          Info.snackbar('Gagal Delete Mahasiswa');
        }
      }
    } catch (e) {
      print(e);
    }
  }

//Event DB Perlombaan
  static Future<List<Perlombaan>> getPerlombaan() async {
    List<Perlombaan> listPerlombaan = [];

    try {
      var response = await http.get(Uri.parse(Api.getPerlombaan));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var perlombaan = responBody['perlombaan'];

          perlombaan.forEach((perlombaan) {
            listPerlombaan.add(Perlombaan.fromJson(perlombaan));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listPerlombaan;
  }

  static Future<String> AddPerlombaan(String idLomba, String namaLomba,
      String deskripsiLomba, String kuotaLomba) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addPerlombaan), body: {
        'idLomba': idLomba,
        'namaLomba': namaLomba,
        'deskripsiLomba': deskripsiLomba,
        'kuotaLomba': kuotaLomba
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Perlombaan Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdatePerlombaan(String idLomba, String namaLomba,
      String deskripsiLomba, String kuotaLomba) async {
    try {
      var response = await http.post(Uri.parse(Api.updatePerlombaan), body: {
        'idLomba': idLomba,
        'namaLomba': namaLomba,
        'deskripsiLomba': deskripsiLomba,
        'kuotaLomba': kuotaLomba
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Mahasiswa');
        } else {
          Info.snackbar('Gagal Update Mahasiswa');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deletePerlombaan(String idLomba) async {
    try {
      var response = await http
          .post(Uri.parse(Api.deletePerlombaan), body: {'idLomba': idLomba});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Perlombaan');
        } else {
          Info.snackbar('Gagal Delete Perlombaan');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
