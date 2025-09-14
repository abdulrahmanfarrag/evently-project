import 'package:evently_c16_sun/core/theme/app_colors.dart';
import 'package:evently_c16_sun/core/widgets/language_switch.dart';
import 'package:evently_c16_sun/data/firebase/firebase_auth_service.dart';
import 'package:evently_c16_sun/l10n/translations/app_localizations.dart';
import 'package:evently_c16_sun/ui/auth/register_screen.dart';
import 'package:evently_c16_sun/ui/home/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Logo.png",
                    width: MediaQuery.sizeOf(context).width * 0.3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email Can't be empty";
                } else if (!RegExp(
                  r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                ).hasMatch(value)) {
                  return "Enter Valid Email";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: localization.email,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: !passwordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password Can't be empty";
                } else if (!RegExp(
                  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                ).hasMatch(value)) {
                  return "Password Must Be Strong Password";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: localization.password,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // todo
                  },
                  child: Text(AppLocalizations.of(context)!.forgetPassword),
                ),
              ],
            ),
            SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                if (isLoading) return;
                if (formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    await FirebaseAuthService.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    Navigator.pushReplacementNamed(
                      context,
                      HomeScreen.routeName,
                    );
                  } catch (e) {
                    print(e);
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              },
              child:
                  isLoading
                      ? CircularProgressIndicator(color: AppColors.offWhite)
                      : Text(AppLocalizations.of(context)!.login),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.dontHaveAccount,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text(AppLocalizations.of(context)!.createAccount),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(AppLocalizations.of(context)!.or),
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google.png", height: 24),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.loginWithGoogle),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [LanguageSwitch()],
            ),
          ],
        ),
      ),
    );
  }
}
