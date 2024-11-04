import 'package:flutter/material.dart';
import '../utils/queryNotes.dart';

class HomeState extends ChangeNotifier {
  static final Savior _savior = Savior();
  static final Querier _querier = Querier();
  final ScrollController _scrollController = ScrollController();
  bool loaded = false;

  HomeState() {
    loaded = false;
    queryNotes();
  }

  List<String> images = [
    "https://img.etimg.com/thumb/msid-68228307,width-300,height-225,imgsize-482493,resizemode-75/uri-indi.jpg"
  ];

  Future<void> queryNotes() async {
    var retrieve = await _querier.queryCards();
    images = retrieve[0];
    notifyListeners();
    loaded = true;
  }

  // Add parameters to query
  Future<void> queryCards() async {
    try {
      var retrieve = await _querier.queryCards();
      images = retrieve[0];
    } catch (e) {
      print("Error querying cards: $e");
    }
    notifyListeners();
    loaded = true;
  }
}
