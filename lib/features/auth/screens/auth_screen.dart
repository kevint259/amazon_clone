import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = 'auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Text
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Create Account
            ListTile(
                // logic: if tile selects create account -> tile is white or else its grey
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Create Account.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                )),
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      // Name
                      CustomTextField(
                        controller: _nameController,
                        hintText: "Name",
                      ),
                      // sizedBox
                      const SizedBox(height: 10),
                      // email
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      // sizedBox
                      const SizedBox(height: 10),
                      // password
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Password",
                      ),
                      // sizedBox
                      const SizedBox(height: 10),
                      // sign-up button
                      CustomButton(text: "Sign Up", onTap: () {})
                    ],
                  ),
                ),
              ),
            // Sign-In
            ListTile(
              tileColor: _auth == Auth.signin ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Sign In.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      // email
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      // sizedBox
                      const SizedBox(height: 10),
                      // password
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Password",
                      ),
                      // sizedBox
                      const SizedBox(height: 10),
                      // sign-up button
                      CustomButton(text: "Sign In", onTap: () {})
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ));
  }
}
