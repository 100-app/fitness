import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/home_screen.dart';
import 'package:fitness/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override 
  _LoginScreenState createState() => _LoginScreenState();
}
class SlideRightRoute extends PageRouteBuilder
 {  
   final Widget page;
    SlideRightRoute({required this.page}) : super(pageBuilder: (  
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    ) =>  page, transitionsBuilder: ( BuildContext context, 
    Animation<double> animation,
    Animation<double> secondaryAnimation, 
    Widget child, ) =>  SlideTransition(position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero,).animate(animation), child: child,),);
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty) {
          return ("Please enter your email");
        }
        
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return("Please enter a valid email");
        }

        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty) {
          return("Please enter your password");
        }

        if(!regex.hasMatch(value)) {
          return("Please enter valid password(Min. 6 Characters)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text("Login", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold),
          
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
         child: SingleChildScrollView (
           child: Container(
             color: Colors.white,
             child: Padding (
              padding: const EdgeInsets.all(36.0),
              child: Form(
              key: _formKey,
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset("assets/images/logo.png",
                    fit: BoxFit.contain,
                    )
                  ),
                  const SizedBox(height: 45),
                  emailField,
                  const SizedBox(height: 25),
                  passwordField,
                  const SizedBox(height: 35),
                  loginButton,
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () 
                        {
                          Navigator.push(context, 
                          SlideRightRoute(page: const RegistrationScreen()));
                        },
                        child: const Text("Sign Up", 
                        style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 15, color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
             ),
            
           )
          ),
        )
    );
  }
  //login function
  void signIn(String email, String password) async {
    if(_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((uid) => {
        Fluttertoast.showToast(msg: "Login Succesful"),
        Navigator.pushReplacement
          (context, SlideRightRoute(page: const HomeScreen()))
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    
    }
  }
}