import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectflutter/chat/chat_detail.dart';
import 'package:projectflutter/connect_node/node.dart';
import 'data/example.dart';

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
 
   // this.getData();
    super.initState();
    
    friendsList = [];
      chatCurrent = "";
    NodeClass().openIdUserStream().stream.listen((data) 
    { 
      setState(() {
        socketidAgent = data;
      });
    });
    // esto inicializa la lista de chats con la lista que está en node //
    var listChats = NodeClass().listchatCurrent();
    for (var item in listChats) {
      
        friendsList.add({
                'imgUrl':
                    'https://cdn.pixabay.com/photo/2019/11/06/17/26/gear-4606749_960_720.jpg',
                'username': item["idSocket"],
                'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
                'seen': true,
                'hasUnSeenMsgs': false,
                'unseenCount': 0,
                'lastMsgTime': DateTime.now(),
                'isOnline': true
              }); 
    }
    NodeClass().openStream().stream.listen((response) 
    { 
  
  //friendsList =[];
  final String action = response["action"]; 
  final data = response["data"];  
  setState(() { 
        if(action == "add")
        { 
              friendsList.add({
                      'imgUrl':
                          'https://cdn.pixabay.com/photo/2019/11/06/17/26/gear-4606749_960_720.jpg',
                      'username': data["idSocket"],
                      'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
                      'seen': true,
                      'hasUnSeenMsgs': false,
                      'unseenCount': 0,
                      'lastMsgTime': DateTime.now(),
                      'isOnline': true
                    });  
        }
        else
        {
            // var item = friendsList.where((x)=>(x["username"]==data));
            friendsList.removeWhere((d) => d["username"] == data);
        }
      });
    });
  }

  dispose() {
    super.dispose();
  }
 Widget wChatlist(){
return Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[getAppBarUI(),chatList() ]))
            ]);

 }

  @override
  Widget build(BuildContext context) 
{
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black45),
        iconTheme: IconThemeData(color: Colors.black45),
        title: Text(socketidAgent==null ?"": socketidAgent),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {},
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 5,
      //   backgroundColor: myGreen,
      //   child: Icon(Icons.camera),
      //   onPressed: () {},
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 7.0,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.message, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.view_list, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       SizedBox(width: 25),
      //       IconButton(
      //         icon: Icon(Icons.call, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.person_outline, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
      body: ListView.builder(
        itemCount: friendsList.length,
        itemBuilder: (ctx, i) {
          return Column(
            children: <Widget>[
              ListTile(
                isThreeLine: true,
                onLongPress: () {},
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatDetailScreen(d:friendsList[i])),
                    );
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: Offset(0, 5),
                          blurRadius: 25)
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(friendsList[i]['imgUrl']),
                        ),
                      ),
                      friendsList[i]['isOnline']
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                title: Text(
                  "${friendsList[i]['username']}",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  "${friendsList[i]['lastMsg']}",
                  style: !friendsList[i]['seen']
                      ? Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(color: Colors.black87)
                      : Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(color: Colors.black54),
                ),
                trailing: Container(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          friendsList[i]['seen']
                              ? Icon(
                                  Icons.check,
                                  size: 15,
                                )
                              : Container(height: 15, width: 15),
                          Text("${friendsList[i]['lastMsgTime']}")
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      friendsList[i]['hasUnSeenMsgs']
                          ? Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: myGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${friendsList[i]['unseenCount']}",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(
                              height: 25,
                              width: 25,
                            ),
                    ],
                  ),
                ),
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }

Widget chatList(){
      return ListView.builder(
            itemCount: friendsList == null ? 0 :friendsList.length ,
            itemBuilder: (BuildContext context, i)
            { 
                return Column(
            children: <Widget>[ ListTile(
                isThreeLine: true,
                onLongPress: () {},
                onTap: (){
                        Navigator.push(context, 
                        MaterialPageRoute(
                builder: (context) => ChatDetailScreen(d: data[i]),
                )
                        );
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: Offset(0, 5),
                          blurRadius: 25)
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(friendsList[i]['imgUrl']),
                        ),
                      ),
                      friendsList[i]['isOnline']
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                title: Text(
                  "${friendsList[i]['username']}",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  "${friendsList[i]['lastMsg']}",
                  style: !friendsList[i]['seen']
                      ? Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(color: Colors.black87)
                      : Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(color: Colors.black54),
                ),
                trailing: Container(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          friendsList[i]['seen']
                              ? Icon(
                                  Icons.check,
                                  size: 15,
                                )
                              : Container(height: 15, width: 15),
                          Text("${friendsList[i]['lastMsgTime']}")
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      friendsList[i]['hasUnSeenMsgs']
                          ? Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: myGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${friendsList[i]['unseenCount']}",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(
                              height: 25,
                              width: 25,
                            ),
                    ],
                  ),
                ),
              ),
                Divider(),
            ]
                );
            }
       );
     
}

Widget getAppBarUI() {
    return Scaffold(  backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black45),
        iconTheme: IconThemeData(color: Colors.black45),
        title: Text("Messengerish"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {},
          ),
        ],
      ),
    );
    } 
 }