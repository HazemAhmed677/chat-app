import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/constants.dart';
import 'package:scholar_chat_app/cubits/register/register_cubit.dart';
import 'package:scholar_chat_app/pages/chat.dart';
import 'package:scholar_chat_app/widgets/custom_Ink_well.dart';
import 'package:scholar_chat_app/widgets/custom_text_field.dart';
import 'package:scholar_chat_app/widgets/show_snow_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'Register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";
  String password = "";

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  AutovalidateMode autovalidateMode1 = AutovalidateMode.disabled;
  AutovalidateMode autovalidateMode2 = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          formKey.currentState!.reset();
        } else if (state is RegisterFaliure) {
          isLoading = false;
          showSnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          color: kPrimaryColor,
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 140,
                      ),
                      Center(
                        child: Image.asset(kLogo),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                        child: Text(
                          'Scholar Chat',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: [
                          Text(
                            'REGISTER',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        onChanged: (data) {
                          if (data.isEmpty) {
                            autovalidateMode1 = AutovalidateMode.disabled;
                            setState(() {});
                          } else {
                            autovalidateMode1 = AutovalidateMode.always;
                            setState(() {});
                          }
                          email = data;
                        },
                        autovalidateMode: autovalidateMode1,
                        hint: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        onChanged: (data) {
                          if (data.isEmpty) {
                            autovalidateMode2 = AutovalidateMode.disabled;
                            setState(() {});
                          } else {
                            autovalidateMode2 = AutovalidateMode.always;
                            setState(() {});
                          }
                          password = data;
                        },
                        autovalidateMode: autovalidateMode2,
                        hint: 'Password',
                        obsecure: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await BlocProvider.of<RegisterCubit>(context)
                                  .userRegister(
                                      email: email, password: password);
                            }
                          },
                          text: 'Register'),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an account ? ',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login ',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
