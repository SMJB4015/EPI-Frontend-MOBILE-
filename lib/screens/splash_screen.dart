import 'dart:async';

import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/categorie/categorie_bloc.dart';
import 'package:epi_app/blocs/categorie/categorie_states.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/blocs/produits/produit_states.dart';
import 'package:epi_app/repo/auth_repo.dart';
import 'package:epi_app/repo/categorie_repo.dart';
import 'package:epi_app/repo/panier_repo.dart';
import 'package:epi_app/repo/produit_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epi_app/screens/homeScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () =>  Navigator.pushReplacement(context, MaterialPageRoute<Home>(builder: (_)=>MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProduitBloc(InitialState(), ProduitRepo())),
        BlocProvider(create: (context) => AuthBloc(LoginInitState(), AuthRepo())),
        BlocProvider(create: (context) => CatBloc(InitiaState(), CatRepo())),
        BlocProvider(create: (context) => PanierBloc(IniState(), PanierRepo())),



      ],child: Home(),
    )
    )
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Stack(

        children: <Widget>[
          SizedBox(height: 100,
            child: Container(
              decoration: BoxDecoration(color: Colors.deepOrangeAccent,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 150.0),child:Image.asset('images/logo.png', fit: BoxFit.fill,
                        height: 200) ,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "we are the future".toUpperCase(),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  CircularProgressIndicator(
                  valueColor:AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),backgroundColor: Colors.grey,
                  ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),

                  ],
                ),
              ),SizedBox(height: 100,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.only(topRight: Radius.circular(100))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
