import 'package:flutter/material.dart';
import 'package:planilha_estudo/model/user.dart';
import 'package:planilha_estudo/widget/button_widget.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({Key? key, required this.onSavedUser}) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late bool isBeginner;


  @override
  void initState() {
    super.initState();

    initUser();
  }

  void initUser(){
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    isBeginner = true;
  }

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildFlutterBeginner(),
            const SizedBox(height: 16),
            buildSubmit()
          ],
        ),
  );

  Widget buildName() => TextFormField(
        controller: controllerName,
        validator: (value) => value != null && value.isEmpty ? 'Enter name': null,
        decoration: const InputDecoration(
            labelText: 'Name', border: OutlineInputBorder()),
      );

  Widget buildEmail() => TextFormField(
        validator: (value) => value != null && !value.contains('@') ? 'Enter email ': null,
        controller: controllerEmail,
        decoration: const InputDecoration(
            labelText: 'E-mail', border: OutlineInputBorder()),
      );

  Widget buildFlutterBeginner() => SwitchListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: isBeginner,
        title: const Text('Is Flutter Beginner?'),
        onChanged: (value) => setState(() => isBeginner = value),
      );

  Widget buildSubmit() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if(isValid){
            final user = User(
              name: controllerName.text,
              email: controllerEmail.text,
              isBeginner: isBeginner
            );
            widget.onSavedUser(user);
          }
        },
      );
}
