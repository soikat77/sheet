import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  final String transactionName;
  final String ammount;
  final String incomeOrExp;
  const Transaction(
      {super.key,
      required this.transactionName,
      required this.ammount,
      required this.incomeOrExp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 50,
          color: Colors.grey[200],
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.paid,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        transactionName,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${incomeOrExp == 'expence' ? ' - ' : ' + '}\$ $ammount',
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          incomeOrExp == 'expence' ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
