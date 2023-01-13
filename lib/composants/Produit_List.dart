import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/models/panier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epi_app/models/produit.dart';
import 'package:epi_app/constantes.dart';
import 'package:epi_app/screens/produitDetailsScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProdView extends StatelessWidget {
    Produit produit ;

  ProdView({
      this.produit
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: produit.nom,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute<ProduitDetail>(builder: (_)=>
                    MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<ProduitBloc>(context)),
                      BlocProvider.value(value: BlocProvider.of<PanierBloc>(context))], child: ProduitDetail(produit: produit,))));
              },
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        produit.nom,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                       "TND"+produit.prix.toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "TND"+produit.ref,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ),
                  child: Image.network(
                    url2+produit.image,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}

class ProdPan extends StatelessWidget {
  Lignecmd LignePan;


  ProdPan({
    this.LignePan
  });
  @override
  Widget build(BuildContext context) {
    String prix=LignePan.produit.prix;
    if(LignePan.produit.promotion==true){
      prix=LignePan.produit.prixpromo;
    }
    double pr=double.parse(prix)*LignePan.qte;
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                url2+LignePan.produit.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Card(borderOnForeground: true,shadowColor: Colors.black,
            child: Container(decoration: BoxDecoration(color: Colors.deepOrangeAccent,borderRadius:BorderRadius.circular(15) ),child: Expanded(
              child: SizedBox(height: 100,width: 310,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [ 
                  Padding(padding: EdgeInsets.only(left: 10,top: 10),child: Text(
    LignePan.produit.nom,
    style: TextStyle(
    color: Colors.black, fontWeight: FontWeight.w800,fontSize: 20),
    ),),Padding(padding: EdgeInsets.only(left: 20,top: 10),child:Row(
      children: [
        Text(
                        LignePan.produit.ref,
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
      ],
    ) ,),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 20,top: 10),
      child: Padding(padding: EdgeInsets.only(left: 20),
        child: Text(
         'Qte: '+ LignePan.qte.toString()+' PU: '+prix+'DT   ',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),
        ),
      ),
    ),Padding(padding: EdgeInsets.only(left: 30),child: Text(pr.toString()+' DT',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),))
                    ],
                  )
                      ],
                    ),
                  ))))
    ],
    ),
              ]);

  }
}

