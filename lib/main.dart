import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemons/blocs/bloc_favorito.dart';
import 'package:flutter_pokemons/splash_page.dart';
import 'package:flutter_pokemons/ultil/event_bus.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BlocFavorito>(create: (_) => BlocFavorito(), dispose:(context, value) => value.dispose(),),
        Provider<EventBus>(create: (_) => EventBus(),dispose:(context, value) => value.dispose())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
      ),
    );
  }
}
