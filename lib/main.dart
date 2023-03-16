import 'package:flutter/material.dart';
import 'package:flutter_application/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child:  MyApp()));

}


