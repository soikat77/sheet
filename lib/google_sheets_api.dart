import 'package:gsheets/gsheets.dart';
import 'package:sheet/home_page.dart';

class GoogleSheetsApi {
  // create credential for gsheets
  static const _credentials = r'''
    {
      "type": "service_account",
      "project_id": "sheet-365416",
      "private_key_id": "4916eb906c75f67fcd54c8696bc80a8b43e6a045",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDg7gdlmXIbS89q\nLj6TFrpAA4h6OXU34I2OmR8m0oJYapwtAIEa5JaBRv3vmcvqTe5v7a/kiirmrEur\n1nceZEBkV+8RGrc9MYNjzxk6i49U3C+YctvfptJvgh9y1nVY6+no8XJZH8rRPPnb\np8x7GyoEJrFjqxPiJrmfhIbz1TQoF0k8JyrMiwjPSynABnFPWY7rFIpNSfKfbaO3\nydlE3vP7odppWKH073sKFh/cAb7KXQTXm70sgLou56whjl7vONsh80xbyNTtwGKk\nIX3K+4X07LQp4BF/LBsxoCPjhzDkgUwT7soQh6Bh6Qt6ClacQBuKVn0R++iaU9Rp\nQ2/lVJ87AgMBAAECggEAJcPhSw4x6eJXH1lHWVPiDphpRDg8dZbGva/42oBSsTyp\nHycsBhNmL6t3PFDiu2K9S16pfyIxpMw94kqecmRbqV1YPtNw+53CFTJy5nEDLjjP\n5vU19H2ibGV5GUNnrXfirKFJVSxw1aO6wcYRH4RGkC7c7sKNEpX06ZMLQ4pC+Q3r\nNZgsXouthxuwVLXPItm2YYQJNtYlwM8/bnBV8iWLbvlIZOdU67GvKsc+6rV0DTim\nts0qbNfNPSGwowUpcr6jBe2zL7d0Qfcq42nLShZtFBBtMxMzcSCUQ3K8863fpga7\n+uOAp4JpvsgTKrvXCXP16PAqMCnSiP4zbo9iTXcl+QKBgQD4cu+YEnCV5shaEg0i\nWe3hgtmB0uvMa+ABnUgaW1TJr7o1cusXwQVAaPUGX4YvcSD7Puw9txMbyj721+ZI\nfeUtjvHSTOp131GFIT/kA8CJumYYyHgvuYjqignLThUINVB1voEr7k522k4cq9cf\n/ZW/1WR/jtHS43Q8CMbIKqCqSQKBgQDnxBn4B93XSp2mMyoiYOvsDiwmS6SAYPeW\n65MOzkjbiv7R2UVsQnz9a1GRfWeXnYZxBgYTE7Vj7dJG7HvQgmDc/Mm6+154hatq\nq/asozXuzgQm8vqvi9KYf6/tt2feNuB6iZnhBW5OUb0Qc5rOu7lSLpkRONrNuV5z\nfstXeqSdYwKBgGPz6YxmrsC/7g6+gGY3g8pcGCFwt8iwBZjgq+deowfZGLL0HryZ\nvQEiuKDtwVBI1Rn/QI+7nYZqoVYxmcXEUHU5svQGWbU+OM+0hr22/LjsMrL5w9B/\ndiPVkQcnzLJWsJ4OHG2OHCcYwKAsSgnmvV5F/X6L+MI9G8AjT8Wr0KNxAoGBAImL\nmhXXJVMV10XBa6oHdzwalR0NG02NPqL0n8vTpO2WKfCET20WcHM9c6UylX4nYJhH\nCOfddHMfuwGYa0qtdarw4w/zCnfgbIDcGYMPQXy+CzzKSvhPtOYIMXKUvDHmw4Y1\nj3s56+LTI69VzHQQeMVLHlBYO5KIBoPopej+wh8dAoGAXpOzDR9AmXTF4hieVRol\nqxEtjeQoHRzNQaZ+DNrxByRNxPTbDWK50R1e1EoQqRqMX7ujswaTsS2MPeeMCi1C\n//oKEv8/Yvbyqu4MYL/njTlCe1JYsmJ1FCs4vuV/5YAYjyAJiEEvPDGoEQpwKbwU\nrwg64ch5zex7cLPTC+KKtvg=\n-----END PRIVATE KEY-----\n",
      "client_email": "sheet-129@sheet-365416.iam.gserviceaccount.com",
      "client_id": "113793067159272389566",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sheet-129%40sheet-365416.iam.gserviceaccount.com"
    }
  ''';

  // set up & connect google sheets

  // get speadsheets id
  static const _spreadsheetId = '1YFKXMO_FCEs2m4B9m5aVTPAmGQYaCc-JatAq4cMLwt4';

  // init gsheets
  static final _gsheets = GSheets(_credentials);

  // declare worksheet by title
  static Worksheet? _worksheet;

  // keeping track of
  static int transactionCount = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // init spreadsheet
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('summery');
    countRow();
  }

  // count the number of Row
  static Future countRow() async {
    while ((await _worksheet!.values
            .value(column: 1, row: transactionCount + 1)) !=
        '') {
      transactionCount++;
    }
    // thats how we know how many transaction are made
    loadTransaction();
  }

  // load existins transaction from the spreadsheet
  static Future loadTransaction() async {
    if (_worksheet == null) return;

    for (int i = 1; i < transactionCount; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < transactionCount) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    // stop the loading indicator
    loading = false;
  }

  // insert new transaction into the sheet
  static Future insert(String name, String amount, bool isIncome) async {
    if (_worksheet == null) return;
    transactionCount++;
    currentTransactions.add([
      name,
      amount,
      isIncome == true ? 'income' : 'expence',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      isIncome == true ? 'income' : 'expence',
    ]);
  }

  // calculate total income
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // calculate total expence
  static double calculateExpencee() {
    double totalExp = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expence') {
        totalExp += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExp;
  }
}
