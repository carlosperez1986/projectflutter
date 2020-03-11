import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;
import 'package:projectflutter/chat/design_widget/mycircleavatar.dart';
import 'package:projectflutter/connect_node/node.dart';
import 'package:projectflutter/custom_drawer/home_drawer.dart';

import 'data/example.dart';
import 'design_widget/receivedmessagewidget.dart';
import 'design_widget/sentmessagewidget.dart';

class ChatDetailScreen extends StatefulWidget
{   
  final d;

  ChatDetailScreen({Key key, @required this.d}) : super(key: key);
    
  @override
  _ChatDetailState createState()  => _ChatDetailState(); 
}

class _ChatDetailState extends State<ChatDetailScreen> with TickerProviderStateMixin
{ 
  //bool _showBottom = false;
  TextEditingController txtController = new TextEditingController();
  Icon changeIconSendMessage = Icon(
                            Icons.keyboard_voice,
                            color: Colors.white,
                            size: 15
                          );
 
  List<Map<String, dynamic>> messageNode = [];
  ScrollController _controller;
  
  ListView listViewNode;
  
  @override
  void initState() { 
    //this.getData();
    super.initState();
  //    messageNode.add({
  //   'status' : MessageType.sent,
  //   'message' : 'Please share with me the details of your project, as well as your time and budgets constraints.' ,
  //   'time' : '08:45 AM'
  // });
  _controller = ScrollController();
  
  chatCurrent = this.widget.d["username"];
  
  listViewNode = ListView.builder(
                    padding: const EdgeInsets.all(15),
                    controller: null,
                    itemCount: messageNode.length,
                    itemBuilder: (ctx, i) {
                      if (messageNode[i]['status'] == MessageType.received) {
                        return ReceivedMessagesWidget(i: i, data:  messageNode[i]);
                      } else {
                        return SentMessageWidget(i: i, data: messageNode[i]);
                      }
                    },
                  );
    NodeClass().openChatStream().stream.listen((data) 
    {  
      final jsondata = jsonDecode(data);

      if(jsondata["to"] == socketidAgent)
      {
        messageNode.add({
        'status' : MessageType.received,
        'contactImgUrl' : 'https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg',
        'contactName' : 'Cliente',
        'message' :  jsondata["msg"],
        'time' : '08:43 AM'
         });
      }
      else
      {
        messageNode.add({
          'status' : MessageType.sent,
          'contactImgUrl' : 'https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg',
          'contactName' : 'Agente',
          'message' :  jsondata["msg"],
          'time' : '08:43 AM'
        });
      }
  setState(() {
    try {
       final x =  _controller.position.maxScrollExtent;
       int extend = 0;
       if(x > 0.0){
          extend = 60;
       }
      //_controller.jumpTo(30.00 * messageNode.length);
      //  _controller.animateTo(_controller.offset + extend,
      //   curve: Curves.linear, duration: Duration(milliseconds: 50));
         _controller.animateTo(
            _controller.position.maxScrollExtent + extend,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,); 

        }catch(ex){
          
        }
       listViewNode = new ListView.builder(
                    padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    controller: _controller, 
                    itemExtent: 80.00,
                    itemCount: messageNode.length,
                    itemBuilder: (ctx, i) { 
                      if (messageNode[i]['status'] == MessageType.received) {
                        return ReceivedMessagesWidget(i: i, data: messageNode[i]);
                      } 
                      else
                      {
                        return SentMessageWidget(i: i, data: messageNode[i]);
                      }
                    },
                  );
          });
      
    }); 
  }

  dispose() {
    super.dispose();
    txtController.dispose();
  }
  @override
  Widget build(BuildContext context) 
  {
    
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyCircleAvatar(
              imgUrl: widget.d['imgUrl'],
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.d['username'],
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Online",
                  style: Theme.of(context).textTheme.subtitle.apply(
                        color: myGreen,
                      ),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              print("object");
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          //Positioned.fill(
          //  child: 
            Column(
              children: <Widget>[
                Expanded(
                   child:              
                  listViewNode
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  height: 61,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                          ),
                          child: Row(
                            
                            children: <Widget>[ 
                              IconButton(
                                  icon: Icon(Icons.face), onPressed: () {}),
                              Expanded( 
                                child: TextField( 
                                  controller: txtController,
                                  onChanged: (data){
                                    setState(() {
                                       changeIconSendMessage = Icon(Icons.send,
                                        color: Colors.white,
                                        size: 25);
                                    }); 
                                  },
                                  onSubmitted: (data){
                                     setState(() {
                                      changeIconSendMessage = Icon(Icons.keyboard_voice,
                                        color: Colors.white,
                                        size: 25);
                                     });
                                  }, 
                                  decoration: InputDecoration(
                                      hintText: "Type Something...",
                                      border: InputBorder.none),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.photo_camera),
                                onPressed: () {
                                  _onSearchButtonPressed();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: myGreen, shape: BoxShape.circle),
                        child: FlatButton(
                          onPressed: (){
                            //print("object"); 
                            NodeClass().nodeChatMessage(txtController.text, this.widget.d['username'].toString());

                            txtController.clear(); 
                          },
                          child: changeIconSendMessage, 
                      
                          // onTap: (){
                          //    print("send message");
                          //     setState(() {
                          //       if(changeIconSendMessage.icon ==Icons.send)
                          //       {
                          //             print("send message");
                          //             NodeClass().nodeChatMessage(txtController.text);
                          //             changeIconSendMessage = Icon(Icons.keyboard_voice,
                          //               color: Colors.white,
                          //               size: 25); 
                          //       }else{
                          //            print("voice message");
                          //             changeIconSendMessage = Icon(Icons.send,
                          //               color: Colors.white,
                          //               size: 25); 
                          //       }
                          //     });
                          // },
                       
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          //),
          // Positioned.fill(
          //   child: GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         _showBottom = false;
          //       });
          //     },
          //   ),
          // ),
          // _showBottom ?
              //  Positioned(
              //     bottom: 90,
              //     left: 25,
              //     right: 25,
              //     child: Container(
              //       padding: EdgeInsets.all(25.0),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //               offset: Offset(0, 5),
              //               blurRadius: 15.0,
              //               color: Colors.grey)
              //         ],
              //       ),
              //       child: GridView.count(
              //         mainAxisSpacing: 21.0,
              //         crossAxisSpacing: 21.0,
              //         shrinkWrap: true,
              //         crossAxisCount: 3,
              //         children: List.generate(
              //           icons.length,
              //           (i) {
              //             return Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(15.0),
              //                 color: Colors.grey[200],
              //                 border: Border.all(color: myGreen, width: 2),
              //               ),
              //               child: IconButton(
              //                 icon: Icon(
              //                   icons[i],
              //                   color: myGreen,
              //                 ),
              //                 onPressed: () {
                                 
              //                 },
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   )
              //: Container(),
        ],
      ),
    );
  
  }
  void _onSearchButtonPressed() {
print("search button clicked");
}
 }

 List<IconData> icons = [
  Icons.image,
  Icons.camera,
  Icons.file_upload,
  Icons.folder,
  Icons.gif
];
