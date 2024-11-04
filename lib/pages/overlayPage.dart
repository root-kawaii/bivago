import 'package:flutter/material.dart';
import 'package:bivago/themes/colors_theme.dart';
import '../pages/board.dart';
import '../state/boardState.dart';
import 'package:provider/provider.dart';

class PostWritingPage extends StatefulWidget {
  const PostWritingPage({super.key});

  @override
  _PostWritingPageState createState() => _PostWritingPageState();
}

class _PostWritingPageState extends State<PostWritingPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();

  // Function to insert formatting tags into the text field
  void insertText(String textToInsert) {
    final TextEditingValue value = _bodyController.value;
    final int start = value.selection.baseOffset;
    final int end = value.selection.extentOffset;
    final int len = textToInsert.length;

    if (start >= 0 && end >= 0) {
      final TextEditingValue newText = TextEditingValue(
        text: value.text.replaceRange(start, end, textToInsert),
        selection: TextSelection.collapsed(
          offset: start + len,
        ),
      );
      _bodyController.value = newText;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: <Widget>[
          Consumer<BoardState>(builder: (context, state, child) {
            return IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                // Implement logic to send the post
                // For now, just print the title and body
                print('Title: ${_titleController.text}');
                print('Body: ${_bodyController.text}');
                if (_bodyController.text.isNotEmpty) {
                  state.increment(_bodyController.text, _titleController.text);
                  Navigator.pop(context);
                }
              },
            );
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onTap: () {
                // Focus the title text field and show the system keyboard
                FocusScope.of(context).requestFocus(_titleFocusNode);
              },
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: screenHeight * 0.3,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      minLines: 10,
                      style: TextStyle(color: ThemeColor.white),
                      controller: _bodyController,
                      focusNode: _bodyFocusNode,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Body',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        // Focus the body text field and show the system keyboard
                        FocusScope.of(context).requestFocus(_bodyFocusNode);
                      },
                    ),
                  ),
                  Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.format_bold),
                          onPressed: () {
                            insertText("**");
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.format_italic),
                          onPressed: () {
                            insertText("*");
                          },
                        )
                      ]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
