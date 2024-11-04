import 'package:flutter/material.dart';
import 'package:bivago/state/boardState.dart';
import 'package:bivago/themes/colors_theme.dart';
import "../pages/commentPage.dart";
import "../utils/queryNotes.dart";

class PostPage extends StatefulWidget {
  final Post post;

  const PostPage({super.key, required this.post});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List comments = [];
  bool loadedComments = false;
  final Querier _querier = Querier();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _scrollListener() {
    if (_scrollController.offset <= 0 &&
        !_scrollController.position.outOfRange) {
      // You've reached the bottom
      // Call your function here to load more data or perform any action
      print("scroll_reload");

      _fetchComments();
    }
  }

  ScrollController get_scrollController() {
    // Implement your logic to load more data here
    // For example, you can fetch more items from an API
    _scrollController.addListener(_scrollListener);
    return _scrollController;
  }

  Future<void> _fetchComments() async {
    loadedComments = false;
    final fetchedComments = await _querier.queryComments(widget.post.postID);
    setState(() {
      comments = fetchedComments;
      loadedComments = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          controller: get_scrollController(),
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight + 1),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.post.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Posted by ${widget.post.author}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(widget.post.content),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.arrow_upward,
                                            color: widget.post.likedPostView
                                                ? ThemeColor.orange
                                                : ThemeColor.black),
                                        onPressed: () {
                                          if (!widget.post.likedPostView) {
                                            widget.post.likedPostView = true;
                                            widget.post.boardState.itemsUpVote[
                                                widget.post.index] = true;
                                            widget.post.upvotes += 1;
                                            _fetchComments();
                                            widget.post.boardState
                                                .incrementScore(
                                                    widget.post.index);
                                            widget.post.boardState.userLikes(
                                                widget.post.boardState.itemsID[
                                                    widget.post.index]);
                                          } else {
                                            widget.post.likedPostView = false;
                                            widget.post.boardState.itemsUpVote[
                                                widget.post.index] = false;
                                            widget.post.upvotes -= 1;
                                            _fetchComments();
                                            widget.post.boardState
                                                .DEincrementScore(
                                                    widget.post.index);
                                            widget.post.boardState.userDELikes(
                                                widget.post.boardState.itemsID[
                                                    widget.post.index]);
                                          }
                                        },
                                      ),
                                      Text('${widget.post.upvotes}'),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final value = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommentWritingPage(
                                                  postID: widget.post.postID,
                                                )),
                                      );
                                      setState(() {
                                        loadedComments = false;
                                      });
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      _fetchComments();
                                    },
                                    child: const Text('Comment'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      loadedComments
                          ? Column(children: [
                              ...comments.map((comment) => Card(
                                      child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    tileColor: ThemeColor.white,
                                    title: Text(
                                      comment,
                                      style: TextStyle(color: ThemeColor.black),
                                    ),
                                    // subtitle: Text(
                                    //   comment.date,
                                    //   style: TextStyle(fontSize: 10),
                                    // ),
                                  )))
                            ])
                          : const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                )
              ])),
        );
      }),
    );
  }
}

class Comment {
  final String author;
  final String text;

  Comment({required this.author, required this.text});
}

class Post {
  final String author;
  final String title;
  final String content;
  int upvotes;
  final String postID;
  bool likedPostView;
  BoardState boardState;
  final int index;

  Post({
    required this.author,
    required this.title,
    required this.content,
    required this.upvotes,
    required this.postID,
    required this.likedPostView,
    required this.boardState,
    required this.index,
  });
}
