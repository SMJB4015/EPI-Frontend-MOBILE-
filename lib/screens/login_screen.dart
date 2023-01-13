import 'package:epi_app/blocs/auth/auth_bloc.dart';
import 'package:epi_app/blocs/auth/auth_events.dart';
import 'package:epi_app/blocs/auth/auth_states.dart';
import 'package:epi_app/blocs/produits/produit_bloc.dart';
import 'package:epi_app/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import'package:email_validator/email_validator.dart';
import 'package:epi_app/screens/signupScreen.dart';
import 'package:flushbar/flushbar.dart';
class Login extends StatefulWidget{
  @override
  _UserLogin createState() => _UserLogin() ;
}

class _UserLogin extends State<Login>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  AuthBloc blocA ;
  void initState(){
  blocA=BlocProvider.of<AuthBloc>(context);
    super.initState() ;
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
          hintStyle: TextStyle(color: Colors.black),
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
    final pass = TextFormField(controller: password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(prefixIcon: Icon(Icons.lock),
          filled: true,
          hintStyle: TextStyle(color: Colors.black),
          hintText:'Mot de Passe',
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
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



    return Scaffold(key: _scaffoldKey,
      backgroundColor:Colors.deepOrangeAccent ,
      body:BlocListener<AuthBloc,AuthStates>(listener: (context,state){
        if(state is UserInState ){
          return Flushbar(
            title:  "Connecté",
            message:  "Bienvenue Cher Client "+state.nom,
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
                pass,
                SizedBox(height: 20.0,),
              Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: (){if(_formKey.currentState.validate()){
                        blocA.add(LoginButtonPressed(email: email.text,password: password.text));

                      }
                      },
                      padding: EdgeInsets.all(12),
                      color: Colors.grey,
                      child: Text('Log In',style: TextStyle(color: Colors.black),)
                  )),Row(
                  mainAxisAlignment: MainAxisAlignment.center
                  ,children: [Text("Vous n'avez pas de compte ?"),Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute<Login>(builder: (_)=>
                              MultiBlocProvider(providers: [
                                BlocProvider.value(value: BlocProvider.of<AuthBloc>(context))], child: Register())));
                        },
                        child: Text("Register", textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
                )],)
                ,
                          ],
            ),
          ),
        ),
      ),
    );
  }

}