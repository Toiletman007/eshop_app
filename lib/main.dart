import 'package:eshop_app/firebase_options.dart';
import 'package:eshop_app/pages/cart_page.dart';
import 'package:eshop_app/pages/home_page.dart';
import 'package:eshop_app/pages/notification_page.dart';
import 'package:eshop_app/pages/profile_page.dart';
import 'package:eshop_app/pages/sharp_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    Stripe.publishableKey =
        'pk_test_51UTJeHHwqv3HvPnPJnam3URxnqFvNlK99uGDZBISYt1gPQPxKhFWVKP31xOeP2xK9rUOZ2eM6hHW3APT2SOF6tFg005dQcVMZG';
    await Stripe.instance.applySettings();
  }
  runApp(const MyApp());
}

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MyHomePage(title: "Eshop app"),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'eshop app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routerConfig: router,
      //home: const MyHomePage(title: "Eshop app")
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const CartPage(),
    const SharpPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Notifikace',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return const NotificationPage();
                  },
                );
                //context.push('/notifpage');
              },
              iconSize: 35,
            )
          ]),
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Domů',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Košík',
          ),
          NavigationDestination(
            icon: Icon(Icons.shield_sharp),
            selectedIcon: Icon(Icons.shield_sharp),
            label: 'Broušení nožů',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
