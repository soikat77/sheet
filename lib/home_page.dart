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
                const TopNeuCard(
                  balance: '200',
                  income: '15000',
                  expence: '14000',
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
                const PlusButton(),
              ],
            ),
          ),
        ));
  }
}
