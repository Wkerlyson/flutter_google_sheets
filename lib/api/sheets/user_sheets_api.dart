import 'package:gsheets/gsheets.dart';
import 'package:planilha_estudo/model/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserSheetsApi{
  static final _credentials = dotenv.get('sheet_credential');
  static final _spreadsheetId = dotenv.get('sheet_id');
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {

      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = UserFields().getFields();
      _userSheet!.values.insertRow(1, firstRow);
    }catch(e){
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
      required String title,
  }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if(_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

  static Future getRowCount() async {
    if(_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }
}