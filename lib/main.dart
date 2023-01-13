
import 'package:epi_app/models/panier.dart';
import 'package:epi_app/repo/auth_repo.dart';
import 'package:epi_app/repo/panier_repo.dart';
import 'package:epi_app/repo/produit_repo.dart';
import 'package:epi_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_states.dart';
import 'blocs/categorie/categorie_bloc.dart';
import 'blocs/categorie/categorie_states.dart';
import 'blocs/panier/panier_bloc.dart';
import 'blocs/panier/panier_states.dart';
import 'repo/categorie_repo.dart';
import 'blocs/produits/produit_bloc.dart';
import 'blocs/produits/produit_events.dart';
import 'blocs/produits/produit_states.dart';
import 'screens/homeScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen()
    ));
  }
}