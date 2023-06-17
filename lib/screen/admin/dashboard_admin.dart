import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kel_6/config/asset.dart';
import 'package:project_kel_6/controller/c_user.dart';
import 'package:project_kel_6/event/event_pref.dart';
import 'package:project_kel_6/model/user.dart';
import 'package:project_kel_6/screen/admin/home_screen.dart';
import 'package:project_kel_6/screen/login_screen.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int _selectedIndex = 0;
  String _title = '';
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
  ];

  CUser _cUser = Get.put(CUser());
  int _index = 0;
  User? _user;

  void getUser() async {
    _user = await EventPref.getUser();

    if (_user != null) {
      _cUser.setUser(_user!);
      setState(() {
        _title = 'default';
      });
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        child: AppBar(
          elevation: 3,
          toolbarHeight: 60,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 247, 247, 242),
          centerTitle: true,
          title: _title == 'default'
              ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  'Hai, ',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Asset.colorPrimary,
                                  ),
                                ),
                                Text(
                                  _user?.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Asset.colorPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Asset.colorAccent,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage:
                              AssetImage('asset/images/teknokrat.png'),
                          backgroundColor: Asset.colorPrimaryDark,
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  _title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff020202),
                  ),
                ),
        ),
        preferredSize: Size.fromHeight(70.0),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: MouseRegion(
          onHover: (event) {
            final hoverIndex = _getHoverIndex(event.localPosition.dx);
            setState(() {
              _hoverIndex = hoverIndex;
            });
          },
          onExit: (event) {
            setState(() {
              _hoverIndex = -1;
            });
          },
          child: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _selectedIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Color.fromARGB(255, 255, 7, 7),
            selectedItemColor: Asset.colorPrimary,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Teknokrat",
                icon: Icon(Icons.explore),
              ),
              BottomNavigationBarItem(
                label: "Log Out",
                icon: Icon(Icons.login_outlined),
              ),
            ].asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == _selectedIndex;
              final isHovered = index == _hoverIndex;

              return BottomNavigationBarItem(
                label: item.label,
                icon: item.icon,
                backgroundColor:
                    isHovered ? Color.fromARGB(255, 255, 230, 0) : null,
              );
            }).toList(),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  int _hoverIndex = -1;

  int _getHoverIndex(double x) {
    final itemWidth = MediaQuery.of(context).size.width / _widgetOptions.length;
    final hoverIndex = (x ~/ itemWidth).clamp(0, _widgetOptions.length - 1);
    return hoverIndex;
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'default';
          }
          break;
        case 1:
          {
            _title = 'navbar 1';
          }
          break;
        case 2:
          {
            _title = 'Log Out';
            if (_selectedIndex == 2) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
            }
          }
          break;
      }
    });
  }
}
