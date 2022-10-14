import 'package:flutter/material.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expence;

  const TopNeuCard({
    super.key,
    required this.balance,
    required this.income,
    required this.expence,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        height: 250,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Text(
              'B A L A N C E',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              '\$ $balance',
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 36.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_upward,
                        size: 36,
                        color: Colors.green[600],
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'INCOME',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '\$ $income',
                          style: const TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'EXPENCE',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '\$ $expence',
                          style: const TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12.0),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_downward,
                        size: 36,
                        color: Colors.red[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
