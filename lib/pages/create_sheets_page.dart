import 'package:flutter/material.dart';
import 'package:planilha_estudo/api/sheets/user_sheets_api.dart';
import 'package:planilha_estudo/main.dart';
import 'package:planilha_estudo/model/user.dart';
import 'package:planilha_estudo/widget/button_widget.dart';

import '../widget/user_form_widget.dart';

class CreateSheetsPage extends StatelessWidget {
  const CreateSheetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: UserFormWidget(
              onSavedUser: (user) async {
                final id = await UserSheetsApi.getRowCount() + 1;
                final newUser = user.copy(id: id);

                await UserSheetsApi.insert([newUser.toJson()]);
              },
            ),
          ),
        ),
      );
}
