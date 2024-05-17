import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Core/Constants/pallete.dart';
import '../Riverpod/providers.dart';
import '../Widgets/custom_elevated_button.dart';
import '../Widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.buttonColor,
      body: Consumer(
        builder: (context, ref, child) {
          final signInState = ref.watch(authNotifierProvider.notifier);
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
                      'LensLyfe',
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
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Sign In To',
                                style: TextStyle(
                                  color: Pallete.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sofia Pro',
                                  fontSize: 25,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' LensLyfe',
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
                            CustomButton(
                              buttonColor: Pallete.buttonColor,
                              text: 'Sign In',
                              textColor: Colors.white,
                              onPressed: () {
                                signInState.signInWithEmailPassword(
                                    _emailController.text,
                                    _passwordController.text);
                              },
                            ),
                            const SizedBox(
                              height: 16,
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
      ),
    );
  }
}
