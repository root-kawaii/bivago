import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/overlayPage.dart';
import '../state/boardState.dart';
import '../themes/colors_theme.dart';
import '../pages/home.dart';
import '../pages/postView.dart';

// class BoardPage extends StatefulWidget {
//   @override
//   _CardListPageState createState() => _CardListPageState();
// }

class BoardPage extends StatelessWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
      SizedBox(
          height: screenHeight * 0.8,
          child: Stack(children: <Widget>[
            Consumer<BoardState>(builder: (context, state, child) {
              return state.loadedPosts
                  ? ListView.builder(
                      controller: state.get_scrollController(),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: 10,
                            height: screenHeight * 0.23,
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                            child: GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => PostPage(
                                              post: Post(
                                                  author: state.userID,
                                                  title:
                                                      state.itemsTitles[index],
                                                  content: state.items[index],
                                                  upvotes: int.parse(
                                                      state.itemsScore[index]),
                                                  postID: state.itemsID[index],
                                                  likedPostView:
                                                      state.itemsUpVote[index],
                                                  boardState: state,
                                                  index: index))),
                                      // (Route<dynamic> route) => false,
                                    ),
                                child: NewsCard(state: state, index: index)));
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }),
            Positioned(
                bottom: 30.0,
                right: 10.0,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: const Color.fromRGBO(255, 255, 255, 0),
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostWritingPage()),
                          );
                        },
                        tooltip: 'Insert Text',
                        child: const Icon(Icons.edit),
                      ),
                    )))
          ])),
    ])));
  }
}

class NewsCard extends StatelessWidget {
  NewsCard({super.key, required this.state, required this.index});

  BoardState state;
  int index;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  '@news',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.location_on, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'very close',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 8),
                Text(
                  '•',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 8),
                Text(
                  '6min',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                  width: screenWidth * 0.61,
                  child: Text(
                    state.items[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
              // SizedBox(
              //   width: screenWidth * 0.034,
              // ),
              SizedBox(
                  width: screenWidth * 0.10,
                  // height: screenHeight * 0.1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      InkWell(
                          onTap: !state.itemsUpVote[index]
                              ? () {
                                  state.incrementScore(index);
                                  state.userLikes(state.itemsID[index]);
                                  state.itemsUpVote[index] = true;
                                }
                              : () {
                                  state.DEincrementScore(index);
                                  state.userDELikes(state.itemsID[index]);
                                  state.itemsUpVote[index] = false;
                                },
                          child: Icon(
                            Icons.arrow_upward,
                            color: state.itemsUpVote[index]
                                ? ThemeColor.orange
                                : ThemeColor.black,
                            // size: 25,
                          )),
                      SizedBox(height: screenHeight * 0.003),
                      Text(
                        state.itemsScore[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(height: screenHeight * 0.003),
                      InkWell(
                          onTap: !state.itemsUpVote[index]
                              ? () {
                                  state.incrementScore(index);
                                  state.userLikes(state.itemsID[index]);
                                  state.itemsUpVote[index] = true;
                                }
                              : () {
                                  state.DEincrementScore(index);
                                  state.userDELikes(state.itemsID[index]);
                                  state.itemsUpVote[index] = false;
                                },
                          child: Icon(
                            Icons.arrow_downward,
                            color: state.itemsUpVote[index]
                                ? ThemeColor.orange
                                : ThemeColor.black,
                            // size: 25,
                          )),
                    ],
                  ))
            ]),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.comment, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      state.numOfComments[index].toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.more_horiz, color: Colors.white),
                    SizedBox(
                      width: screenHeight * 0.0081,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// Card(
//       child: ListTile(
//           title: Text(
//               style: TextStyle(fontSize: 20),
//               state.itemsTitles[index]),
//           subtitle: Text(state.items[index]),
//           trailing: SizedBox(
//               width: 60,
//               child: Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(
//                         width: 20,
//                         child: Text(
//                           state.itemsScore[index]
//                               .toString(),
//                           style: DefaultTextStyle
//                                   .of(context)
//                               .style
//                               .apply(
//                                   fontSizeFactor:
//                                       1.1),
//                         )),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                         decoration: const BoxDecoration(
//                             // color: ThemeColor.blue,
//                             // shape: BoxShape.circle
//                             ),
//                         width: 25,
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.arrow_upward,
//                             color:
//                                 state.itemsUpVote[
//                                         index]
//                                     ? ThemeColor
//                                         .orange
//                                     : ThemeColor
//                                         .black,
//                             size: 20,
//                           ),
//                           onPressed:
//                               !state.itemsUpVote[
//                                       index]
//                                   ? () {
//                                       state.incrementScore(
//                                           index);
//                                       state.userLikes(
//                                           state.itemsID[
//                                               index]);
//                                       state.itemsUpVote[
//                                               index] =
//                                           true;
//                                     }
//                                   : () {
//                                       state.DEincrementScore(
//                                           index);
//                                       state.userDELikes(
//                                           state.itemsID[
//                                               index]);
//                                       state.itemsUpVote[
//                                               index] =
//                                           false;
//                                     },
//                         ))
//                   ]))),
//     )