import 'package:flutter/material.dart';
import 'package:bivago/pages/destinations.dart';
import 'package:bivago/pages/loginPage.dart';
import 'package:bivago/pages/settings.dart';
import 'package:bivago/pages/board.dart';
import 'package:bivago/pages/home_cnt.dart';
import 'package:bivago/pages/profilePage.dart';
import 'package:bivago/themes/colors_theme.dart';
import 'newsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../pages/mapPage.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:bivago/pages/emergencyPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _savedSetting = '';
  String _currentLocation = 'Unknown';
  Position? _position;

  List<Widget> getList() {
    return _widgetOptions;
  }

  // @override
  // void initState() {

  // }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    MapHomePage(),
    DestinationsPage(),
    const BoardPage(),
    NewsAndWeatherPage(),
    EmergencyContactPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<String> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      print(place);
      String address = '${place.locality}, ${place.country}';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('location', address);
      return address;
    } catch (e) {
      print('Error: $e');
      return 'Unknown';
    }
  }

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }

  Future<void> _getLocation() async {
    try {
      // _handleLocationPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _position = position;
      String address = await getAddress(position.latitude, position.longitude);
      setState(() {
        _currentLocation = address;
      });
      print(_currentLocation);
    } catch (e) {
      print('Error: $e');
    }
  }

  void MapCall() async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);

    await availableMaps.first.showMarker(
      coords: Coords(_position?.latitude ?? 0, _position?.longitude ?? 0),
      title: "Ocean Beach",
    );
  }

  Future<void> _loadSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedSetting = prefs.getString('mySetting') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // asyncParseInit();
    _loadSetting();
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: ThemeColor.orange),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: GestureDetector(
              onTap: () {
                // Implement functionality when the title is clicked
                // _onItemTapped(0);
                MapCall();
                print('ciao');
              },
              child: Center(
                  child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center horizontally,
                      children: <Widget>[
                    const Icon(Icons.location_on),
                    Text(
                      _currentLocation,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 15),
                    )
                  ]))),
          elevation: 0,
          // automaticallyImplyLeading: false,
          actions: <Widget>[
            PopupMenuButton<int>(
              elevation: 1,
              icon: const CircleAvatar(
                radius: 17,
                backgroundImage: AssetImage('assets/images/logo_1.png'),
              ),
              onSelected: (value) {
                switch (value) {
                  case 0:
                    // Navigate to profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                    break;
                  case 1:
                    // Navigate to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Profile'),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Settings'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('Logout'),
                ),
              ],
            ),
          ]),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: ThemeColor.orange,
              ),
              child: Text(
                'Townly',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              textColor: Theme.of(context).primaryColorDark,
              title: const Text('Home'),
              onTap: () {
                // Add functionality for Home
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              textColor: Theme.of(context).primaryColorDark,
              title: const Text('Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DestinationsPage()),
                );
                // Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              textColor: Theme.of(context).primaryColorDark,
              title: const Text('Emergency'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmergencyContactPage()),
                );
                // Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: ThemeColor.darkGrey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: ThemeColor.orange,
            ),
            label: 'Home',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.celebration,
              color: ThemeColor.orange,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              // padding: _selectedIndex == 0
              //     ? EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
              //     : EdgeInsets.all(0),
              child: Icon(
                Icons.diversity_3,
                color: ThemeColor.orange,
              ),
              // decoration: BoxDecoration(
              //   color: _selectedIndex == 2
              //       ? const Color.fromARGB(255, 0, 0, 0)
              //       : Colors.transparent,
              //   borderRadius: BorderRadius.circular(5),
              // ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            label: 'Board',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.newspaper,
              color: ThemeColor.orange,
            ),
            label: 'News',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.phone,
              color: ThemeColor.orange,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            label: 'Emergency',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColorDark,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AnimatedIconExample extends StatefulWidget {
  const AnimatedIconExample({super.key});

  @override
  State<AnimatedIconExample> createState() => _AnimatedIconExampleState();
}

class _AnimatedIconExampleState extends State<AnimatedIconExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: animation,
          size: 72.0,
          semanticLabel: 'Show menu',
        ),
      ),
    );
  }
}
