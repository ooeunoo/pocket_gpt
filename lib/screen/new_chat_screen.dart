import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gpt/models/chat_model.dart';
import 'package:pocket_gpt/services/chat_service.dart';

class NewChatScreen extends StatefulWidget {
  final List<String> categories;

  const NewChatScreen({Key? key, required this.categories}) : super(key: key);

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final ADD_NEW_CATEGORY = 'Add new category';
  String? _titleErrorMessage;

  List<String> _categories = [];

  late TextEditingController _titleController;
  late TextEditingController _imageUrlController;
  late TextEditingController _categoryController;
  late TextEditingController _newCategoryController;

  final _chatService = ChatService();
  final bool _formValid = false;

  @override
  void initState() {
    _titleController = TextEditingController();
    _imageUrlController = TextEditingController();
    _categoryController = TextEditingController();
    _newCategoryController = TextEditingController();

    _categories = List.from(widget.categories);

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> createNewChat() async {
    if (_titleController.text.isEmpty) {
      setState(() {
        _titleErrorMessage = "Title cannot be empty";
      });
      return;
    }
    // Create a new chat with the given title and category.
    Chat newChat = Chat(
      imageUrl: _imageUrlController.text,
      title: _titleController.text,
      category: _categoryController.text,
    );
    int id = await _chatService.addChat(newChat);

    // Check if the chat was created successfully and go back to the main screen.
    if (id > 0) {
      Navigator.pop(context, true);
    }
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Category"),
        content: TextField(
          controller: _newCategoryController,
          decoration: const InputDecoration(hintText: "Enter category name"),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child: const Text("Add"),
            onPressed: () {
              String category = _newCategoryController.text;
              if (category.isNotEmpty) {
                setState(() {
                  _categories.add(category);
                  _categoryController.text = category;
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'New Chat',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            CupertinoButton(
              onPressed: () async {
                createNewChat();
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /**
               * 
               *  Title
               * 
               */
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 15, bottom: 5, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Title',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xff67727d)),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextField(
                          controller: _titleController,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Enter chat title",
                              border: InputBorder.none),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 24.0),
              /**
               * 
               *  Image 
               * 
               */
              // Container(
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.only(
              //           left: 20, top: 15, bottom: 5, right: 20),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           RichText(
              //             text: const TextSpan(
              //               children: [
              //                 TextSpan(
              //                   text: 'Title',
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.w500,
              //                       fontSize: 13,
              //                       color: Color(0xff67727d)),
              //                 ),
              //                 TextSpan(
              //                   text: ' *',
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 13,
              //                     color: Colors.red,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           TextField(
              //             controller: _titleController,
              //             cursorColor: Colors.black,
              //             style: const TextStyle(
              //                 fontSize: 17,
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.black),
              //             decoration: const InputDecoration(
              //                 hintText: "Enter chat title",
              //                 border: InputBorder.none),
              //           ),
              //         ],
              //       ),
              //     )),

              // const SizedBox(height: 24.0),

              // DropdownButtonFormField<String>(
              //   value: _categoryController.text.isNotEmpty
              //       ? _categoryController.text
              //       : null,
              //   decoration: InputDecoration(
              //     labelText: 'Category',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              //   onChanged: (String? value) {
              //     setState(() {
              //       if (value == ADD_NEW_CATEGORY) {
              //         _showAddCategoryDialog();
              //       } else {
              //         _categoryController.text = value ?? '';
              //       }
              //     });
              //   },
              //   items: [
              //     DropdownMenuItem(
              //       value: ADD_NEW_CATEGORY,
              //       child: Text(
              //         ADD_NEW_CATEGORY,
              //         style: TextStyle(color: Theme.of(context).primaryColor),
              //       ),
              //     ),
              //     ..._categories.map((category) => DropdownMenuItem(
              //           value: category,
              //           child: Text(category),
              //         )),
              //   ],
              // ),
            ],
          ),
        ));
  }
}
