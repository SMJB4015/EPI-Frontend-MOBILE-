import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/blocs/categorie/categorie_bloc.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/produits/produit_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epi_app/models/categorie.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/constantes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epi_app/screens/categorieFils_screen.dart';
import 'package:epi_app/repo/produit_repo.dart';
import 'package:epi_app/screens/produitListCat_screen.dart';
import 'package:epi_app/blocs/categorie/categorie_states.dart';
import 'package:epi_app/repo/categorie_repo.dart';
class CatView extends StatelessWidget{
  CategorieP cat ;

  CatView({this.cat});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute<CatFilsList>(builder: (_)=>
              MultiBlocProvider(providers: [BlocProvider(create: (context) => CatBloc(InitiaState(), CatRepo())),
                BlocProvider.value(value: BlocProvider.of<PanierBloc>(context)),
                BlocProvider.value(value: BlocProvider.of<AuthBloc>(context)),BlocProvider.value(value: BlocProvider.of<ProduitBloc>(context)),

              ], child: CatFilsList(idd:cat.id ))));
        },
        child: Container(
          width: 80.0,
          height: 150,
          child: ListTile(
              title: Image.asset(
                'images/cat1.jpg',
                width: 80.0,
                height: 130.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(cat.name, style: new TextStyle(fontSize: 15.0,color: Colors.black),),
              )
          ),
        ),
      ),
    );
  }
}

class CatFView extends StatelessWidget {
  CategorieF cat;

  CatFView({this.cat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute<CatFilsList>(builder: (_)=>
                MultiBlocProvider(providers: [BlocProvider(create: (context) => ProduitBloc(InitialState(), ProduitRepo())),
                  BlocProvider.value(value: BlocProvider.of<AuthBloc>(context)),
                  BlocProvider.value(value: BlocProvider.of<PanierBloc>(context))
                ], child: ProdPcList(idd:cat.id ))));
          },
          child: Container(
            width: 80.0,
            height: 150,
            child: ListTile(
                title: Image.asset(
                  'images/cat2.png',
                  width: 80.0,
                  height: 130.0,
                ),
                subtitle: Container(
                  alignment: Alignment.topCenter,
                  child: Text(cat.name,
                    style: new TextStyle(fontSize: 15.0, color: Colors.black),),
                )
            ),
          ),
        ),
      ),
    );
  }
}
