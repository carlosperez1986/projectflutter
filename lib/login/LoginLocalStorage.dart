import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:projectflutter/account/account.dart';
import 'package:projectflutter/login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalStorage extends StatefulWidget
{
  final username;
  final islogged;
  final StatefulWidget stateful;

  LoginLocalStorage({Key key, this.username, this.islogged, this.stateful}): super(key:key);

  @override
  _LoginLocalStorage createState()  =>  _LoginLocalStorage(); 
  
 final LocalStorage storage = new LocalStorage('todo_app');

    void save(bool islogged) async {
        // final prefs = await SharedPreferences.getInstance();
        // final key = 'islogged';
        // final value = islogged;
        // prefs.setBool(key, value);
        storage.setItem("islogged", islogged);
        print('saved $islogged');
      }

  bool read() {
      try {
        // final prefs =  SharedPreferences.getInstance();
        // final key = 'islogged';
        // final value = prefs.getBool(key) ?? false;
        final value = storage.getItem("islogged");
        print('read: $value');
        return value;
      } catch (e) {
      return false; 
      }
 
      }
}
 
class _LoginLocalStorage extends State<LoginLocalStorage> {
  
  final LocalStorage storage = new LocalStorage('userdata');

  Future<SharedPreferences> prefs =  SharedPreferences.getInstance();
   
  @override
  Widget build(BuildContext context) 
  {  
    return FutureBuilder(
        future: storage.ready,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == true) {

            Map<String, dynamic> data = storage.getItem('key');

            return AccountScreen(data: data);
          } else {
            return LoginScreen();
          }
        },
      );
    }
}