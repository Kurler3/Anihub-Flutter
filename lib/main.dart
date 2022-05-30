import 'package:anihub_flutter/providers/search_history_provider.dart';
import 'package:anihub_flutter/providers/user_provider.dart';
import 'package:anihub_flutter/screens/app.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://graphql.anilist.co/',
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(MultiProvider(
    providers: [
      // USER PROVIDER
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(),
        child: GraphQLProvider(
          client: client,
          child: const MyApp(),
        ),
      ),

      // SEARCH HISTORY PROVIDER
      ChangeNotifierProvider(
        create: (_) => SearchHistoryProvider(),
      ),
    ],
    child: GraphQLProvider(
      client: client,
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AniHub',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      // IN APP ROOT CHECK FOR AUTH CHANGES

      home: const AppRoot(),
    );
  }
}
