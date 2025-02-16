import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nepanikar/router/go_router_config.dart';
import 'package:nepanikar/services/save_directories.dart';
import 'package:nepanikar/utils/app_config.dart';
import 'package:nepanikar/utils/registry.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  // router
  registry.registerSingleton<GoRouter>(goRouterConfig);
  registry.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey());

  // TODO: Integrate with Firebase Analytics & Crashlytics
  // firebase
  // await Firebase.initializeApp();
  // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

  // registry.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);
  // await registry.get<FirebaseAnalytics>().setAnalyticsCollectionEnabled(!kDebugMode);

  // services
  registry.registerSingleton<SaveDirectories>(SaveDirectories());
  await registry.get<SaveDirectories>().init();

  // utils
  final appInfo = await PackageInfo.fromPlatform();
  final config = AppConfig(packageInfo: appInfo);
  registry.registerLazySingleton<AppConfig>(() => config);
}
