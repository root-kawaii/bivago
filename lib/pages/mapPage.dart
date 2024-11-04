import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  void ciao() async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);

    await availableMaps.first.showMarker(
      coords: Coords(37.759392, -122.5107336),
      title: "Ocean Beach",
    );
  }

// [AvailableMap { mapName: Google Maps, mapType: google }, ...]

// await availableMaps.first.showMarker(
//   coords: Coords(37.759392, -122.5107336),
//   title: "Ocean Beach",
// );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Visualization'),
        ),
        body: Container(
          child: FloatingActionButton(
            onPressed: ciao,
          ),
        ));
  }
}
