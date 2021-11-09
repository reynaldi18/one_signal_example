import 'package:flutter/material.dart';
import 'package:one_signal_example/src/helpers/scalable_dp.dart';
import 'package:one_signal_example/src/ui/shared/dimens.dart';
import 'package:one_signal_example/src/ui/shared/styles.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? errorLabel;
  final TextEditingController? controller;
  final bool password;
  final bool validate;

  const CustomTextField({
    Key? key,
    this.label,
    this.controller,
    this.password = false,
    this.validate = false,
    this.errorLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return SizedBox(
      height: validate == true
          ? SDP.sdp(textFieldHeight + (textFieldHeight / 2))
          : SDP.sdp(textFieldHeight),
      child: TextField(
        cursorColor: black,
        obscureText: password,
        style: TextStyle(
          fontSize: SDP.sdp(12),
          color: black,
        ),
        decoration: InputDecoration(
          labelText: label,
          errorText: validate == true ? errorLabel : null,
          labelStyle: const TextStyle(color: hint),
          counterStyle: const TextStyle(
            color: mainColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SDP.sdp(8)),
            borderSide: const BorderSide(
              color: greySoft,
              width: 0.0,
            ),
          ),
          enabled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SDP.sdp(8)),
            borderSide: const BorderSide(
              color: greySoft,
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SDP.sdp(8)),
            borderSide: const BorderSide(
              color: black,
              width: 1,
            ),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
