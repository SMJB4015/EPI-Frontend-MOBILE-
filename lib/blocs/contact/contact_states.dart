


import 'package:epi_app/models/contact.dart';
import 'package:equatable/equatable.dart';

class ContactStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Begin extends ContactStates{}

class LoadingC extends ContactStates{}


class EnvoiState extends ContactStates{}

class ReceptionState extends ContactStates{
  List<Contact> messages ;

  ReceptionState({this.messages});
}

class ContactErrorState extends ContactStates{
  final String message ;

  ContactErrorState({this.message});
}
