import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
//https://pt.stackoverflow.com/questions/492331/exibir-os-dados-do-arrays-itens

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    ) //MaterialApp
  ); //runApp
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {

  static const String strjson =  """
    {
       "usuarios":[
          {
             "id":"001",
             "nome":"Matheus Ribeiro",
             "telefone":"5514981234567",
             "emails":[
                {
                   "email":"contato@matheus.com",
                   "tipo":"contato"
                },
                {
                   "email":"financeiro@matheus.com",
                   "tipo":"financeiro"
                }
             ]
          },
          {
             "id":"002",
             "nome":"Miranda",
             "telefone":"5514981765432",
             "emails":[
                {
                   "email":"contato@miranda.com",
                   "tipo":"contato"
                },
                {
                   "email":"financeiro@miranda.com",
                   "tipo":"financeiro"
                }
             ]
          }
       ]
    }
    """;

 final jsonMap = jsonDecode(strjson);

  @override
  Widget build(BuildContext context) {

    List<Usuario> usuarios = (jsonMap["usuarios"] as List).map((usuario) => Usuario.fromJson(usuario as Map<String, dynamic> )).toList();
    
    return ListView.builder(
      itemCount: usuarios.length,
      itemBuilder: (_, index) {
        Usuario usuario = usuarios[index];
        return Card(
          child: Column(
            children: [
                Text("${usuario.id} - ${usuario.nome}"),
                Column(
                 children: usuario.emails.map((email) {
                    return Text("${email.email} (${email.tipo})");
                 }).toList(),
                ) //Column
            ], //children
         ) //Column
        ); //Card
      }
    ); //ListView.builder
  }
}


class Usuario {
  Usuario({required this.id,required this.nome,required this.telefone,required this.emails});
 
  final String id;
  final String nome;
  final String telefone;
  final List<Email> emails;
  
  factory Usuario.fromJson(Map<String, dynamic> json){
    return Usuario(
    id: json["id"] as String,
    nome: json["nome"] as String,
    telefone: json["telefone"] as String,
    emails: (json["emails"] as List).map((conteudo) => Email.fromJson(conteudo as Map<String, dynamic>)).toList());
  }
}

class Email {
  Email({required this.email,required this.tipo});

  final String email;
  final String tipo;
  
  factory Email.fromJson(Map<String, dynamic> json){ 
    return Email(email: json["email"] as String, tipo: json["tipo"]  as String);
  }
}