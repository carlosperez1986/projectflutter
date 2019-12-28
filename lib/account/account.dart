import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget
{ 
  final int islogged; 
  AccountScreen({Key key, this.islogged}) : super(key: key);
    
  @override
  _AccountState createState()  => _AccountState(); 
}

class _AccountState extends State<AccountScreen> with TickerProviderStateMixin
{ 
  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  { 
    return new Scaffold( 
      body: Container(
        child: Center(child: Text("login ${ widget.islogged.toString()} "),),
      ),
    );
  }
}