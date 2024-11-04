import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bivago/pages/coursee.dart';
import 'package:bivago/pages/home_cnt.dart';
import '../pages/vcard.dart';

class TourismPage extends StatelessWidget {
  final double cardID;

  const TourismPage({Key? key, required this.cardID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Beautiful Beach'),
      // ),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section

              Hero(
                tag: cardID,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/images/new_york.jpeg'),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Favorite Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Beautiful Beach',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Location
                    Text(
                      'Beautiful Beach, Fort, Road, Palghar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Description
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                      'Lorem Ipsum has been the industry\'s standard dummy text.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                      'Lorem Ipsum has been the industry\'s standard dummy text.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Gallery
                    Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Gallery Images
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GalleryImage(url: 'https://example.com/image1.jpg'),
                          GalleryImage(url: 'https://example.com/image2.jpg'),
                          GalleryImage(url: 'https://example.com/image3.jpg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 30.0,
              right: 10.0,
              child: FloatingActionButton(
                  onPressed: (() => Navigator.of(context).pop()))),
        ]),
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  final String url;

  const GalleryImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/new_york.jpeg',
          fit: BoxFit.cover,
          width: screenWidth,
          height: 250,
        ),
      ),
    );
  }
}
