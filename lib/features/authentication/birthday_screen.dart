import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_vm.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime initialDate = DateTime.now();
  String _birthday = '';

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    final state = ref.read(signUpFormProvider.notifier).state;
    ref.read(signUpFormProvider.notifier).state = {
      ...state,
      "birthday": _birthday,
    };
    ref.read(signUpProvider.notifier).signUp(context);
    // context.goNamed(InterestsScreen.routeName);
    // context.pushReplacementNamed(InterestsScreen.routeName);
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => const InterestsScreen(),
    //   ),
    //   (route) => false,
    // );
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthday = textDate;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Sign up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v36,
              const Text(
                'When is your birthday?',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                "Your birthday won't be shown publicly.",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black54,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _birthdayController,
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Birthday',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onNextTap,
                child:
                    FormButton(disabled: ref.watch(signUpProvider).isLoading),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: SizedBox(
          child: CupertinoDatePicker(
            maximumDate: initialDate,
            initialDateTime: initialDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
          ),
        ),
      ),
    );
  }
}
