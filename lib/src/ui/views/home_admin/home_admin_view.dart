import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:one_signal_example/src/helpers/scalable_dp.dart';
import 'package:one_signal_example/src/ui/shared/styles.dart';
import 'package:one_signal_example/src/ui/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'home_admin_viewmodel.dart';

class HomeAdminView extends StatelessWidget {
  const HomeAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<HomeAdminViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: vm.initGetThreads,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SDP.sdp(18),
                  vertical: SDP.sdp(18),
                ),
                child: vm.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : vm.threads.isEmpty
                        ? Container()
                        : ListView.builder(
                            itemCount: vm.threads.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => vm.setUserThread(vm.threadId[index]),
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: SDP.sdp(8.0)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(SDP.sdp(8)),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          offset: Offset(0, 5),
                                        )
                                      ],
                                      color: white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(SDP.sdp(14)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  vm.threads[index].senderName ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: SDP.sdp(14)),
                                                ),
                                                verticalSpace(SDP.sdp(4)),
                                                Text(
                                                  vm
                                                          .threads[index]
                                                          .chats![vm
                                                                  .threads[index]
                                                                  .chats!
                                                                  .length -
                                                              1]
                                                          .message ??
                                                      '',
                                                ),
                                              ],
                                            ),
                                          ),
                                          vm
                                                      .threads[index]
                                                      .chats![vm.threads[index]
                                                              .chats!.length -
                                                          1]
                                                      .read ==
                                                  false
                                              ? const Icon(
                                                  Icons.circle,
                                                  color: Colors.green,
                                                  size: 12.0,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                /*ListView(
                          padding: EdgeInsets.symmetric(horizontal: SDP.sdp(8)),
                          children: vm.threads.map((e) {
                            return GestureDetector(
                              onTap: () => vm.showDetailChat(e.senderId ?? ''),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: SDP.sdp(8.0)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(SDP.sdp(8)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 3,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    color: white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(SDP.sdp(14)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.senderName ?? '',
                                                style: TextStyle(
                                                    fontSize: SDP.sdp(14)),
                                              ),
                                              verticalSpace(SDP.sdp(4)),
                                              Text(
                                                e.chats![e.chats!.length - 1]
                                                        .message ??
                                                    '',
                                              ),
                                            ],
                                          ),
                                        ),
                                        e.chats![e.chats!.length - 1].read == false
                                            ? const Icon(
                                                Icons.circle,
                                                color: Colors.green,
                                                size: 12.0,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList()),*/
                ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeAdminViewModel(),
    );
  }
}
