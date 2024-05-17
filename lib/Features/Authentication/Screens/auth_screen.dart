import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instadam_firebase/Features/Authentication/Screens/sign_up_screen.dart';
import '../../../Core/Constants/pallete.dart';
import '../Riverpod/providers.dart';
import '../Widgets/custom_elevated_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.bgColor,
        body: Consumer(
          builder: (context, ref, child) {
            final googleSignInState = ref.watch(authNotifierProvider.notifier);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 120.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'LensLyfe',
                          style: TextStyle(
                            fontSize: 35,
                            color: Pallete.primaryTextColor,
                            fontFamily: 'Sofia Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          height: 60,
                          'Assets/Images/camera.png',
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    style: TextStyle(
                      color: Pallete.primaryTextColor,
                      fontFamily: 'Sofia Pro',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    'Step into a realm where ',
                  ),
                  const Text(
                    style: TextStyle(
                      color: Pallete.primaryTextColor,
                      fontSize: 25,
                      fontFamily: 'Sofia Pro',
                      fontWeight: FontWeight.bold,
                    ),
                    'each frame speaks volumes',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonColor: Pallete.buttonColor,
                    text: 'Sign Up',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    buttonColor: Colors.transparent,
                    text: 'Sign Up with Google',
                    textColor: Pallete.primaryTextColor,
                    onPressed: () {
                      googleSignInState.googleSignIn();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Sofia Pro',
                      fontWeight: FontWeight.w400,
                    ),
                    'By Proccess you agree to the Privacy Policy',
                  ),
                  const Text(
                    style: TextStyle(
                      color: Pallete.secondaryTextColor,
                      fontFamily: 'Sofia Pro',
                      fontWeight: FontWeight.w400,
                    ),
                    'and Terms & Conditions',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
