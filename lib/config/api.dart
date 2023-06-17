class Api {
  static const _host = "http://192.168.43.47/api_kel_6";

  static String _user = "$_host/user";
  static String _mahasiswa = "$_host/mahasiswa";
  static String _perlombaan = "$_host/perlombaan";

  static String login = "$_host/login.php";

  // user
  static String addUser = "$_user/add_user.php";
  static String deleteUser = "$_user/delete_user.php";
  static String getUsers = "$_user/get_users.php";
  static String updateUser = "$_user/update_user.php";

  // mahasiswa
  static String addMahasiswa = "$_mahasiswa/add_mahasiswa.php";
  static String deleteMahasiswa = "$_mahasiswa/delete_mahasiswa.php";
  static String getMahasiswa = "$_mahasiswa/get_mahasiswa.php";
  static String updateMahasiswa = "$_mahasiswa/update_mahasiswa.php";

  // perlombaan
  static String addPerlombaan = "$_perlombaan/add_perlombaan.php";
  static String deletePerlombaan = "$_perlombaan/delete_perlombaan.php";
  static String getPerlombaan = "$_perlombaan/get_perlombaan.php";
  static String updatePerlombaan = "$_perlombaan/update_perlombaan.php";
}
