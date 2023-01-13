import 'dart:ui';
import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/contact/contact_bloc.dart';
import 'package:epi_app/blocs/contact/contact_states.dart';
import 'package:epi_app/blocs/panier/panier_bloc.dart';
import 'package:epi_app/blocs/panier/panier_events.dart';
import 'package:epi_app/blocs/panier/panier_states.dart';
import 'package:epi_app/repo/contact_repo.dart';
import 'package:epi_app/screens/contact_Screen.dart';
import 'package:epi_app/screens/panier_screen.dart';
import 'package:epi_app/screens/promotion_screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/models/produit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/blocs/produits/produit_events.dart';
import 'package:epi_app/blocs/produits/produit_states.dart';
import 'package:epi_app/composants/Produit_List.dart';
import 'package:epi_app/constantes.dart';
import 'package:epi_app/repo/produit_repo.dart';
import 'package:epi_app/screens/login_screen.dart';
import 'package:epi_app/blocs/categorie/categorie_bloc.dart';
import 'package:epi_app/blocs/categorie/categorie_events.dart';
import 'package:epi_app/blocs/categorie/categorie_states.dart';
import 'package:epi_app/composants/Cat_List.dart';
import 'package:epi_app/screens/menu_Screen.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String name ;
  String token ;
  ProduitBloc blocP ;
  CatBloc blocCat;
  PanierBloc blocPan ;
  AuthBloc blocA ;

  @override
  void initState(){
    //loadUser();
    blocPan=BlocProvider.of<PanierBloc>(context);
    blocPan.add(IniPan());
    blocA=BlocProvider.of<AuthBloc>(context);
    blocA.add(StartEvent()) ;
    blocCat =BlocProvider.of<CatBloc>(context);
    blocCat.add(GetCatP());
    blocP =BlocProvider.of<ProduitBloc>(context);
    blocP.add(GetNv());
    super.initState() ;
  }
  @override
  void dispose() {
    blocCat.close();
  blocP.close();
  blocPan.close();
    super.dispose();
  }
  loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     name = (prefs.getString('nom') ?? '');
      token = (prefs.getString('token') ?? '');

    });
  }

  @override
  Widget build(BuildContext context){
    blocA.add(StartEvent());
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home',style: TextStyle(fontSize: 17),)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_sharp),title: Text('Promotions',style: TextStyle(fontSize: 17),)),
          BottomNavigationBarItem(icon: Icon(Icons.menu),title: Text('Menu',style: TextStyle(fontSize: 17),)),
          BottomNavigationBarItem(icon: Icon(Icons.message),title: Text('Contact',style: TextStyle(fontSize: 17),)),
          BottomNavigationBarItem(icon: Icon(Icons.info),title: Text('About',style: TextStyle(fontSize: 17),)),



        ],onTap: (index) {
          if(index==2){
            Navigator.push(context, MaterialPageRoute<Menu>(builder: (_)=>
                MultiBlocProvider(providers: [BlocProvider(create: (context) => ContactBloc(Begin(), ContactRepo())),
                  BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Menu())));
          }else if(index==1){
            Navigator.push(context, MaterialPageRoute<ProdPromoList>(builder: (_)=>
                MultiBlocProvider(providers: [BlocProvider(create: (context) => ProduitBloc(InitialState(), ProduitRepo())),
                  BlocProvider.value(value: BlocProvider.of<AuthBloc>(context)),
                  BlocProvider.value(value: BlocProvider.of<PanierBloc>(context))], child: ProdPromoList())));
          }else if(index==3){
            Navigator.push(context, MaterialPageRoute<ProdPromoList>(builder: (_)=>
                MultiBlocProvider(providers: [BlocProvider(create: (context) => ContactBloc(Begin(), ContactRepo())),
                  BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: EnvoiM())));
          }

      },
        backgroundColor: Colors.grey,fixedColor: Colors.white,iconSize: 30,
      ),
      appBar: AppBar(
          title: Text('EPI STORE',style: TextStyle(color: Colors.white),),
          elevation: 0,
          backgroundColor: Colors.deepOrangeAccent,
          iconTheme: IconThemeData(color: Colors.white54),
          actions:<Widget>[Row(
            children: [
      BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
      if(state is VisiteurState){
      return IconButton(padding: EdgeInsets.only(left: 20),icon: Icon(Icons.person),color: Colors.white70,onPressed: (){
      Navigator.push(context, MaterialPageRoute<Login>(builder: (_)=>
      MultiBlocProvider(providers: [
      BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Login())));
      });
      }else if(state is UserInState){
        return IconButton(padding: EdgeInsets.only(left: 20),icon: Icon(Icons.logout),color: Colors.white70,onPressed: (){
          blocA.add(DecoButtonPressed());
           Flushbar(
            title:  "Deconnecté",
            message:  "Au Revoir Cher Client ",
            duration:  Duration(seconds: 2),
            backgroundColor: Colors.black,
            icon: Icon(Icons.check,color: Colors.green,),
          )..show(context);
        }) ;
      }
      }) ,BlocBuilder<PanierBloc,PanierStates>(builder:(context,state){
        if(state is IniState){
          return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
            IconButton(padding: EdgeInsets.only(left: 20),icon: Icon(Icons.shopping_cart),color: Colors.white,onPressed: (){
              Navigator.push(context, MaterialPageRoute<PanierSC>(builder: (_)=>
                  MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<ProduitBloc>(context)),
                    BlocProvider.value(value: BlocProvider.of<PanierBloc>(context))
                    ,BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: PanierSC())));
            }),Container(
              margin : EdgeInsets.only(right:0),
              child: Text('0',style: TextStyle(color: Colors.black),) ,
              padding: EdgeInsets.only(bottom: 10,right: 10),
              decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(80)
              ),
            ),
          ],);
        }else if (state is ExistPan){
          return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
            IconButton(padding: EdgeInsets.only(left: 20),icon: Icon(Icons.shopping_cart),color: Colors.white,onPressed: (){
              Navigator.push(context, MaterialPageRoute<PanierSC>(builder: (_)=>
                  MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<ProduitBloc>(context)),
                    BlocProvider.value(value: BlocProvider.of<PanierBloc>(context))
                    ,BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: PanierSC())));
            }),Container(
              margin : EdgeInsets.only(right:0),
              child: Text(state.tt.toString(),style: TextStyle(color: Colors.black),) ,
              padding: EdgeInsets.only(bottom: 10,right: 10),
              decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(80)
              ),
            ),
          ],);
        }else if( state is SuccessEnvoi ){
          blocPan.add(IniPan());
        }
              } ),
            ]
            ,)]
      ),
      body: ListView(
          children:<Widget>[
            Carousel,
            Padding(padding:  EdgeInsets.only(top:50.0),
              child: Container(
                  alignment: Alignment.center,
                  child: new Text('Catégories',style: TextStyle(fontSize: 50,backgroundColor: Colors.deepOrangeAccent),)),),
            listCat,
            Padding(padding:  EdgeInsets.only(top:60.0),
              child: Container(
                  alignment: Alignment.center,
                  child: new Text('Nouveautés',style: TextStyle(fontSize: 50,backgroundColor: Colors.deepOrangeAccent),)),),
            ListNv,
          ]
      ),
    );

  }

}
Widget Carousel =CarouselSlider(
  items:[Image.asset('images/eq1.jpg'),Image.asset('images/eq2.jpg'),Image.asset('images/eq3.jpg')],
  options: CarouselOptions(
    autoPlay: true,
    enlargeCenterPage: true,
    initialPage: 0,
    viewportFraction: 1,

  ),

);
Widget ListNv = BlocBuilder<ProduitBloc,ProduitStates>(
    builder: (context,state){
      if(state is InitialState){
        return CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,);
      }else if (state is Loading){
        return CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,);
      }else if (state is SuccessNv){
        return Row(

            children:<Widget>[Expanded(child: SizedBox
              (height: 200,child:
            GridView.builder(itemCount: state.produits.length,scrollDirection: Axis.horizontal ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),itemBuilder: (context,index){

              return ProdView(produit: state.produits[index] )
              ;}
            )
            )
            )
            ]

        );


      }else if (state is Error){
        return (Text(state.message));

      }

    }
);
Widget listCat=BlocBuilder<CatBloc,CategorieStates>(builder: (context,state){
  if(state is InitiaState){
    return CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,);
  }else if (state is LoadingCat){
    return CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,);
  }else if (state is SuccessCatP){
    return Row(

        children:<Widget>[Expanded(child: SizedBox
          (height: 200,child:
        GridView.builder(itemCount: state.catsP.length,scrollDirection: Axis.horizontal ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),itemBuilder: (context,index){

          return CatView(cat: state.catsP[index] )
          ;}
        )
        )
        )
        ]

    );


  }else if (state is ErrorCat){
    return (Text(state.message));

  }

}
);




