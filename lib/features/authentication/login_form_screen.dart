import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends StatelessWidget {
  LoginFormScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};
  bool _obscureText = true;

  void _onSubmitTap() {
    // if (_formKey.currentState != null) {
    //   _formKey.currentState!.validate();
    // }
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // onSaved
        _formKey.currentState!.save();
      }
    }
  }

  void _onClearTap() {}

  void _togglenObscureText() {
    _obscureText = !_obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                validator: (value) {
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                validator: (value) {
                  return null;
                },
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          size: Sizes.size16 + Sizes.size2,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _togglenObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: Sizes.size16 + Sizes.size2,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  hintText: 'Password',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['password'] = newValue;
                  }
                },
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmitTap,
                child: const FormButton(
                  disabled: false,
                  text: 'Log in',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
