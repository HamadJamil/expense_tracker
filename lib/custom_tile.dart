import 'package:expense_tracker/expense_screen.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.title,
    required this.createdAt,
    required this.emoji,
    this.onTap,
    required this.totalSpent,
    this.onDismissed,
    this.onLongPress,
  });
  final String title;
  final String createdAt;
  final String totalSpent;
  final String emoji;
  final Function()? onTap;
  final Function()? onDismissed;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExpenseScreen()),
          );
        },
        onLongPress: onLongPress,
        tileColor: Colors.grey.shade300,
        leading: CircleAvatar(
          child: Text(emoji, style: TextStyle(fontSize: 24)),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Total Spent : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  totalSpent,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Divider(),
            Text(
              'Created At : $createdAt',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
