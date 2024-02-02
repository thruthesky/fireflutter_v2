import 'package:fireship/fireship.dart';
import 'package:flutter/material.dart';

/// A simple email and password login form.
///
/// This widget is used to collect an email and password from the user and
/// then call the [onLogin] callback with the provided credentials.
///
/// There is only one button, "Login", which will call the [onLogin] callback
/// or the [onRegister] callback if provided.
///
/// If the [onRegister] callback is provided, [onLogin] will not be called when
/// the user registered.
///
class SimpleEmailPasswordLoginForm extends StatefulWidget {
  const SimpleEmailPasswordLoginForm({
    super.key,
    required this.onLogin,
    this.onRegister,
  });

  final void Function() onLogin;
  final void Function()? onRegister;

  @override
  State<SimpleEmailPasswordLoginForm> createState() =>
      _SimpleEmailPasswordLoginFormState();
}

class _SimpleEmailPasswordLoginFormState
    extends State<SimpleEmailPasswordLoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email"),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
        ),
        const SizedBox(height: 16),
        const Text("Password"),
        TextField(
          obscureText: true,
          controller: passwordController,
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              dog("Email: ${emailController.text}");
              dog("Password: ${passwordController.text}");

              if (emailController.text.trim().isEmpty) {
                throw FireshipException('input-email', 'Input email to login');
              } else if (passwordController.text.trim().isEmpty) {
                throw FireshipException(
                    'input-password', 'Input password to login');
              }

              final re = await loginOrRegister(
                email: emailController.text,
                password: passwordController.text,
              );
              if (widget.onRegister != null) {
                if (re.register) {
                  widget.onRegister!();
                } else {
                  widget.onLogin();
                }
              } else {
                widget.onLogin();
              }
            },
            child: const Text(' LOGIN '),
          ),
        ),
      ],
    );
  }
}
