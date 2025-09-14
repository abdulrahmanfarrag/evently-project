import 'package:evently_c16_sun/core/theme/app_colors.dart';
import 'package:evently_c16_sun/core/widgets/language_switch.dart';
import 'package:evently_c16_sun/data/firebase/firebase_auth_service.dart';
import 'package:evently_c16_sun/l10n/translations/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;
  bool rePasswordVisible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localization.register)),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Logo.png",
                  width: MediaQuery.sizeOf(context).width * 0.3,
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name Can't be empty";
                } else if (!RegExp(r"^[a-zA-Z ]{2,50}$").hasMatch(value)) {
                  return "Enter Valid Name";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: localization.name,
                prefixIcon: Icon(Icons.person),
              ),
            ),
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
            SizedBox(height: 16),
            TextFormField(
              controller: rePasswordController,
              validator: (value) {
                if (value != passwordController.text) {
                  return "Password Doesn't Match";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: !rePasswordVisible,
              decoration: InputDecoration(
                hintText: localization.rePassword,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      rePasswordVisible = !rePasswordVisible;
                    });
                  },
                  child: Icon(
                    rePasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            FilledButton(
              onPressed: () async {
                if (isLoading) return;
                if (formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    await FirebaseAuthService.createAccountWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                    );
                    Navigator.pop(context);
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
                      : Text(localization.register),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: localization.dontHaveAccount,
                  children: [
                    TextSpan(text: "  "),
                    TextSpan(
                      text: localization.login,
                      style: Theme.of(context).textTheme.titleMedium,
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                    ),
                  ],
                ),
              ),
            ),
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
