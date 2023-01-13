import 'package:carousel_slider/carousel_slider.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:epi_app/blocs/panier/panier_events.dart';
import 'package:epi_app/models/panier.dart';
import 'package:epi_app/models/produit.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/blocs/produits/produit_events.dart';
import 'package:epi_app/blocs/produits/produit_states.dart';
import 'package:epi_app/composants/Produit_List.dart';
import 'package:epi_app/constantes.dart';
import 'package:epi_app/repo/produit_repo.dart';

class ProduitDetail extends StatefulWidget {
  final Produit produit ;

  const ProduitDetail({Key key, this.produit}) : super(key: key);

  @override
  _ProduitDetailState createState() => _ProduitDetailState();


}
class _ProduitDetailState extends State<ProduitDetail>{
    ProduitBloc blocP ;
    PanierBloc blocPan;
    int Qte=1 ;

    @override
    void initState(){
      blocP =BlocProvider.of<ProduitBloc>(context);
      blocPan =BlocProvider.of<PanierBloc>(context);
      super.initState() ;
    }
    @override
    void dispose() {
     blocP.close();
    super.dispose();
    }
    @override
    Widget build(BuildContext context) {

      return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.deepOrangeAccent.withOpacity((0.9)),
            child:ListView(children: <Widget>[
              Stack(
                children: <Widget>[Positioned.fill(child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ))
                , Center(
          child: Image.network(
            url2+widget.produit.image,
            fit: BoxFit.fill,
            height: 400,
            width: double.infinity,
          ),)
          ,Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          // Box decoration takes a gradient
                          gradient: LinearGradient(
                            // Where the linear gradient begins and ends
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            // Add one stop for each color. Stops should increase from 0 to 1
                            colors: [
                              // Colors are easy thanks to Flutter's Colors class.
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.07),
                              Colors.black.withOpacity(0.05),
                              Colors.black.withOpacity(0.025),
                            ],
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container())),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.produit.nom,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'TND'+widget.produit.prix.toString(),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                    right: 0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                         // changeScreen(context, CartScreen());
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Card(color: Colors.deepOrangeAccent,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.shopping_cart,color: Colors.white,),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          print("CLICKED");
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(35))),
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),Expanded(child: Container(

              child:Column(
                  children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(0),
        child: Row(
            children: <Widget>[
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('Ref: '+
           widget.produit.ref,
          style: TextStyle(color: Colors.black54,fontSize: 20)
        ),
      ),
          ]
        )
              ),
                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Descritpion Produit:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.produit.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),BlocBuilder<PanierBloc,PanierStates>(builder: (context,state) {
      if (state is IniState) {
      return  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Padding(padding: EdgeInsets.all(10),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: (){
                        if(Qte>1){
                          setState(() {
                            Qte=Qte-1;
                          });
                        }

                      }
                      ,
                      padding: EdgeInsets.all(0),
                      color: Colors.grey,
                      child: Text('-',style: TextStyle(color: Colors.black,fontSize: 30))
                  )),Padding(padding: EdgeInsets.all(5),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: (){

                        }
                      ,
                      padding: EdgeInsets.all(0),
                      color: Colors.grey,
                      child: Text('Qte:'+Qte.toString(),style: TextStyle(fontSize: 30),)
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: (){
                        print('clic');
                        setState(() {
                          Qte=Qte+1;
                        });
                      }
                      ,
                      padding: EdgeInsets.all(0),
                      color: Colors.grey,
                      child: Text('+',style: TextStyle(color: Colors.black,fontSize: 30)),
                  ))
            ],), Positioned(
              top: 10,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    var contain = state.panier.lignecmds.where((element) => element.produit == widget.produit);
                    if(contain.isEmpty){
                      blocPan.add(AddLignePan(panier: state.panier,tt: state.tt,
                          qte: Qte,
                          produit: widget.produit));
                      return Flushbar(
                        title: "Ajouté",
                        message: "Produit Ajouté au Panier",
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.black,
                        icon: Icon(Icons.check, color: Colors.green,),
                      )
                        ..show(context);
                    }else{
                      return Flushbar(
                        title: "Deja existe",
                        message: "Produit Deja existe au Panier",
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.deepOrangeAccent,
                        icon: Icon(Icons.check, color: Colors.red,),
                      )
                        ..show(context);
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                            Radius.circular(35))),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text('Ajouter au Panier',
                            style: TextStyle(color: Colors.black,),

                          ),
                        )),
                  ),
                ),
              ),
            )
            ]
        );
      }else if(state is ExistPan){
        return  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Padding(padding: EdgeInsets.all(10),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: (){
                        if(Qte>1){
                          setState(() {
                            Qte=Qte-1;
                          });
                        }

                      }
                      ,
                      padding: EdgeInsets.all(0),
                      color: Colors.grey,
                      child: Text('-',style: TextStyle(color: Colors.black,fontSize: 30))
                  )),Padding(padding: EdgeInsets.all(5),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: (){

                      }
                      ,
                      padding: EdgeInsets.all(0),
                      color: Colors.grey,
                      child: Text('Qte:'+Qte.toString(),style: TextStyle(fontSize: 30),)
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: (){
                      print('clic');
                      setState(() {
                        Qte=Qte+1;
                      });
                    }
                    ,
                    padding: EdgeInsets.all(0),
                    color: Colors.grey,
                    child: Text('+',style: TextStyle(color: Colors.black,fontSize: 30)),
                  ))
            ],), Positioned(
              top: 10,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    var contain = state.panier.lignecmds.where((element) => element.produit == widget.produit);
                    if(contain.isEmpty){
                      blocPan.add(AddLignePan(panier: state.panier,tt: state.tt,
                          qte: Qte,
                          produit: widget.produit));
                      return Flushbar(
                        title: "Ajouté",
                        message: "Produit Ajouté au Panier",
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.black,
                        icon: Icon(Icons.check, color: Colors.green,),
                      )
                        ..show(context);
                    }else{
                      return Flushbar(
                        title: "Deja existe",
                        message: "Produit Deja existe au Panier",
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.black,
                        icon: Icon(Icons.close, color: Colors.red,),
                      )
                        ..show(context);
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                            Radius.circular(35))),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text('Ajouter au Panier',
                            style: TextStyle(color: Colors.black,),

                          ),
                        )),
                  ),
                ),
              ),
            )
            ]
        );
      }})
                    ,SizedBox(height: 20.0,),

          ]
              )
                ,))
            ],),
          ),
        ),

      );

    }


}