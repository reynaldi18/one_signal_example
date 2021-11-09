import 'package:flutter/material.dart';
import 'package:one_signal_example/src/helpers/scalable_dp.dart';
import 'package:one_signal_example/src/ui/shared/dimens.dart';
import 'package:one_signal_example/src/ui/shared/styles.dart';
import 'package:one_signal_example/src/ui/shared/ui_helpers.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPress;
  final bool? disabled;
  final IconData? icon;
  final bool logout;

  final double _elevation = 0;

  const CustomButton({
    Key? key,
    this.label,
    this.onPress,
    this.disabled,
    this.icon,
    this.logout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    final action = disabled == true ? null : onPress;

    Color backgroundColor = mainColor;
    Color textColor = white;

    if (logout == true) backgroundColor = failed;

    return SizedBox(
      width: screenWidth(context),
      height: SDP.sdp(buttonHeight),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SDP.sdp(8)),
          ),
          elevation: _elevation,
          primary: backgroundColor,
        ),
        onPressed: action,
        child: Text(
          label ?? '',
          style: whiteTextStyle.copyWith(
            fontSize: SDP.sdp(12),
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
