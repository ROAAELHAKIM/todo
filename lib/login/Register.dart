import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/home_screen.dart';

import '../my_provider.dart';

class RegisterTab extends StatefulWidget {

   RegisterTab({super.key});

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);

    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),

         // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "userName"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your userName';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: phoneController,
                  //obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "phone"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
          
          
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFunctions.createAccount(
                          username: userNameController.text,
                          email:   emailController.text,
                            password:  passwordController.text,
                           phone: phoneController.text,
                           onSuccess: (){
                             provider.initUser();
          
                             Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                            },
                            onError:(errorMessage){
                              showDialog(context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                return AlertDialog(
                                  title:  Text("Error"),
                                  content: Text("errorMessage"),
                                  actions: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("okey"))
                                  ],
                                );
          
                              },);
                            }
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill input')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
