import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EmergencyContactPage extends StatelessWidget {
  const EmergencyContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60.0),
            const Text(
              'Are you in emergency?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Press the button below help will reach you soon.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Handle SOS button press
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.red, Colors.redAccent],
                    stops: [0.6, 1.0],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'SOS',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/howto/img_avatar.png'), // Sample image URL
                    radius: 30,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Your current address',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '151-171 Montclair Ave Newark,\nNJ 07104, USA',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
                child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: 300, // Adjust width as needed
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.flag),
                        label: const Text("Find your embassy"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.orange,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // padding: EdgeInsets.symmetric(
                          //     vertical: 20.0, horizontal: 20.0),
                        ),
                        onPressed: () {
                          // Implement embassy call function
                        },
                      ),
                    ))),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

Widget _buildEmergencyButton(
    {required Color color,
    required IconData icon,
    required String label,
    required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      foregroundColor: color,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
    ),
    onPressed: onPressed,
    child: Column(
      children: [
        Icon(icon, size: 40),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    ),
  );
}


// class EmergencyContactPage extends StatefulWidget {
//   @override
//   _EmergencyContactPageState createState() => _EmergencyContactPageState();
// }

// class _EmergencyContactPageState extends State<EmergencyContactPage> {
//   String address = "Loading...";
//   String latitude = "Loading...";
//   String longitude = "Loading...";
//   String altitude = "Loading...";

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       address = "Strada Villanova 191, 41123 Modena, Italy"; // Mock address
//       latitude = position.latitude.toString();
//       longitude = position.longitude.toString();
//       altitude = position.altitude.toString() + " m";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Emergency Contact"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Your position:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Container(
//               padding: EdgeInsets.all(8.0),
//               margin: EdgeInsets.symmetric(vertical: 8.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black),
//               ),
//               child: Text(
//                 address,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             Text(
//               "Latitude: $latitude",
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               "Longitude: $longitude",
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               "Altitude: $altitude",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildEmergencyButton(
//                   color: Colors.green,
//                   icon: Icons.local_hospital,
//                   label: "Ambulance",
//                   onPressed: () {
//                     // Implement ambulance call function
//                   },
//                 ),
//                 _buildEmergencyButton(
//                   color: Colors.blue,
//                   icon: Icons.local_police,
//                   label: "Police",
//                   onPressed: () {
//                     // Implement police call function
//                   },
//                 ),
//                 _buildEmergencyButton(
//                   color: Colors.red,
//                   icon: Icons.local_fire_department,
//                   label: "Fire",
//                   onPressed: () {
//                     // Implement fire call function
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               icon: Icon(Icons.flag),
//               label: Text("Embassy"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 foregroundColor: Colors.white,
//               ),
//               onPressed: () {
//                 // Implement embassy call function
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmergencyButton(
//       {required Color color,
//       required IconData icon,
//       required String label,
//       required VoidCallback onPressed}) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: color,
//         backgroundColor: Colors.white,
//         padding: EdgeInsets.all(16.0),
//       ),
//       onPressed: onPressed,
//       child: Column(
//         children: [
//           Icon(icon, size: 40),
//           Text(label, style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }
