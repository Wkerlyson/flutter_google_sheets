import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:planilha_estudo/api/sheets/user_sheets_api.dart';
import 'package:planilha_estudo/pages/create_sheets_page.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Google Sheets API';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: CreateSheetsPage(),
    );
  }
}


