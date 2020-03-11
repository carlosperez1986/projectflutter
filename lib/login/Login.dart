import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectflutter/account/account.dart';
import 'package:projectflutter/login/LoginLocalStorage.dart'; 

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool _isSelected = false;
  bool _islogged = false;

  LoginLocalStorage loginStorage = new LoginLocalStorage();
                            
  final txtUsuario = TextEditingController();
  final txtPassword = TextEditingController();
  
  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
    width: 16.0,
    height: 16.0,
    padding: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width: 2.0, color: Colors.black),
    ),
    child: isSelected
      ? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      )
      : Container(),
  );

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );
 
  String mensajeLogin;

 @override
 initState() { 
    super.initState();
    
    mensajeLogin = ""; 
 }
 @override
 void dispose() 
 {   
    txtUsuario.dispose();
    txtPassword.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    //verifica si ya esta logado
    bool islog = loginStorage.read();

    if(islog == true){
     Navigator.push(context, 
      MaterialPageRoute(
          builder: (context) => LoginLocalStorage(username: "1111", islogged: islog,),
            ),);
    }
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
 
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image.asset('assets/images/image_01.png')
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset('assets/images/image_02.png'),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 40.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text(
                        'LOGO',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: ScreenUtil.getInstance().setSp(46),
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  //inputs de usuario y password
                  Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(500),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 15.0),
            blurRadius: 15.0,
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, -10.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Acceso',
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(45),
                fontFamily: 'Poppins-Bold',
                letterSpacing: .6,
              )
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(
              'Usuario - email',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil.getInstance().setSp(26),
              )
            ),
            TextField( 
              controller: txtUsuario,
              decoration: InputDecoration(
                hintText: 'Usuario',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0 )
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text( 
              'Contraseña',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil.getInstance().setSp(26),
              )
            ),
            TextFormField(
               validator: (text) {
                    if (text.length == 0) {
                      return "Este campo contraseña es requerido";
                    } else if (text.length <= 4) {
                      return "Su contraseña debe ser al menos de 5 caracteres";
                    }  
                    return null;
                  },
              controller: txtPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                 icon: Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0 )
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Row(
              children: <Widget>[
                Text(mensajeLogin, style: TextStyle( color: Color.fromRGBO(255, 0, 0, .7), fontWeight: FontWeight.w600),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Recuperar Contraseña?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Poppins-Medium',
                    fontSize: ScreenUtil.getInstance().setSp(28),
                  )
                )
              ],
            )
          ],
        ),
      )
    ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(35),
                  ),
                  // Row(
                  //   children: <Widget>[  
                  //       Center(child: Text(_islogged == false ? "data":"", style: TextStyle( color: Color.fromRGBO(255, 0, 0, 1), ) ,) ,)                        
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: ScreenUtil.getInstance().setWidth(12.0),
                          ),
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),
                          SizedBox(
                            width: ScreenUtil.getInstance().setWidth(8.0),
                          ),
                          Text(
                            'recordar cuenta',
                            style: TextStyle(
                              fontSize: 12.0, fontFamily: 'Poppins-Medium',
                            )
                          ),
                        ],
                      ),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(300),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF17ead9), Color(0xFF6078ea)]
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF6078ea).withOpacity(.3),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0,
                              )
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () 
                              async {     
                                  String usuario  = txtUsuario.text.trimRight();
                                  String password  =  txtPassword.text.trimRight();

                                  if(usuario == "1111")
                                  {
                                      _islogged = true;

                                  }else{
                                      _islogged = false;
                                  }

                                  if(_islogged == false)
                                  { 
                                    setState(() 
                                    {
                                      mensajeLogin = "Este campo contraseña es requerido"; 
                                    }); 
                                  }
                                  else
                                  {      
                                        loginStorage.save(_islogged); 
                                                                        Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) => LoginLocalStorage(username: usuario, islogged: _islogged,),
                                                                          ),
                                                                        );  
                                                                      }
                                    
                                                                  },
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Acceder',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: 'Poppins-Bold',
                                                                        fontSize: 18.0,
                                                                        letterSpacing: 1.0
                                                                      )
                                                                    )
                                                                  )
                                                                )
                                                              )
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: ScreenUtil.getInstance().setHeight(40),
                                                      ),
                                                      // Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                                      //   children: <Widget>[
                                                      //     horizontalLine(),
                                                      //     Text(
                                                      //       'Social Login',
                                                      //       style: TextStyle(
                                                      //         fontSize: 16.0,
                                                      //         fontFamily: 'Poppins-Medium',
                                                      //       )
                                                      //     ),
                                                      //     horizontalLine(),
                                                      //   ],
                                                      // ),
                                                      // SizedBox(
                                                      //   height: ScreenUtil.getInstance().setHeight(40),
                                                      // ),
                                                      // Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                                      //   children: <Widget>[
                                                      //     SocialIcon(
                                                      //       colors: [
                                                      //         Color(0xFF102397),
                                                      //         Color(0xFF187adf),
                                                      //         Color(0xFF00eaf8),
                                                      //       ],
                                                      //       icondata: CustomIcons.facebook,
                                                      //       onPressed: () {},
                                                      //     ),
                                                      //     SocialIcon(
                                                      //       colors: [
                                                      //         Color(0xFFff4f38),
                                                      //         Color(0xFFff355d),
                                                      //       ],
                                                      //       icondata: CustomIcons.googlePlus,
                                                      //       onPressed: () {},
                                                      //     ),
                                                      //     SocialIcon(
                                                      //       colors: [
                                                      //         Color(0xFF17ead9),
                                                      //         Color(0xFF6078ea),
                                                      //       ],
                                                      //       icondata: CustomIcons.twitter,
                                                      //       onPressed: () {},
                                                      //     ),
                                                      //     SocialIcon(
                                                      //       colors: [
                                                      //         Color(0xFF00c6fb),
                                                      //         Color(0xFF005bea),
                                                      //       ],
                                                      //       icondata: CustomIcons.linkedin,
                                                      //       onPressed: () {},
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      SizedBox(
                                                        height: ScreenUtil.getInstance().setHeight(30),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text(
                                                            'Nuevo Usuario ?',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins-Medium'
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                               Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => AccountScreen(),
                                                                      ),
                                                                    );
                                                            },
                                                            child: Text(
                                                              'Crear',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins-Bold',
                                                                color: Color(0xFF5d74e3),
                                                              )
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                )
                                              ),
                                            ],
                                          )
                                        );
                                      }
                                    
     
}