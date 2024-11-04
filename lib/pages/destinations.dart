import 'package:flutter/material.dart';
import '../pages/expandedCard.dart';

class Event {
  final String imageUrl;
  final String title;
  final String description;

  Event({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

class DestinationsPage extends StatefulWidget {
  const DestinationsPage({Key? key}) : super(key: key);

  @override
  _DestinationsPageState createState() => _DestinationsPageState();
}

class _DestinationsPageState extends State<DestinationsPage> {
  late List<bool> _isExpandedList;

  final List<Event> events = [
    Event(
      imageUrl: 'assets/images/london.jpeg',
      title: 'Corrispondenze',
      description: 'Il progetto è sostenuto da Strategia Fotografia 2023.',
    ),
    Event(
      imageUrl: 'assets/images/new_york.jpeg',
      title: 'Franco Fontana. Modena dentro',
      description:
          'Una mostra dedicata allo stretto legame tra il grande maestro e le arti visive, nella nuova ala del Palazzo dei musei',
    ),
    // Add more events as needed
  ];

  @override
  void initState() {
    super.initState();
    _isExpandedList = List.generate(events.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpandedList[index] = !_isExpandedList[index];
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isExpandedList[index]
                    ? MediaQuery.of(context).size.height
                    : 300.0,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                  ),
                  elevation: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                          child: Image.asset(
                            events[index].imageUrl,
                            fit: BoxFit.fill,
                            height: 200.0,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              events[index].title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (_isExpandedList[index])
                              Text(
                                events[index].description,
                                style: const TextStyle(fontSize: 16),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
