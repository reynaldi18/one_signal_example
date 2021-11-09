import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:one_signal_example/src/helpers/scalable_dp.dart';
import 'package:one_signal_example/src/ui/shared/dimens.dart';
import 'package:one_signal_example/src/ui/shared/strings.dart';
import 'package:one_signal_example/src/ui/shared/styles.dart';
import 'package:one_signal_example/src/ui/shared/ui_helpers.dart';
import 'package:one_signal_example/src/ui/widgets/button.dart';
import 'package:one_signal_example/src/ui/widgets/text_field.dart';
import 'package:stacked/stacked.dart';

import 'regis_viewmodel.dart';

class RegisView extends StatefulWidget {
  const RegisView({Key? key}) : super(key: key);

  @override
  State<RegisView> createState() => _RegisViewState();
}

class _RegisViewState extends State<RegisView> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<RegisViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SDP.sdp(defaultPadding),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      label: Strings.hintName,
                      controller: vm.nameController,
                      validate: vm.nameValidate,
                      errorLabel: Strings.errorEmptyName,
                    ),
                    verticalSpace(SDP.sdp(14)),
                    CustomTextField(
                      label: Strings.hintEmail,
                      controller: vm.emailController,
                      validate: vm.emailValidate,
                      errorLabel: Strings.errorEmptyEmail,
                    ),
                    verticalSpace(SDP.sdp(14)),
                    CustomTextField(
                      label: Strings.hintPassword,
                      controller: vm.passwordController,
                      validate: vm.passwordValidate,
                      errorLabel: Strings.errorEmptyPassword,
                      password: true,
                    ),
                    verticalSpace(SDP.sdp(14)),
                    Container(
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: white),
                        color: white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: DropdownButton<String>(
                            value: vm.role,
                            style: const TextStyle(color: black),
                            items: <String>[
                              'Customer',
                              'Admin',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text(
                              'Role',
                              style: blackTextStyle,
                            ),
                            onChanged: (value) {
                              setState(() {
                                vm.role = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(SDP.sdp(24)),
                    vm.isBusy == true
                        ? SpinKitFadingCircle(
                            size: SDP.sdp(defaultSize),
                            color: mainColor,
                          )
                        : CustomButton(
                            label: Strings.actionRegis.toUpperCase(),
                            onPress: () {
                              FocusScope.of(context).unfocus();
                              vm.regis();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => RegisViewModel(),
    );
  }
}
