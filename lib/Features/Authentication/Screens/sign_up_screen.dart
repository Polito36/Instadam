import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instadam_firebase/Features/Authentication/Screens/sign_in_screen.dart';
import '../../../Core/Constants/pallete.dart';
import '../Riverpod/providers.dart';
import '../Widgets/custom_elevated_button.dart';
import '../Widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.buttonColor,
        body: Consumer(
          builder: (context, ref, child) {
            final signUpState = ref.watch(authNotifierProvider.notifier);
            return SafeArea(
              child: Stack(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 60,
                        'Assets/Images/camera.png',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Instadam',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Pallete.bgColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: 'Sign Up To',
                                  style: TextStyle(
                                    color: Pallete.primaryTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 25,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' Instadam',
                                      style: TextStyle(
                                        color: Pallete.buttonColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Sofia Pro',
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomTextField(
                                controller: _emailController,
                                text: 'Enter Your Email',
                                obscureText: false,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: _passwordController,
                                text: 'Enter Your password',
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: _nameController,
                                text: 'Enter Your UserName',
                                obscureText: false,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CustomButton(
                                buttonColor: Pallete.buttonColor,
                                text: 'Sign Up',
                                textColor: Colors.white,
                                onPressed: () {
                                  signUpState.signUpWithEmailPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                    _nameController.text,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an Account?',
                                    style: TextStyle(
                                      color: Pallete.primaryTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInScreen(),
                                          ));
                                    },
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Pallete.buttonColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
