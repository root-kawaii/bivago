import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Savior {
  void ciao() {
    print('ciao');
  }

  void registerString(
      String object, List<String> labels, List<String> fields) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? user = prefs.getString('userID');

      if (user == null || user.isEmpty) {
        print("User ID is not available");
        return;
      }

      if (labels.length != fields.length) {
        print("Labels and fields lists must have the same length");
        return;
      }

      ParseObject firstObject = ParseObject(object);

      for (int i = 0; i < labels.length; i++) {
        firstObject.set(labels[i], fields[i]);
      }

      firstObject.set('liked_by', ["no", "body"]);
      firstObject.set('creator', user);

      ParseResponse response = await firstObject.save();
      print(response.success
          ? "Object saved successfully"
          : "Failed to save the object");
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  void incrementScore(int index) async {
    try {
      ParseResponse response = await ParseObject('Notes').getAll();
      if (!response.success || response.results == null) {
        print("Failed to fetch elements or no elements found");
        return;
      }

      List<dynamic> elements = response.results!;

      if (index < 0 || index >= elements.length) {
        print("Index out of range");
        return;
      }

      ParseObject element = elements[index];
      String currentScore = element.get<String>('score') ?? "";
      var pax = int.parse(currentScore) + 1;
      element.set('score', pax.toString());

      ParseResponse saveResponse = await element.save();
      print(saveResponse.success
          ? "Score incremented successfully"
          : "Failed to save the element");
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  void decrementScore(int index) async {
    try {
      ParseResponse response = await ParseObject('Notes').getAll();
      if (!response.success || response.results == null) {
        print("Failed to fetch elements or no elements found");
        return;
      }

      List<dynamic> elements = response.results!;

      if (index < 0 || index >= elements.length) {
        print("Index out of range");
        return;
      }

      ParseObject element = elements[index];
      String currentScore = element.get<String>('score') ?? "";
      var pax = int.parse(currentScore) - 1;
      element.set('score', pax.toString());

      ParseResponse saveResponse = await element.save();
      print(saveResponse.success
          ? "Score incremented successfully"
          : "Failed to save the element");
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<void> addCommentToPost(String postID, String newComment) async {
    // Query to fetch the post with the given postID
    final query = QueryBuilder<ParseObject>(ParseObject('Notes'))
      ..whereEqualTo('objectId', postID);

    final response = await query.query();
    if (response.success &&
        response.results != null &&
        response.results!.isNotEmpty) {
      final parseObject = response.results!.first as ParseObject;

      // Get the current list of comments
      List<dynamic>? commentsList =
          parseObject.get<List<dynamic>>('comments') ?? [];

      // // Create the new comment map
      // Map<String, dynamic> newCommentData = {
      //   'postID': postID,
      //   'comment': newComment,
      // };

      // Add the new comment to the list
      commentsList.add(newComment);

      // Update the Parse object with the new list of comments
      parseObject.set<List<dynamic>>('comments', commentsList);

      // Save the updated Parse object
      final saveResponse = await parseObject.save();
      if (saveResponse.success) {
        print('Comment added successfully.');
      } else {
        print('Failed to save comment: ${saveResponse.error?.message}');
      }
    } else {
      print('Failed to fetch post: ${response.error?.message}');
    }
  }

  Future<int> initUser() async {
    var firstObject = ParseObject("Users");
    firstObject.set('liked_posts', [""]);
    var response = await firstObject.save();
    String? userID = firstObject.objectId;
    print(response.success);
    if (response.success) {
    } else {
      print('ciao');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userID ?? "");
    return 0;
  }

  void userLike(String post) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userID');

      if (userId == null || userId.isEmpty) {
        print("User ID is not available");
        return;
      }

      ParseResponse userResponse = await ParseObject('Users').getObject(userId);
      if (!userResponse.success || userResponse.results == null) {
        print("User not found");
        return;
      }
      ParseObject userObj = userResponse.results!.first;

      ParseResponse postResponse = await ParseObject('Notes').getObject(post);
      if (!postResponse.success || postResponse.results == null) {
        print("Post not found");
        return;
      }
      ParseObject postObj = postResponse.results!.first;

      List<dynamic> likedPosts =
          userObj.get<List<dynamic>>('liked_posts') ?? [];
      if (!likedPosts.contains(postObj.objectId)) {
        likedPosts.add(postObj.objectId);
        userObj.set('liked_posts', likedPosts);
        await userObj.save();
      }

      List<dynamic> likedBy = postObj.get<List<dynamic>>('liked_by') ?? [];
      if (!likedBy.contains(userObj.objectId)) {
        likedBy.add(userObj.objectId);
        postObj.set('liked_by', likedBy);
        await postObj.save();
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  void userDELike(String post) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userID');

      if (userId == null || userId.isEmpty) {
        print("User ID is not available");
        return;
      }

      ParseResponse userResponse = await ParseObject('Users').getObject(userId);
      if (!userResponse.success || userResponse.results == null) {
        print("User not found");
        return;
      }
      ParseObject userObj = userResponse.results!.first;

      ParseResponse postResponse = await ParseObject('Notes').getObject(post);
      if (!postResponse.success || postResponse.results == null) {
        print("Post not found");
        return;
      }
      ParseObject postObj = postResponse.results!.first;

      List<dynamic> likedPosts =
          userObj.get<List<dynamic>>('liked_posts') ?? [];
      if (likedPosts.contains(postObj.objectId)) {
        likedPosts.remove(postObj.objectId);
        userObj.set('liked_posts', likedPosts);
        await userObj.save();
      }

      List<dynamic> likedBy = postObj.get<List<dynamic>>('liked_by') ?? [];
      if (likedBy.contains(userObj.objectId)) {
        likedBy.remove(userObj.objectId);
        postObj.set('liked_by', likedBy);
        await postObj.save();
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}

class Querier {
  Future<List> queryNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('userID') ?? '';
    List<String> notes = [];
    List<String> scores = [];
    List<String> IDs = [];
    List<String> titles = [];
    List<bool> likedBy = [];
    var apiResponse = await ParseObject('Notes').getAll();
    print(apiResponse.result);
    if (apiResponse.result != null) {
      for (var i in apiResponse.result) {
        if (i != Null) {
          notes.add(i['text']);
          scores.add(i['score']);
          IDs.add(i['objectId']);
          titles.add(i['title']);
          likedBy.add(i['liked_by'].contains(user));
        }
      }
    }
    return [notes, scores, IDs, titles, likedBy];
  }

  Future<List> queryCards() async {
    List<String> images = [];
    Future.delayed(const Duration(seconds: 100), () {});
    final query = QueryBuilder<ParseObject>(ParseObject('Images'))
      ..setLimit(1); // Assuming you want the first object for demonstration

    final response = await query.query();
    print('ciao');
    if (response.success && response.results != null) {
      final parseObject = response.results!.first as ParseObject;
      final parseFile = parseObject.get<ParseFile>('froggie');
      images.add(parseFile?.url ?? "");
    } else {
      print('Failed to fetch image: ${response.error?.message}');
    }
    return [images];
  }

  Future<List<String>> queryComments(String postID) async {
    List<String> comments = [];

    // Query to fetch the post with the given postID
    final query = QueryBuilder<ParseObject>(ParseObject('Notes'))
      ..whereEqualTo('objectId', postID);

    final response = await query.query();
    if (response.success &&
        response.results != null &&
        response.results!.isNotEmpty) {
      final parseObject = response.results!.first as ParseObject;

      // Get the list of comments
      List<dynamic>? commentsList = parseObject.get<List<dynamic>>('comments');

      if (commentsList != null) {
        for (var comment in commentsList) {
          if (comment != null) {
            comments.add(comment);
          }
        }
      }
    } else {
      print('Failed to fetch comments: ${response.error?.message}');
    }

    return comments;
  }

  Future<int> queryCommentsNumber(String postID) async {
    // Query to fetch the post with the given postID
    final query = QueryBuilder<ParseObject>(ParseObject('Notes'))
      ..whereEqualTo('objectId', postID);

    final response = await query.query();
    if (response.success &&
        response.results != null &&
        response.results!.isNotEmpty) {
      final parseObject = response.results!.first as ParseObject;

      // Get the list of comments
      List<dynamic>? commentsList = parseObject.get<List<dynamic>>('comments');

      // Return the number of comments
      return commentsList?.length ?? 0;
    } else {
      print('Failed to fetch comments: ${response.error?.message}');
      return 0;
    }
  }
}
