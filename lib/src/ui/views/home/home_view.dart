import 'package:flutter/material.dart';
import 'package:one_signal_example/src/helpers/scalable_dp.dart';
import 'package:one_signal_example/src/ui/shared/styles.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 82,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: vm.isBusy
                    ? const CircularProgressIndicator()
                    : Text(
                        'Welcome, ${vm.userData?.name}',
                        style: blackTextStyle.copyWith(
                          fontSize: SDP.sdp(34),
                        ),
                      ),
              ),
              TextButton(
                onPressed: () => vm.setUserThread(
                  'CtnyS64Lg0TL2iJwYODeczUryNe2',
                  'Admin',
                ),
                child: const Text('Start Chat'),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
