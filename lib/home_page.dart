import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sheet/loading.dart';
import 'package:sheet/plus_button.dart';
import 'package:sheet/top_card.dart';
import 'package:sheet/transactions.dart';
import 'package:sheet/google_sheets_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // collect user input
  final _textcontrollerITEM = TextEditingController();
  final _textcontrollerAMOUNT = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // Send the transaction data to g sheet
  void _sendDatatoSheet() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }

  // add a new transaction
  void addTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Add New Transaction'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Expence'),
                        Switch(
                          value: _isIncome,
                          onChanged: (newValue) {
                            setState(
                              () {
                                _isIncome = newValue;
                              },
                            );
                          },
                        ),
                        const Text('Income'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Amount',
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter an Amount';
                                }
                                return null;
                              },
                              controller: _textcontrollerAMOUNT,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Transaction for what?',
                            ),
                            controller: _textcontrollerITEM,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    _textcontrollerAMOUNT.clear();
                    _textcontrollerITEM.clear();
                    Navigator.of(context).pop();
                  },
                  color: Colors.grey[400],
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendDatatoSheet();
                      _textcontrollerAMOUNT.clear();
                      _textcontrollerITEM.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  // waiting for fetching data from google sheet
  bool startTimer = false;
  void startLoading() {
    startTimer = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true && startTimer == false) {
      startLoading();
    }
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TopNeuCard(
                  balance: (GoogleSheetsApi.calculateIncome() -
                          GoogleSheetsApi.calculateExpencee())
                      .toString(),
                  income: GoogleSheetsApi.calculateIncome().toString(),
                  expence: GoogleSheetsApi.calculateExpencee().toString(),
                ),
                Expanded(
                  child: GoogleSheetsApi.loading == true
                      ? const LoadingData()
                      : Center(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: GoogleSheetsApi
                                      .currentTransactions.length,
                                  itemBuilder: (context, index) {
                                    return Transaction(
                                      transactionName: GoogleSheetsApi
                                          .currentTransactions[index][0],
                                      ammount: GoogleSheetsApi
                                          .currentTransactions[index][1],
                                      incomeOrExp: GoogleSheetsApi
                                          .currentTransactions[index][2],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                PlusButton(
                  function: addTransaction,
                ),
              ],
            ),
          ),
        ));
  }
}
