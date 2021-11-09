// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../models/chat_thread.dart';
import '../ui/views/chat/chat_detail_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/home_admin/home_admin_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/regis/regis_view.dart';
import '../ui/views/splash_screen/splash_screen_view.dart';

class Routes {
  static const String splashScreenView = '/';
  static const String loginView = '/login-view';
  static const String regisView = '/regis-view';
  static const String homeView = '/home-view';
  static const String homeAdminView = '/home-admin-view';
  static const String chatDetailView = '/chat-detail-view';
  static const all = <String>{
    splashScreenView,
    loginView,
    regisView,
    homeView,
    homeAdminView,
    chatDetailView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreenView, page: SplashScreenView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.regisView, page: RegisView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.homeAdminView, page: HomeAdminView),
    RouteDef(Routes.chatDetailView, page: ChatDetailView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashScreenView: (data) {
      return CupertinoPageRoute<CupertinoRoute<dynamic>>(
        builder: (context) => const SplashScreenView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return CupertinoPageRoute<CupertinoRoute<dynamic>>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    RegisView: (data) {
      return CupertinoPageRoute<CupertinoRoute<dynamic>>(
        builder: (context) => const RegisView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return CupertinoPageRoute<CupertinoRoute<dynamic>>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    HomeAdminView: (data) {
      return CupertinoPageRoute<CupertinoRoute<dynamic>>(
        builder: (context) => const HomeAdminView(),
        settings: data,
      );
    },
    ChatDetailView: (data) {
      var args = data.getArgs<ChatDetailViewArguments>(
        orElse: () => ChatDetailViewArguments(),
      );
      return CupertinoPageRoute<CupertinoRoute<dynamic>>(
        builder: (context) => ChatDetailView(
          key: args.key,
          roomId: args.roomId,
          admin: args.admin,
          thread: args.thread,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ChatDetailView arguments holder class
class ChatDetailViewArguments {
  final Key? key;
  final String? roomId;
  final bool admin;
  final ChatThread? thread;
  ChatDetailViewArguments(
      {this.key, this.roomId, this.admin = false, this.thread});
}
