import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/contact/contact_bloc.dart';
import 'package:epi_app/blocs/contact/contact_events.dart';
import 'package:epi_app/blocs/contact/contact_states.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/screens/homeScreen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import'package:email_validator/email_validator.dart';


class EnvoiM extends StatefulWidget{
  @override
  _EnvoiM createState() => _EnvoiM() ;
}

class _EnvoiM extends State<EnvoiM>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController message=TextEditingController();
  TextEditingController sujet=TextEditingController();
  TextEditingController nom=TextEditingController();
  TextEditingController infos_liv=TextEditingController();
  TextEditingController tele = TextEditingController();

  AuthBloc blocA ;
  ContactBloc blocC ;
  void initState(){
    blocA=BlocProvider.of<AuthBloc>(context);
    blocC=BlocProvider.of<ContactBloc>(context);
    super.initState() ;
  }
  @override
  void dispose() {
    blocC.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final logo =Center(child: Icon(Icons.message ,size: 50),);

    final msg=BlocBuilder<ContactBloc,ContactStates>(builder: (context,state){
      if(state is ContactErrorState){
        return Text(state.message);
      }else if (state is LoadingC){
        return Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
      }else{
        return Container();
      }
    });

    final emai= TextFormField(controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.email),

          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'Email',
          focusColor: Colors.white,
          fillColor: Colors.deepOrangeAccent),
      validator: (value) {
        if (EmailValidator.validate(value)) {
          return null ;
        }else{
          return('Please enter a valid email');

        }
      },
    );
    final messag = TextFormField(controller: message,
      autofocus: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.drive_file_rename_outline),
          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'Message',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.deepOrangeAccent),
      validator: (value) {
        if (value.isEmpty) {
          return " Message ne peut pas etre vide";
        } else if (value.length < 6) {
          return "Longeur infos livraison < 6";
        }
        return null;
      },
    );
    final name = TextFormField(controller: nom,
      autofocus: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.person),
          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'Nom',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.deepOrangeAccent),
      validator: (value) {
        if (value.isEmpty) {
          return "Nom ne peut pas etre vide";
        } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
          return "Svp entre un nom vailde";
        }else if (value.length < 4) {
          return "Longeur de nom  minimuim 4";
        }
        return null;
      },
    );
    final tel = TextFormField(controller: tele,
      autofocus: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.phone),
          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'tel',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.deepOrangeAccent),
      validator: (value) {
        if (value.isEmpty) {
          return "Tel ne peut pas etre vide";
        } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%a-z-A-Z-]').hasMatch(value)) {
          return "Svp entre un N°tel vailde";
        }else if (value.length < 8) {
          return "Longeur de N°tel  minimuim 8";
        }
        return null;
      },
    );


    final sujett = TextFormField(controller: sujet,
      autofocus: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.topic),
          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'Sujet',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.deepOrangeAccent),
      validator: (value) {
        if (value.isEmpty) {
          return "Sujet ne peut pas etre vide";
        } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
          return "Svp entre un Sujet valid";
        }else if (value.length < 4) {
          return "Longeur de Sujet  minimuim 4";
        }
        return null;
      },
    );


    return Scaffold(
      backgroundColor:Colors.grey ,
      body:BlocListener<ContactBloc,ContactStates>(listener: (context,state){
        if(state is ContactErrorState ){
          return Column(
            children: [SizedBox(height: 180,),
              Card(
                child: InkWell(
                  onTap: (){},
                  child: ListTile(
                    tileColor: Colors.deepOrangeAccent,
                    title: Text(state.message),
                    leading: Icon(Icons.close),
                  ),
                ),
              ),
            ],
          );
        }else if (state is EnvoiState){
           Flushbar(
            title:  "Envoyé",
            message:  "Message Envoyé Cher Client ",
            duration:  Duration(seconds: 2),
            backgroundColor: Colors.black,
            icon: Icon(Icons.check,color: Colors.green,),
          )..show(context).then((value) => Navigator.pop(context));
        }
      },
        child: BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
          if (state is VisiteurState){
           return Center(
              child: Form(
                key: _formKey,
                autovalidate: false,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0,right: 24.0),
                  children: <Widget>[
                    logo,
                    SizedBox(height: 20.0,),
                    msg,
                    SizedBox(height: 20.0,),
                    name,
                    SizedBox(height: 20.0,),
                    emai,
                    SizedBox(height: 20.0,),
                    tel,
                    SizedBox(height: 20.0,),
                    sujett,
                    SizedBox(height: 20.0,),
                    messag,
                    SizedBox(height: 20.0,),
                    Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: (){if(_formKey.currentState.validate()){
                              blocC.add(Envoi(email: email.text,message: message.text,tel: tele.text,sujet: sujet.text,recp:1,nom: nom.text));

                            }
                            },
                            padding: EdgeInsets.all(12),
                            color: Colors.deepOrangeAccent,
                            child: Text('Envoyer',style: TextStyle(color: Colors.black),)
                        )),

                  ],
                ),
              ),
            );
          }else if(state is UserInState){
            return Center(
              child: Form(
                key: _formKey,
                autovalidate: false,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0,right: 24.0),
                  children: <Widget>[
                    logo,
                    SizedBox(height: 20.0,),
                    msg,
                    SizedBox(height: 20.0,),
                    sujett,
                    SizedBox(height: 20.0,),
                    messag,
                    SizedBox(height: 20.0,),
                    Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: (){if(_formKey.currentState.validate()){
                              blocC.add(Envoi(email: "exemple",message: message.text,tel: "exemple",sujet: sujet.text,recp:1,nom: "exemple"));

                            }
                            },
                            padding: EdgeInsets.all(12),
                            color: Colors.deepOrangeAccent,
                            child: Text('Envoyer',style: TextStyle(color: Colors.black),)
                        )),

                  ],
                ),
              ),
            );

          }

        })
      ),
    );
  }

}