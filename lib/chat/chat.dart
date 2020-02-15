import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget
{ 
  final Map<String, dynamic> data;
  final bool islogged; 
  final BuildContext contextLogin;

  ChatScreen({Key key, this.contextLogin, this.islogged, this.data}) : super(key: key);
    
  @override
  _ChatState createState()  => _ChatState(); 
}

class _ChatState extends State<ChatScreen> with TickerProviderStateMixin
{
  String url = "https://randomuser.me/api/?results=15";
  List data;

  Future<String> getData() async{
      var response = await http.get(Uri.encodeFull(url),headers: {"Accept":"application/json"});
      setState(() {
        var extractdata = json.decode(response.body);
        data = extractdata["results"];
      });
  }

  @override
  void initState() { 
    this.getData();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold( 
       body:
       Container(child: 
          new ListView.builder(
            itemCount: data == null ? 0 :data.length ,
            itemBuilder: (BuildContext context, i){

                return new ListTile(
                  title: new Text(data[i]["name"]["first"]),
                  subtitle: new Text(data[i]["phone"]),
                  leading: new CircleAvatar(
                  backgroundImage:
                      new NetworkImage(data[i]["picture"]["thumbnail"]),
                  ) 
                ); 
            })
        ,)
    );
  }

 }