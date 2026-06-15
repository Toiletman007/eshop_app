import 'package:eshop_app/pages/cart_page.dart';
import 'package:eshop_app/pages/home_page.dart';
import 'package:eshop_app/pages/profile_page.dart';
import 'package:eshop_app/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MyHomePage(title: "Eshop app"),
  ),
  GoRoute(
    path: '/notifpage',
    builder: (context, state) => const NotificationPage(),
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const CartPage(),
    const ProfilePage(),
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
                  isScrollControlled:
                      true, // Umožní ti upravit si výšku podle sebe
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20)), // Hezké zaoblené rohy
                  ),
                  builder: (context) {
                    return const NotificationPage(); // Zobrazíme v něm tvou stránku
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
          // setState vynutí překreslení UI s novým indexem
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
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          )
        ],
      ),
    );
  }
}
