import 'package:flutter/material.dart';
import 'package:one_signal_example/src/helpers/scalable_dp.dart';
import 'package:one_signal_example/src/ui/shared/styles.dart';
import 'package:one_signal_example/src/ui/shared/ui_helpers.dart';

class ChatBubble extends StatelessWidget {
  final String? message;
  final bool isSender;

  const ChatBubble({
    Key? key,
    this.message,
    this.isSender = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SDP.init(context);

    return Container(
      width: screenWidth(context),
      margin: EdgeInsets.only(top: SDP.sdp(16)),
      child: Stack(
        children: [
          isSender
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: screenWidthPercentage(context,
                                percentage: 0.7)),
                        padding: EdgeInsets.symmetric(
                          horizontal: SDP.sdp(12),
                          vertical: SDP.sdp(8),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(SDP.sdp(0)),
                            topRight: Radius.circular(SDP.sdp(8)),
                            bottomLeft: Radius.circular(SDP.sdp(8)),
                            bottomRight: Radius.circular(SDP.sdp(8)),
                          ),
                          color: grey,
                        ),
                        child: Text(
                          message ?? '',
                          style: const TextStyle(color: white),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: screenWidthPercentage(context,
                                percentage: 0.7)),
                        padding: EdgeInsets.symmetric(
                          horizontal: SDP.sdp(12),
                          vertical: SDP.sdp(8),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(SDP.sdp(8)),
                            topRight: Radius.circular(SDP.sdp(0)),
                            bottomLeft: Radius.circular(SDP.sdp(8)),
                            bottomRight: Radius.circular(SDP.sdp(8)),
                          ),
                          color: grey,
                        ),
                        child: Text(
                          message ?? '',
                          style: const TextStyle(color: black),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
