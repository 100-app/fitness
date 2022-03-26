import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
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

class _RegistrationScreenState extends State<RegistrationScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  //Controllers
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
     validator: (value) {
        RegExp regex = new RegExp(r'^.{1,}$');
        if(value!.isEmpty) {
          return("Please enter your firstname");
        }

        if(!regex.hasMatch(value)) {
          return("Please enter your name(Min. 2 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Firstname",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final seondnameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{1,}$');
        if(value!.isEmpty) {
          return("Please enter your secondname");
        }

        if(!regex.hasMatch(value)) {
          return("Please enter your secondname(Min. 2 Characters)");
        }

        return null;
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Secondname",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
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
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final confrimPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if(confirmPasswordEditingController.text.length > 5 && passwordEditingController.text != value) {
          return "Passwords do not match";
        }

        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final signupButton  = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text("Signup", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold),
          
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
                    height: 180,
                    child: Image.asset("assets/images/logo.png",
                    fit: BoxFit.contain,
                    )
                  ),
                  const SizedBox(height: 45),
                  firstnameField,
                  const SizedBox(height: 20),
                  seondnameField,
                  const SizedBox(height: 20),
                  emailField,
                  const SizedBox(height: 20),
                  passwordField,
                  const SizedBox(height: 20),
                  confrimPasswordField,
                  const SizedBox(height: 20),
                  signupButton,
                  const SizedBox(height: 15),
                
                ],
              ),
              ),
             ),
            
           )
          ),
        )
    );
  }

  void signUp(String email, String password) async
  {
    if(_formKey.currentState!.validate()) {

    }
  }
}