import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_task/globals/app_enums.dart';
import 'package:social_media_task/modules/components/app_button.dart';
import 'package:social_media_task/modules/components/app_text.dart';

import '../../../globals/color.dart';
import '../../../routes/routes_constants.dart';
import '../../components/edit_text_form_field_with_label.dart';
import '../controller/bloc.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const AppText(
        text: 'Create new account',
        fontSize: 16,
        fontsWeight: FontsWeight.bold,
        textColor: Colors.black,
      )),
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
              textController: nameController,
              hintText: 'Username',
              label: 'Username',
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
                if (state is AuthAccountCreated || state is GotoLoginView) {
                  context.go(RoutesConstants.loginView);
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
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
                              final username = nameController.text.trim();
                              controller.add(CreateNewAccount(
                                email: email,
                                password: password,
                                username: username,
                              ));
                            },
                            label: 'Create',
                            height: 50,
                            borderRadius: 12,
                          ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => controller.add(OnLoginTapped()),
                      child: RichText(
                        text: TextSpan(
                          text: "You already have an account? ",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Login',
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
