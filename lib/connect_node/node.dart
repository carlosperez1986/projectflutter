import 'dart:async';
import  'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'dart:convert';

// import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:projectflutter/chat/data/example.dart';

enum ConnectionStatus{
  connected,
  disconnected
}

StreamController<dynamic> _streamController = new StreamController.broadcast();   //Agrega .broadcast acá
StreamController<dynamic> _streamChatListController = new StreamController.broadcast();   //Agrega .broadcast acá

StreamController<dynamic> _streamChatController = new StreamController.broadcast();   //Agrega .broadcast acá
StreamController<dynamic> _streamIdAgentController = new StreamController.broadcast();   //Agrega .broadcast acá

// SocketIOManager manager = SocketIOManager();
SocketIO socketIO;
SocketIOManager socketManager;


String socketidAgent;
String idUserSocketIO;
String chatCurrent;
List<dynamic> listchat;

 class MsjModel
 {
  final String from;
  final String to;
  final String msg;
  
  MsjModel(this.from, this.to, this.msg);
  
  Map<String, dynamic> toJson() => {
    'from' : from,
    'to' : to,
    'msg' : msg
  };
}
class NodeClass
{  
  var status = ConnectionStatus.disconnected;

  void staticSocketStatus(dynamic data) { 
      print("Socket status: " + data); 
  } 

  void nodeListChatStatus(dynamic data  ) { 
      print("Socket status List: " + data);  
  } 
  
List<dynamic> listchatCurrent(){
  return listchat;

}
 
Future<SocketIO> ioConnection() async  {

  // return await manager.createInstance(SocketOptions('https://node-chat-flutter.herokuapp.com/'));
return socketManager.createSocketIO('https://node-chat-flutter.herokuapp.com/', '');
} 

StreamController openStream(){ 

  return  _streamController; 
}

StreamController openChatListStream(){ 

  return  _streamChatListController; 
}

StreamController openChatStream(){ 

  return  _streamChatController; 
}

StreamController openIdUserStream(){ 

  return  _streamIdAgentController; 
}

_socketInfo(data){
  print(data);
}
//conexion con el socket//
Future<void> nodeSetupSocketConnections() async {
 
  socketIO = SocketIOManager().createSocketIO('https://node-chat-flutter.herokuapp.com','/',query: "", socketStatusCallback: _socketInfo);
  //socket = ioConnection() as SocketIO;
  try{ 
    socketIO.disconnect();
      //print(socket.id);
socketIO.init();
// .then(_socketInfo((data){
// print(data);
// })); 

String id = socketIO.getId();
print(id);

// socketIO.subscribe("connect", (data)
// { 

// print(data);
// });

socketIO.subscribe("chat_message", nodeListChatStatus);
 
socketIO.subscribe("connect_listusers", (response)
{     
    Map<String, dynamic> data() => {
      'action' : 'add',
      'data' : response
    };
    var xx = jsonDecode(response);

    try{
      List<dynamic> _listData = xx;
      listchat = _listData;
      
    }catch(ex){
        print(ex);
    }
 
    _streamChatListController.add(data());
    
});

socketIO.subscribe("list_users", (response)
{     
   var user = jsonDecode(response);

   if(listchat.indexOf(user) < 0)
   { 
      listchat.add(user);
     
      Map<String, dynamic> data() => 
      {
        'action' : 'add',
        'data' : user
      };
    
    _streamController.add(data());


    print(data()); 
  }

    
});

socketIO.subscribe("private_message", (data)
{   
  var user = jsonDecode(data);
  if(user["from"] == chatCurrent)
  {
    _streamChatController.add(data);
  }
  //aqui colocar los mensajes para leer
    print(data); 
});

socketIO.subscribe('connect_user',(fnx){
   _streamIdAgentController.add(fnx);
   socketidAgent = fnx;
    print(fnx);
});

socketIO.subscribe("disconnect", (response){
  Map<String, dynamic> data() => {
      'action' : 'del',
      'data' : response
    };
    listchat.removeWhere((x)=> x["idSocket"]== response);
  _streamController.add(data());
  
});

// socketIO.subscribe("connect", (callback){
//    print(callback);
// });
socketIO.subscribe("reconnect", (callback){
   print(callback);
});
socketIO.connect()
.catchError((onError){
    print(onError);
});
       
      }catch(ex){
        print(ex);
      }
       
  }

   void nodeChatMessage(msj, to){ 
 
      MsjModel model = MsjModel(socketidAgent,to,msj); 
      
      String ff =to;
      
      var js =  jsonEncode(model.toJson()); 
      
      _streamChatController.add(js);

      socketIO.sendMessage("private_message",js, (data)
      { 
        print(data);
      })
      .catchError((onError){
        print(onError);
      }); 
     
  } 
}
