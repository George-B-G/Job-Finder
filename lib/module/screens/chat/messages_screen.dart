import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.data});

  TextEditingController messageController = TextEditingController();
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWithLogo(
        title: data['sender_user'] ?? 'error in loading',
        isHavingButton: true,
        lst: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
        ],
      ),
      body: Column(
        children: [
          _ChatBody(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () => _moreChatOptions(context: context),
                    icon: const Icon(Icons.attach_file),
                  ),
                ),
                horizontalSpace(
                  value: 1,
                ),
                Expanded(
                  child: _myTextFormField(
                    textEditingController: messageController,
                    hintTextVal: 'Write a message',
                    onchange: (val) => messageController.text = val,
                  ),
                ),
                horizontalSpace(
                  value: 1,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('messages').add({
                        'uid': userId,
                        'text': messageController.text,
                        'sender': FirebaseAuth.instance.currentUser!.email,
                        'timeStamp': FieldValue.serverTimestamp(),
                      });
                      messageController.clear();
                    },
                    icon: const Icon(Icons.mic),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _moreChatOptions({
    required context,
  }) =>
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => const SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Visit job post'),
                leading: Icon(Icons.work),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('View my application'),
                leading: Icon(Icons.event_note_outlined),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Mark as unread'),
                leading: Icon(Icons.email),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Mute'),
                leading: Icon(Icons.notifications_off),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Archieve'),
                leading: Icon(Icons.archive_rounded),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Delete conversation'),
                leading: Icon(Icons.delete),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      );

  Widget _myTextFormField({
    required TextEditingController textEditingController,
    required String hintTextVal,
    required Function onchange,
  }) =>
      TextFormField(
        controller: textEditingController,
        minLines: 1,
        maxLines: 3,
        onChanged: (value) => onchange(value),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.send,
        decoration: InputDecoration(
          hintText: hintTextVal,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xff3366FF),
            ),
          ),
        ),
      );

  Widget _myTextShow({
    required String textmessage,
    required String textemail,
    required bool isme,
  }) {
    return Column(
      crossAxisAlignment:
          isme == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: isme == true
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              topRight: isme == true
                  ? const Radius.circular(0)
                  : const Radius.circular(20),
              bottomLeft: const Radius.circular(20),
              bottomRight: const Radius.circular(20),
            ),
            color: isme == true
                ? const Color(0xff3366FF)
                : const Color(0xffE5E7EB),
          ),
          child: Text(
            textmessage,
            style: TextStyle(
              color: isme == true ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _ChatBody() => Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('messages')
              .orderBy('timeStamp')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Widget> messagesWidges = [];
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final messages = snapshot.data!.docs.reversed;
            for (var message in messages) {
              final messageSender = message.get('sender');
              final messageText = message.get('text');
              final currentuser = FirebaseAuth.instance.currentUser!.email;
              final messageWid = _myTextShow(
                textemail: messageSender,
                textmessage: messageText,
                isme: currentuser == messageSender,
              );
              messagesWidges.add(messageWid);
            }
            return ListView(
              reverse: true,
              children: messagesWidges,
            );
          },
        ),
      );
}
