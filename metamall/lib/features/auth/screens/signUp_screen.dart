import 'package:metamall/common/widgets/custom_textfield.dart';
import 'package:metamall/common/widgets/custom_button.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/auth/screens/signIn_screen.dart';
import 'package:metamall/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up-screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController;
    _passwordController;
    _nameController;
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void navigateToSignInScreen() {
   Navigator.pushNamed(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 160, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) =>
                      GlobalVariables.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Create a new',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Account',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            hintText: 'Full Name',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text('Already have an account?'),
                              SizedBox(
                                width: 0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateToSignInScreen();
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: GlobalVariables.secondaryColor),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 84,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: CustomButton(
                                text: 'Sign Up',
                                onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
