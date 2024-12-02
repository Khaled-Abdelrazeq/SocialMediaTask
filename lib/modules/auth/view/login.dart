import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_task/globals/color.dart';
import 'package:social_media_task/modules/components/app_button.dart';
import 'package:social_media_task/modules/components/edit_text_form_field_with_label.dart';
import 'package:social_media_task/routes/routes_constants.dart';

import '../controller/bloc.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EditTextFormFieldWithLabel(
              textController: emailController,
              hintText: 'Email',
              label: 'Email',
            ),
            const SizedBox(height: 10),
            EditTextFormFieldWithLabel(
              textController: passwordController,
              hintText: 'Password',
              label: 'Password',
              obscureText: true,
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  context.go(RoutesConstants.homeView);
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is GotoSignupView) {
                  context.go(RoutesConstants.signup);
                }
              },
              builder: (context, state) {
                AuthBloc controller = context.read<AuthBloc>();
                return Column(
                  children: [
                    state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : AppButton(
                            onTap: () {
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              controller.add(
                                  LoginEvent(email: email, password: password));
                            },
                            label: 'Login',
                            height: 50,
                            borderRadius: 12,
                          ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => controller.add(CreateNewAccountTapped()),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Create new',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor)),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
