import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:one_signal_example/src/constant/config.dart';
import 'package:one_signal_example/src/helpers/scalable_dp.dart';
import 'package:one_signal_example/src/models/chat_thread.dart';
import 'package:one_signal_example/src/ui/shared/styles.dart';
import 'package:one_signal_example/src/ui/widgets/chat_bubble.dart';
import 'package:stacked/stacked.dart';

import 'chat_detail_viewmodel.dart';

class ChatDetailView extends StatefulWidget {
  final String? roomId;
  final bool admin;
  final ChatThread? thread;

  const ChatDetailView({
    Key? key,
    this.roomId,
    this.admin = false,
    this.thread,
  }) : super(key: key);

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final _controllerChatList = ScrollController();

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 300),
      () => _controllerChatList
          .jumpTo(_controllerChatList.position.maxScrollExtent),
    );
  }

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<ChatDetailViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            vm.admin == true
                ? vm.data?.senderName ?? ''
                : vm.data?.receiverName ?? '',
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: SDP.sdp(52)),
              child: StreamBuilder<ChatThread>(
                  stream: vm.setThread(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.chats == null
                          ? Container()
                          : ListView(
                              controller: _controllerChatList,
                              padding:
                                  EdgeInsets.symmetric(horizontal: SDP.sdp(8)),
                              children: snapshot.data!.chats!.map((e) {
                                return ChatBubble(
                                  isSender: vm.user?.role == Config.customer
                                      ? !e.customer
                                      : e.customer,
                                  message: e.message,
                                );
                              }).toList());
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(SDP.sdp(8)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: SDP.sdp(38),
                        padding: EdgeInsets.symmetric(horizontal: SDP.sdp(12)),
                        decoration: BoxDecoration(
                            color: greySoft,
                            borderRadius: BorderRadius.circular(SDP.sdp(8))),
                        child: Center(
                          child: TextFormField(
                            controller: vm.messageController,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Ketika Pesan'),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          await vm.sendMessage();
                          Timer(
                            const Duration(milliseconds: 300),
                                () => _controllerChatList
                                .jumpTo(_controllerChatList.position.maxScrollExtent),
                          );
                        },
                        child: const Text('Kirim'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => ChatDetailViewModel(
        roomId: widget.roomId,
        admin: widget.admin,
        thread: widget.thread,
      ),
    );
  }
}
