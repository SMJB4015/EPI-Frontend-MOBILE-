import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/screens/homeScreen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import'package:email_validator/email_validator.dart';


class Register extends StatefulWidget{
  @override
  _UserRegister createState() => _UserRegister() ;
}

class _UserRegister extends State<Register>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController passwordCo=TextEditingController();
  TextEditingController nom=TextEditingController();
  TextEditingController infos_liv=TextEditingController();
  TextEditingController tele = TextEditingController();

  AuthBloc blocA ;
  void initState(){
    blocA=BlocProvider.of<AuthBloc>(context);
    super.initState() ;
  }
  @override
  void dispose() {
    blocA.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final logo =Center(child: Icon(Icons.supervised_user_circle_rounded ,size: 50),);

    final msg=BlocBuilder<AuthBloc,AuthStates>(builder: (context,state){
      if(state is LoginErrorState){
        return Text(state.message);
      }else if (state is LoginLoadingState){
        return Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
      }else{
        return Container();
      }
    });

    final username = TextFormField(controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.email),

          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'Email',
          focusColor: Colors.white,
          fillColor: Colors.grey),
      validator: (value) {
        if (EmailValidator.validate(value)) {
          return null ;
        }else{
          return('Please enter a valid email');

        }
      },
    );
    final infos_li = TextFormField(controller: infos_liv,
      autofocus: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.drive_file_rename_outline),
          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'Infos livraison',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey),
      validator: (value) {
        if (value.isEmpty) {
          return "Infos de livraison ne peut pas etre vide";
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
          fillColor: Colors.grey),
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
            fillColor: Colors.grey),
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

    final pass = TextFormField(controller: password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(prefixIcon: Icon(Icons.lock),
          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'Mot de passe',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey),
      validator: (value) {
        if (value.isEmpty) {
          return "Mot de passe ne peut pas etre vide";
        } else if (value.length < 8) {
          return "Longeur de Mot de passe < 8";
        }
        return null;
      },
    );
    final pass2 = TextFormField(controller: passwordCo,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(prefixIcon: Icon(Icons.lock),
          filled: true,
          hintStyle: TextStyle(color: Colors.black26),
          hintText:'Confirmation Mot de Passe',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey),
      validator: (value) {
        if (value!=password.text) {
        return('Svp entre Votre Mot de passe ici pour le confirmer');
        }else if (value.isEmpty) {
      return "Confirmation de mot de passe ne peut pas etre vide";
    }
        return null;
      },
    );


    return Scaffold(
      backgroundColor:Colors.deepOrangeAccent ,
      body:BlocListener<AuthBloc,AuthStates>(listener: (context,state){
        if(state is UserRegisterSuccessState ){
          blocA.add(StartEvent());
          return Flushbar(
            title:  "Compte Creé",
            message:  "Merci pour votre inscription Cher Client",
            duration:  Duration(seconds: 2),
            backgroundColor: Colors.black,
            icon: Icon(Icons.check,color: Colors.green,),
          )..show(context).then((value) => Navigator.pop(context));
        }
      },
        child: Center(
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
                username,
                SizedBox(height: 20.0,),
                infos_li,
                SizedBox(height: 20.0,),
                name,
                SizedBox(height: 20.0,),
                tel,
                SizedBox(height: 20.0,),
                pass,
                SizedBox(height: 20.0,),
                pass2,
                SizedBox(height: 20.0,),
                Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: (){if(_formKey.currentState.validate()){
                          blocA.add(RegisterButtonPressed(email: email.text,password: password.text,tel: tele.text,infos_liv: infos_liv.text,nom: nom.text));
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(' Bienvenue , Vous etes connecté ')));

                        }
                        },
                        padding: EdgeInsets.all(12),
                        color: Colors.grey,
                        child: Text('Register',style: TextStyle(color: Colors.black),)
                    )),

              ],
            ),
          ),
        ),
      ),
    );
  }

}