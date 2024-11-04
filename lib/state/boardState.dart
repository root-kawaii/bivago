import 'package:flutter/material.dart';
import '../utils/queryNotes.dart';

class BoardState extends ChangeNotifier {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4'
  ];
  List<String> itemsTitles = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4'
  ];
  List<bool> itemsUpVote = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> itemsScore = ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0"];
  List<String> itemsID = ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0"];
  List<int> numOfComments = [];
  String userID = "";
  static final Savior _savior = Savior();
  static final Querier _querier = Querier();
  final ScrollController _scrollController = ScrollController();
  bool loadedPosts = false;

  List<String> get _items => items;

  @override
  BoardState() {
    loadedPosts = false;
    queryNotes();
    notifyListeners();
  }

  void _scrollListener() {
    if (_scrollController.offset <= 0 &&
        !_scrollController.position.outOfRange) {
      // You've reached the bottom
      // Call your function here to load more data or perform any action
      print("scroll_reload");
      queryNotes();
    }
  }

  void _loadMoreData() {
    // Implement your logic to load more data here
    // For example, you can fetch more items from an API
    print('Loading more data...');
  }

  ScrollController get_scrollController() {
    // Implement your logic to load more data here
    // For example, you can fetch more items from an API
    _scrollController.addListener(_scrollListener);
    return _scrollController;
  }

  void increment(String addString, String titleString) {
    items.add(addString);
    itemsTitles.add(titleString);
    itemsScore.add("0");
    itemsID.add("0");
    itemsUpVote.add(false);
    _savior.registerString('Notes', [
      'text',
      'score',
      'title',
    ], [
      addString,
      "0",
      titleString
    ]);
    notifyListeners();
  }

  void incrementScore(int index) async {
    itemsScore[index] = (1 + int.parse(itemsScore[index])).toString();
    _savior.incrementScore(index);
    itemsUpVote[index] = true;
    // queryNotes();
    notifyListeners();
  }

  void DEincrementScore(int index) async {
    itemsScore[index] = (int.parse(itemsScore[index]) - 1).toString();
    _savior.decrementScore(index);
    itemsUpVote[index] = true;
    // queryNotes();
    notifyListeners();
  }

  //add parameters to query
  Future<void> queryNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    var retrieve = await _querier.queryNotes();
    // if (retrieve[0] != Null) {
    //   for (int i = 0; i < retrieve.length; i++) {
    //     print(retrieve[0][i]);
    //   }
    // }
    items = retrieve[0];
    itemsScore = retrieve[1];
    itemsID = retrieve[2];
    itemsTitles = retrieve[3];
    itemsUpVote = retrieve[4];
    for (var i in itemsID) {
      var retrieveComments = await _querier.queryCommentsNumber(i);
      numOfComments.add(retrieveComments);
    }
    print(numOfComments.length);
    notifyListeners();
    loadedPosts = true;
  }

  void userLikes(post) async {
    // await _savior.initUser();
    _savior.userLike(post);
  }

  void userDELikes(post) async {
    // await _savior.initUser();
    _savior.userDELike(post);
  }

  void moveItemUp(int index) {
    if (index > 0) {
      final item = items.removeAt(index);
      items.insert(index - 1, item);
      notifyListeners();
    }
  }

  void moveItemDown(int index) {
    if (index < items.length - 1) {
      final item = items.removeAt(index);
      items.insert(index + 1, item);
      notifyListeners();
    }
  }
}
