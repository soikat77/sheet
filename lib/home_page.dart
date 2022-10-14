import 'package:flutter/material.dart';
import 'package:sheet/plus_button.dart';
import 'package:sheet/top_card.dart';
import 'package:sheet/transactions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Column(
            children: [
              const TopNeuCard(
                balance: '200',
                income: '15000',
                expence: '14000',
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Transaction(
                          transaction: 'Bye a new t-shirt',
                          ammount: '200',
                          incomeOrExp: 'exp',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const PlusButton(),
            ],
          ),
        ));
  }
}
