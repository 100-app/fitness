import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/model/user_model.dart';
import 'package:fitness/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  final _auth = FirebaseAuth.instance;

  // form key
  final _formKey = GlobalKey<FormState>();

  //Controllers
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
     validator: (value) {
        RegExp regex = RegExp(r'^.{1,}$');
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
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.mail, color: Colors.white,),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email" ,
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide:  const BorderSide(color: Colors.white ),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide:  const BorderSide(color: Colors.red ),

        ),
      ),
    );

    final seondnameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{1,}$');
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
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.account_circle, color: Colors.white,),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Firstname" ,
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide:  const BorderSide(color: Colors.white ),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide:  const BorderSide(color: Colors.red ),

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
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.account_circle, color: Colors.white,),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Secondname" ,
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide:  const BorderSide(color: Colors.white ),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide:  const BorderSide(color: Colors.red ),

        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if(value!.isEmpty) {
          return("Please enter your password");
        }

        if(!regex.hasMatch(value)) {
          return("Please enter valid password(Min. 6 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.white,),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password" ,
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide:  const BorderSide(color: Colors.white ),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide:  const BorderSide(color: Colors.red ),

        ),
      ),
    );

    final confrimPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if(passwordEditingController.text != confirmPasswordEditingController.text) {
          return "Passwords do not match";
        }

        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.white,),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password" ,
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide:  const BorderSide(color: Colors.white ),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide:  const BorderSide(color: Colors.red ),

        ),
      ),
    );

    final signupButton  = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text("Create Account", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold),
          
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(15, 49, 49, 49),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      body: Center(
         child: SingleChildScrollView (
           child: Container(
             color: const Color.fromARGB(115, 49, 49, 49),
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
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
          postDetailsToFirestore()})
        .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
    }
  }

  postDetailsToFirestore() async {
    // calling firestore 
    // calling user model
    // sending values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = firstNameEditingController.text;
    userModel.secondname = secondNameEditingController.text;

    await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Has Been Created");

    Navigator.pushAndRemoveUntil((context), 
    MaterialPageRoute(builder: (context) => const HomeScreen()),
    (route) => false);
  }
}