import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kel_6/config/asset.dart';
import 'package:project_kel_6/event/event_pref.dart';
import 'package:project_kel_6/screen/admin/list_mahasiswa.dart';
import 'package:project_kel_6/screen/admin/list_perlombaan.dart';
import 'package:project_kel_6/screen/admin/list_user.dart';
import 'package:project_kel_6/screen/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var index = 2;
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Asset.colorPrimary,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Image(image: NetworkImage('asset/images/header.png')),
            //  'https://teknokrat.ac.id/wp-content/uploads/2023/04/Web-header-UTI-23.jpg')),
          ),
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton('User', Icons.people, 0),
                    IconButton('Mahasiswa', Icons.people, 1),
                    IconButton('Perlombaan', Icons.computer_outlined, 2),
                    IconButton('Logout', Icons.logout_outlined, 99),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Event Gallery',
              style: TextStyle(
                  color: Asset.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            alignment: Alignment.topCenter,
          ),
          SizedBox(
            height: 300,
            child: ListView(
              children: [
                CarouselSlider(
                  items: [
                    SlideItem('asset/images/eksebisi.jpg'),
                    //  'https://teknokrat.ac.id/wp-content/uploads/2023/04/Sekar-Kinasih-040423-1.jpg'),
                    SlideItem('asset/images/ekspo.jpg'),
                    // 'https://teknokrat.ac.id/wp-content/uploads/2023/01/WhatsApp-Image-2023-01-04-at-18.00.09.jpeg'),
                    SlideItem('asset/images/expo.jpg'),
                    //  'https://teknokrat.ac.id/wp-content/uploads/2023/04/Tim-Tari-Teknokrat-120323.jpeg'),
                    // SlideItem(
                    //     'https://teknokrat.ac.id/wp-content/uploads/2023/04/ddaa.png'),
                  ],
                  options: CarouselOptions(
                    height: 250.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideItem extends StatelessWidget {
  final String img;

  SlideItem(this.img);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      child: Image(
          image: NetworkImage(
            img,
          ),
          fit: BoxFit.cover),
    );
  }
}

class IconButton extends StatelessWidget {
  final String nameLabel;
  final IconData iconLabel;
  final int index;

  IconButton(this.nameLabel, this.iconLabel, this.index);

  List<Map> _fragment = [
    {'title': 'Daftar User', 'view': ListUser()},
    {'title': 'Daftar Mahasiswa', 'view': ListMahasiswa()},
    {'title': 'Daftar Perlombaan', 'view': ListPerlombaan()},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: EdgeInsets.only(bottom: 5),
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                onTap: () {
                  if (index == 99) {
                    EventPref.clear();
                    Get.off(Login());
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _fragment[index]['view']),
                    );
                  }
                },
                child: Container(
                  // margin: EdgeInsets.all(5),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Asset.colorPrimaryDark,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Icon(
                          iconLabel,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              nameLabel,
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
