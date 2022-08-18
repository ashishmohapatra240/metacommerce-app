import 'package:metamall/common/widgets/custom_textfield.dart';
import 'package:metamall/common/widgets/custom_button.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/auth/screens/signUp_screen.dart';
import 'package:metamall/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in-screen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Auth _auth = Auth.signin;
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController;
    _passwordController;
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void navigateToSignUpScreen() {
       Navigator.pushNamed(context, SignUpScreen.routeName);

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
                        'Login to your',
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
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
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
                              Text('Don\'t have an Account?'),
                              SizedBox(
                                width: 0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateToSignUpScreen();
                                  },
                                  child: Text(
                                    'Sign Up',
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
                                text: 'Sign In',
                                onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
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
