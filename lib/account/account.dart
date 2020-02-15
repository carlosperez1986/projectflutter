import 'package:flutter/material.dart'; 
class AccountScreen extends StatefulWidget
{ 
  final Map<String, dynamic> data;
  final bool islogged; 
  final BuildContext contextLogin;

  AccountScreen({Key key, this.contextLogin, this.islogged, this.data}) : super(key: key);
    
  @override
  _AccountState createState()  => _AccountState(); 
}

class _AccountState extends State<AccountScreen> with TickerProviderStateMixin
{ 
  // AnimationController controller;
  // Animation<double> animation;

  @override
  void initState() { 
    super.initState();
    //   controller = AnimationController(
    //   duration: const Duration(milliseconds: 500),
    //   vsync: this,
    // );
    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);


    // controller.forward();
  }
  dispose() {
    // Es importante SIEMPRE realizar el dispose del controller.
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  { 
    //BuildContext contextLogin = widget.contextLogin;
    return new Scaffold( 
      body: Container(
        child:  Center(child:  
        Row(children: <Widget>[
           // AnimatedLogo(animation: animation), 
             Text("login ${ widget.islogged.toString()} ")
        ],)
       
      ),
    ));
  }
}
// class AnimatedLogo extends AnimatedWidget {
//   // Maneja los Tween estáticos debido a que estos no cambian.
//   static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
//   static final _sizeTween = Tween<double>(begin: 0.0, end: 100.0);

//   AnimatedLogo({Key key, Animation<double> animation})
//       : super(key: key, listenable: animation);

//   Widget build(BuildContext context) {
//     final Animation<double> animation = listenable;
//     return Opacity(

//       opacity: _opacityTween.evaluate(animation),
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.0),
//         height: _sizeTween.evaluate(animation), // Aumenta la altura
//         width: _sizeTween.evaluate(animation), // Aumenta el ancho
//         child: FlutterLogo(),
//       ),
//     );
//   }
// }