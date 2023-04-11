import 'package:chat/components/constants.dart';
import 'package:chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final ScrollController _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<MessageModel> messageList = [];
            for (int i = 0; i < snapShot.data!.docs.length; i++) {
              messageList.add(MessageModel.fromJason(snapShot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogoName,
                      height: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      kAppName,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(messageModel: messageList[index])
                            : ChatBubbleRecieve(
                                messageModel: messageList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      onSubmitted: (data) {
                        messages.add({
                          kMessag: data,
                          kCreatedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: Duration(microseconds: 500),
                            curve: Curves.easeIn);
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Send message...',
                        suffixIcon: Icon(
                          Icons.send,
                          color: Colors.red[900],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('Loading...');
          }
        });
  }
}
